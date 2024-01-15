import 'dart:convert';
import 'dart:io';

import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AuthRepositoryImpl extends AuthRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<LoginModel> postLogin(
    String username,
    String password,
    InputLoginModel loginData, {
    String? accessToken,
    String? refreshToken,
    String? email,
  }) async {
    print(jsonEncode(loginData));
    try {
      Response response = await network.dio.post(
        '/api/login',
        data: loginData,
      );
      return LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      // debugPrint("error login : ${LoginModel.fromJson(e?.response?.data)}");
      //print("response error: ${e.response?.data}");
      return e.response?.data!;
    }
  }
}
