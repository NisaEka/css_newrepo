import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/util/logger.dart';
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
    String? token = await storage.readAccessToken();
    AppLogger.d('token : $token');
    isLogin = token != null;
    update();

    return isLogin;
  }

  Future<PostLacakKirimanModel> cekResi(String nomorResi) async {
    isLoading = true;
    update();
    try {
      await trace.postTracingByCnote(nomorResi).then(
            (value) => trackModel = value,
          );
    } catch (e, i) {
      AppLogger.e('error cekResi $e, $i');
    }

    isLoading = false;
    update();

    return trackModel ?? PostLacakKirimanModel();
  }
}
