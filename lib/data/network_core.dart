import 'package:css_mobile/const/app_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class NetworkCore {
  Dio dio = Dio();
  Dio tarif = Dio();
  Dio tracing = Dio();
  Dio reference = Dio();

  NetworkCore() {
    dio.options = BaseOptions(
      baseUrl: AppConst.baseUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    tarif.options = BaseOptions(
      baseUrl: AppConst.tarifUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        // 'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    tracing.options = BaseOptions(
      baseUrl: AppConst.tracingUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
        'User-Agent': 'php-request',
      },
    );

    reference.options = BaseOptions(
      baseUrl: AppConst.referenceUrl,
      connectTimeout: 20000,
      receiveTimeout: 20000,
      sendTimeout: 20000,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );

    String env = FlavorConfig.instance.name ?? "PROD";
    if (env != "PROD") {
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      tarif.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      tracing.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      reference.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    }
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
