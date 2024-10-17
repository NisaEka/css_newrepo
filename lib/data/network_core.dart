import 'package:css_mobile/const/app_const.dart';
import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class NetworkCore {
  Dio dio = Dio();
  Dio city = Dio();
  Dio jne = Dio();
  Dio myJNE = Dio();
  Dio local = Dio();
  Dio base = Dio();

  NetworkCore() {
    dio.options = BaseOptions(
      baseUrl: AppConst.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

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
      dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      city.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
      jne.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
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
