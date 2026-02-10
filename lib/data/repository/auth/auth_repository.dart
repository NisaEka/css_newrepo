import 'dart:io';

import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/pin_confirm_model.dart';
import 'package:css_mobile/data/model/auth/auth_body_model.dart';
import 'package:css_mobile/data/model/auth/input_new_password_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/input_register_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/master/apps_info_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

abstract class AuthRepository {
  Future<BaseResponse<PostLoginModel>> postLogin(AuthBodyModel loginData);

  Future<BaseResponse> postRegister(InputRegisterModel data);

  Future<BaseResponse> postRegistPinConfirm(InputPinconfirmModel data);

  Future<BaseResponse> postRegistPinResend(InputPinconfirmModel data);

  Future<BaseResponse> postEmailForgotPassword(String email);

  Future<BaseResponse<PinConfirmModel>> postPasswordPinConfirm(InputPinconfirmModel data);

  Future<BaseResponse> postPasswordChage(InputNewPasswordModel data);

  Future<BaseResponse> postFcmToken(DeviceInfoModel data);

  Future<BaseResponse> postFcmTokenNonAuth(DeviceInfoModel data);

  Future<BaseResponse<List<DeviceInfoModel>>> getFcmToken();

  Future<BaseResponse> logout(AuthBodyModel refreshToken);

  Future<BaseResponse> updateDeviceInfo(DeviceInfoModel data);

  Future<BaseResponse<PostLoginModel>> updateToken();

  Future<BaseResponse<List<AppsInfoModel>>> getAppsInfos(QueryModel? param);

  Future<Coordinate> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, lng: position.longitude);
  }

  Future<DeviceInfoModel?> getDeviceinfo() async {
    var token = await StorageCore().readString(StorageCore.fcmToken);
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var systemName = iosDeviceInfo.systemName;
      var version = iosDeviceInfo.systemVersion;

      return DeviceInfoModel(
        fcmToken: token,
        deviceId: iosDeviceInfo.identifierForVendor,
        deviceOS: '$systemName $version',
        deviceName: iosDeviceInfo.name,
        deviceBrand: systemName,
        deviceModel: iosDeviceInfo.model,
      );
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var release = androidDeviceInfo.version.release;
      print("device info = ${androidDeviceInfo.model}");
      return DeviceInfoModel(
        fcmToken: token,
        deviceId: androidDeviceInfo.id,
        deviceOS: 'Android $release',
        deviceName: '${androidDeviceInfo.brand.capitalizeFirst} ${androidDeviceInfo.product}',
        deviceBrand: androidDeviceInfo.brand,
        deviceModel: androidDeviceInfo.model,
      );
    }
    return null;
  }
}
