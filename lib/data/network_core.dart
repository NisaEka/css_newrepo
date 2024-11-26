import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/data/repository/auth/auth_impl.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flavor/flutter_flavor.dart';
import 'model/auth/post_login_model.dart';
import 'storage_core.dart';

class NetworkCore {
  static final noNeedToken = ['/login'];

  static bool isNeedToken(String route) => !noNeedToken.contains(route);

  Dio city = Dio();
  Dio jne = Dio();
  Dio myJNE = Dio();
  Dio local = Dio();
  Dio base = Dio();

  NetworkCore() {
    base.options = BaseOptions(
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
      InterceptorsWrapper(onRequest: (options, handler) async {
        AppLogger.i('Option path ${options.path}');
        if (isNeedToken(options.path)) {
          final accessToken = await StorageCore().readAccessToken();
          // final refreshToken = await storage.readRefreshToken();
          options.headers = {
            ...options.headers,
            'Authorization': 'Bearer $accessToken'
          };
        }
        return handler.next(options);
      }, onResponse: (response, handler) {
        if (kDebugMode) {
          AppLogger.d("response : $response");
        }
        return handler.next(response);
      }, onError: (dioError, handler) async {
        AppLogger.e("dio error : $dioError");
        if (dioError.response?.statusCode == 401) {
          // If a 401 response is received, refresh the access token
          await refreshToken();
          final String? newAccessToken = await StorageCore().readAccessToken();

          // Update the request header with the new access token
          dioError.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          // Repeat the request with the updated header
          return handler.resolve(await base.fetch(dioError.requestOptions));
        }
        return handler.next(dioError);
      }),
    );
  }

  Future<void> refreshToken() async {
    await AuthRepositoryImpl().postRefreshToken().then((value) async {
      AppLogger.i('refresh token : ${value.data?.token?.refreshToken}');

      StorageCore().saveToken(
        value.data?.token?.accessToken ?? '',
        value.data?.menu ?? MenuModel(),
        value.data?.token?.refreshToken ?? '',
      );
    });
  }
}

// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = ((X509Certificate cert, String host, int port) {
//         final isValidHost = ["38.47.76.138"].contains(host);
//         return isValidHost;
//       });
//   }
// }
