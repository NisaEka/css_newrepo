import 'dart:async';
import 'dart:io';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/data/model/auth/auth_body_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response;
import 'repository/auth/auth_repository.dart';
import 'storage_core.dart';

class NetworkCore {
  Dio base = Dio();
  Dio refreshDio = Dio();

  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;

  Future<String> _getLocale() async {
    final storage = Get.find<StorageCore>();
    return await storage.readString(StorageCore.localeApp);
  }

  Future retryRequests(token) async {
    final locale = await _getLocale();

    for (var i = 0; i < failedRequests.length; i++) {
      RequestOptions requestOptions = failedRequests[i]['err'].requestOptions as RequestOptions;
      AppLogger.i("retry request ${requestOptions.method} ${requestOptions.path}");

      requestOptions.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        "Accept-Language": locale,
      };

      await refreshDio.fetch(requestOptions).then(
        failedRequests[i]['handler'].resolve,
        onError: (error) async {
          failedRequests[i]['handler'].reject(error as DioException);
        },
      );
    }

    isRefreshing = false;
    failedRequests = [];
  }

  FutureOr postRefreshToken(DioException err, ErrorInterceptorHandler handler) async {
    AppLogger.d("running refresh token");
    final refreshToken = await StorageCore().readRefreshToken();
    AppLogger.i("get refresh token from local : $refreshToken");
    final auth = Get.find<AuthRepository>();

    try {
      Response response = await base.post('/authentications/refresh',
          data: AuthBodyModel(
            refreshToken: refreshToken,
            device: await auth.getDeviceinfo(/*state.fcmToken ?? ''*/),
            coordinate: await auth.getCurrentLocation(),
          )
          // data: {
          //   "refreshToken": refreshToken,

          // },
          );

      final refreshTokenResponse = BaseResponse<PostLoginModel>.fromJson(
        response.data,
        (json) => PostLoginModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );

      await StorageCore().saveToken(
        refreshTokenResponse.data?.token?.accessToken,
        refreshTokenResponse.data?.menu ?? MenuModel(),
        refreshTokenResponse.data?.token?.refreshToken,
      );

      failedRequests.add({'err': err, 'handler': handler});

      await retryRequests(refreshTokenResponse.data?.token?.accessToken);

      return refreshTokenResponse;
    } on DioException catch (e) {
      AppLogger.e("Failed refresh token");

      StorageCore().deleteLogin();
      Get.delete<DashboardController>().then((_) => Get.offAll(() => const DashboardScreen()));

      return BaseResponse<PostLoginModel>.fromJson(
        e.response?.data,
        (json) => PostLoginModel.fromJson(
          json as Map<String, dynamic>,
        ),
      );
    } finally {
      isRefreshing = false;
    }
  }

  Future<void> _init() async {
    AppLogger.i("👉 Start NetworkCore _init");
    AppLogger.i("Base URL: ${AppConst.base}");

    try {
// final certData = await rootBundle.loadString("assets/cert/client.crt");
      // final keyData = await rootBundle.loadString("assets/cert/client.key");
      // final caData = await rootBundle.loadString("assets/cert/ca.crt");
      final pem = await rootBundle.load('assets/cert/client.pem');
      final pemBytes = pem.buffer.asUint8List();

      // final tempDir = Directory.systemTemp;
      // final certFile = File('${tempDir.path}/client.crt')..writeAsStringSync(certData);
      // final keyFile = File('${tempDir.path}/client.key')..writeAsStringSync(keyData);
      // final caFile = File('${tempDir.path}/ca.crt')..writeAsStringSync(caData);

      final context = SecurityContext(withTrustedRoots: true);
      context.setTrustedCertificatesBytes(pemBytes); // ← Memasang CA dari file .pem

      final httpClient = HttpClient(context: context);
      httpClient.badCertificateCallback = (cert, host, port) {
        return true;
      };

      (base.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () => httpClient;

      base.options = BaseOptions(
        baseUrl: AppConst.base,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        connectTimeout: const Duration(seconds: 30),
      );

      AppLogger.i("Base URL base: ${base.options.baseUrl}");

      // final securityContext = SecurityContext(withTrustedRoots: true);
      // securityContext.useCertificateChain(certFile.path);
      // securityContext.usePrivateKey(keyFile.path);
      // securityContext.setTrustedCertificates(caFile.path);
      //
      // (base.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      //   final httpClient = HttpClient(context: securityContext);
      //   if (FlavorConfig.instance.name == "PROD") {
      //     httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => false; // Reject self-signed certs in production
      //   } else {
      //     httpClient.badCertificateCallback = (X509Certificate cert, String host, int port) => true; // Accept self-signed certs in dev
      //   }
      //   return httpClient;
      // };

      refreshDio.options = BaseOptions(
        baseUrl: AppConst.base,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      );
      String env = FlavorConfig.instance.name ?? "PROD";
      if (env != "PROD") {
        base.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
        refreshDio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      }

      base.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) async {
            final locale = await _getLocale();

            // AppLogger.i('Option path ${options.method} ${options.path}\n${options.queryParameters}');

            // Skip attaching token if `useAuth` is false
            if (options.extra['skipAuth'] == false || options.extra['skipAuth'] == null) {
              final accessToken = await StorageCore().readAccessToken();
              if (accessToken != null) {
                options.headers['Authorization'] = 'Bearer $accessToken';
                // options.headers['Authorization'] = 'Bearer ';
              }
            }

            options.headers['Accept-Language'] = locale;

            return handler.next(options);
          },
          onResponse: (response, handler) {
            if (kDebugMode) {
              debugPrint(
                  "kDebugMode response : [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.path} \n${response.requestOptions.queryParameters} \n$response");
            }
            return handler.next(response);
          },
          onError: (dioError, handler) async {
            if (dioError.requestOptions.path != "/auth/device-infos ") {
              AppLogger.e("dio error : ${dioError.requestOptions.method} ${dioError.requestOptions.path} ${dioError.response ?? dioError} ");
            }

            // ===== FAILOVER BASE URL =====
            // final isConnectionError = dioError.type == DioExceptionType.connectionError && dioError.error.toString().contains("Failed host lookup");
            //
            // final alreadyRetried = dioError.requestOptions.extra['retried'] == true;
            //
            // if (isConnectionError && !alreadyRetried) {
            //   AppLogger.w("Primary base down, retry with fallback");
            //
            //   final options = dioError.requestOptions;
            //   options.extra['retried'] = true;
            //
            //   final fallbackBase = AppConst.baseFallback;
            //   final fallbackUri = Uri.parse(fallbackBase);
            //
            //   final newUri = options.uri.replace(
            //     scheme: fallbackUri.scheme,
            //     host: fallbackUri.host,
            //     port: fallbackUri.port,
            //   );
            //
            //   options.baseUrl = fallbackBase;
            //   options.path = newUri.path;
            //
            //   try {
            //     final response = await base.fetch(options);
            //     return handler.resolve(response);
            //   } catch (e) {
            //     return handler.reject(e as DioException);
            //   }
            // }

            // ===== REFRESH TOKEN  =====

            final refreshToken = await const FlutterSecureStorage().read(key: StorageCore.refreshToken);
            // AppLogger.i("refresh token local : $refreshToken");

            if (dioError.response?.statusCode == 401) {
              if (refreshToken == null) {
                AppLogger.w("refresh token local kosong");
                return handler.reject(dioError);
              }
              if (!isRefreshing) {
                isRefreshing = true;

                final refreshTokenResponse = await postRefreshToken(dioError, handler);

                AppLogger.i("refresh token Success");

                if (refreshTokenResponse.code == 401) {
                  return handler.reject(dioError);
                }
              } else {
                AppLogger.w("failed request \n${dioError.requestOptions.method} ${dioError.requestOptions.path} ${dioError.response}");
                failedRequests.add({'err': dioError, 'handler': handler});
              }
            } else {
              // AppLogger.w("failed ${dioError.requestOptions.method} ${dioError.requestOptions.path} ${dioError.response}");
              return handler.next(dioError);
            }
          },
        ),
      );
    } catch (e, st) {
      AppLogger.e("❌ Error in NetworkCore _init: $e");
      FirebaseCrashlytics.instance.recordError(e, st);
    }
  }

  NetworkCore(); // constructor tidak lagi menjalankan _init()

  Future<void> init() async {
    await _init();
  }
}
