import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'storage_core.dart';

class NetworkCore {
  static final noNeedToken = [
    '/login',
    '/auth/device-infos',
    '/authentications/refresh',
    '/authentications/logout',
  ];

  static bool isNeedToken(String route) => !noNeedToken.contains(route);

  Dio city = Dio();
  Dio jne = Dio();
  Dio myJNE = Dio();
  Dio local = Dio();
  Dio base = Dio();
  Dio refreshDio = Dio();

  NetworkCore() {
    base.options = BaseOptions(
      baseUrl: AppConst.base,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    refreshDio.options = BaseOptions(
      baseUrl: AppConst.base,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    local.options = BaseOptions(
      baseUrl: "http://192.168.10.220:3001",
      // baseUrl: "http://10.0.2.2:3000",
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    city.options = BaseOptions(
      baseUrl: AppConst.cityUrl,
      headers: {
        // 'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    jne.options = BaseOptions(
      baseUrl: AppConst.jneUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    myJNE.options = BaseOptions(
      baseUrl: AppConst.myJneUrl,
      headers: {
        // 'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    String env = FlavorConfig.instance.name ?? "PROD";
    if (env != "PROD") {
      base.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
      city.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
      jne.interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));
    }
    base.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          AppLogger.i('Option path ${options.path}');
          // Skip attaching token if `useAuth` is false
          if (options.extra['skipAuth'] == false ||
              options.extra['skipAuth'] == null) {
            final accessToken = await StorageCore().readAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
            }
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            AppLogger.d("kDebugMode response : $response");
          }
          return handler.next(response);
        },
        onError: (dioError, handler) async {
          AppLogger.e("dio error : $dioError");
          // if (dioError.response == null) {
          //   AppSnackBar.error("Connection timeout");
          // }
          final refreshToken = await StorageCore().readRefreshToken();
          AppLogger.i("refresh token local : $refreshToken");
          // if ((dioError.requestOptions.path != '/auth/device-infos') || (dioError.requestOptions.path != '/authentications/refresh')) {
          if (noNeedToken
              .where((e) => e != dioError.requestOptions.path)
              .isNotEmpty) {
            if (dioError.response?.statusCode == 401) {
              // Handle token refresh logic
              if (refreshToken != null) {
                try {
                  Response response = await refreshDio.post(
                    '/authentications/refresh',
                    data: {
                      "refreshToken": refreshToken,
                    },
                    options: Options(extra: {'skipAuth': true}),
                  );

                  final newToken = BaseResponse<PostLoginModel>.fromJson(
                    response.data,
                    (json) => PostLoginModel.fromJson(
                      json as Map<String, dynamic>,
                    ),
                  );

                  await StorageCore().saveToken(
                    newToken.data?.token?.accessToken,
                    newToken.data?.menu ?? MenuModel(),
                    newToken.data?.token?.refreshToken,
                  );

                  // Update the request header with the new access token
                  dioError.requestOptions.headers['Authorization'] =
                      'Bearer ${newToken.data?.token?.accessToken}';
                  AppLogger.i("new token : $newToken");
                  // Repeat the request with the updated header
                  return handler
                      .resolve(await base.fetch(dioError.requestOptions));
                } on DioException catch (e) {
                  AppLogger.e(
                      "refresh token error status code : ${e.response?.statusCode}");
                  AppLogger.e("refresh token error  : ${e.response?.data}");
                  // if (e.response?.statusCode == 401) {
                  //   StorageCore().deleteLogin();
                  //   Get.offAll(const DashboardScreen());
                  // }
                  return handler.reject(dioError);
                }
              }
            }
          }

          return handler.next(dioError);
        },
      ),
    );
  }
}
