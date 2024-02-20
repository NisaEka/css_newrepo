import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanController extends BaseController {
  final searchField = TextEditingController();
  final String? resi = Get.arguments['nomor_resi'];

  bool isLoading = false;
  bool isLogin = false;

  PostLacakKirimanModel? trackModel;

  @override
  void onInit() {
    super.onInit();
    cekToken();
    if (resi != null) {
      searchField.text = resi ?? '';
      cekResi(resi ?? '');
    }
  }

  Future<bool> cekToken() async {
    String? token = await storage.readToken();
    debugPrint("token : $token");
    isLogin = token != null;
    update();

    return isLogin;
  }

  Future<PostLacakKirimanModel> cekResi(String nomorResi) async {
    isLoading = true;
    update();
    print('lacak');
    try {
      await trace.postTracingByCnote(nomorResi).then(
            (value) => trackModel = value,
          );
    } catch (e, i) {
      e.printError();
      i.printError();
      try {
        await trace.postTracingByReference(nomorResi).then(
              (value) => trackModel = value,
            );
      } catch (e, i) {
        e.printError();
        i.printError();
      }
    }

    isLoading = false;
    update();

    return trackModel ?? PostLacakKirimanModel();
  }
}
