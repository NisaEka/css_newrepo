import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUmumController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  CcrfProfileModel? ccrfProfil;
  UserModel? basicProfil;
  bool isCcrf = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      String? token = await storage.readAccessToken();
      debugPrint("token : $token");
      isLogin = token != null;
      await profil
          .getBasicProfil()
          .then((value) => basicProfil = value.data?.user);
      update();
      await profil.getCcrfProfil().then((value) {
        if (value.data != null) {
          ccrfProfil = value.data;
        } else {
          ccrfProfil ??= CcrfProfileModel(
            generalInfo: GeneralInfo(
              ccrfName: basicProfil?.name,
              ccrfBrand: basicProfil?.brand,
              ccrfAddress: basicProfil?.address,
              ccrfEmail: basicProfil?.email,
              ccrfPhone: basicProfil?.phone,
            ),
          );
        }

        isCcrf = true;
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();

      var basic =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));

      ccrfProfil = CcrfProfileModel(
        generalInfo: GeneralInfo(
          ccrfName: basic.name,
          ccrfBrand: basic.brand,
          ccrfAddress: basic.address,
          ccrfEmail: basic.email,
          ccrfPhone: basic.phone,
        ),
      );
    }

    isLoading = false;
    update();
  }
}
