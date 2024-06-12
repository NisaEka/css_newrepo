import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataUmumController extends BaseController {
  bool isLogin = false;
  bool isLoading = false;

  CcrfProfilModel? ccrfProfil;
  BasicProfilModel? basicProfil;
  bool isCcrf = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      String? token = await storage.readToken();
      debugPrint("token : $token");
      isLogin = token != null;
      await profil.getBasicProfil().then((value) => basicProfil = value.payload);
      update();
      await profil.getCcrfProfil().then((value) {
        if (value.payload != null) {
          ccrfProfil = value.payload;
        } else {
          ccrfProfil ??= CcrfProfilModel(
            generalInfo: GeneralInfo(
              name: basicProfil?.name,
              brand: basicProfil?.brand,
              address: basicProfil?.address,
              email: basicProfil?.email,
              phone: basicProfil?.phone,
            ),
          );
        }

        isCcrf = true;
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();

      var basic = BasicProfilModel.fromJson(await storage.readData(StorageCore.userProfil));

      ccrfProfil = CcrfProfilModel(
        generalInfo: GeneralInfo(
          name: basic.name,
          brand: basic.brand,
          address: basic.address,
          email: basic.email,
          phone: basic.phone,
        ),
      );
    }

    isLoading = false;
    update();
  }
}
