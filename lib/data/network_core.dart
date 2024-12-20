import 'dart:async';
import 'dart:convert';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:get/get.dart' hide Response;
import 'storage_core.dart';

class NetworkCore {
  Dio city = Dio();
  Dio jne = Dio();
  Dio myJNE = Dio();
  Dio local = Dio();
  Dio base = Dio();
  Dio refreshDio = Dio();

  List<Map<dynamic, dynamic>> failedRequests = [];
  bool isRefreshing = false;

  Future retryRequests(token) async {
    for (var i = 0; i < failedRequests.length; i++) {
      RequestOptions requestOptions =
          failedRequests[i]['err'].requestOptions as RequestOptions;

      requestOptions.headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
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

  FutureOr postRefreshToken(
      DioException err, ErrorInterceptorHandler handler) async {
    final refreshToken = await StorageCore().readRefreshToken();
    AppLogger.i("refresh token local : $refreshToken");

    try {
      Response response = await refreshDio.post(
        '/authentications/refresh',
        data: {
          "refreshToken": refreshToken,
        },
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
      AppLogger.i("masuk sini catch atas");

      StorageCore().deleteLogin();
      Get.delete<DashboardController>()
          .then((_) => Get.offAll(() => const DashboardScreen()));

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
      refreshDio.interceptors
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

          final refreshToken = await StorageCore().readRefreshToken();
          AppLogger.i("refresh token local : $refreshToken");

          if (dioError.response?.statusCode == 401) {
            if (refreshToken == null) {
              return handler.reject(dioError);
            }
            if (!isRefreshing) {
              isRefreshing = true;

              final refreshTokenResponse =
                  await postRefreshToken(dioError, handler);

              AppLogger.i(
                  "refresh token response : ${jsonEncode(refreshTokenResponse)}");

              if (refreshTokenResponse.code == 401) {
                return handler.reject(dioError);
              }
            } else {
              failedRequests.add({'err': dioError, 'handler': handler});
            }
          } else {
            return handler.next(dioError);
          }
        },
      ),
    );
  }
}
