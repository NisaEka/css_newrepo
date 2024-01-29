import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class AuthRepositoryImpl extends AuthRepository {
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  Future<LoginModel> postLogin(InputLoginModel loginData) async {
    try {
      Response response = await network.dio.post(
        '/auth/login',
        data: loginData,
      );
      return LoginModel.fromJson(response.data);
    } on DioError catch (e) {

      return e.response?.data!;
    }
  }
}
