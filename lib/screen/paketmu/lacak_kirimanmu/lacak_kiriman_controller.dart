import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/phone_number_confirmation_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanController extends BaseController {
  final searchField = TextEditingController();
  final String? resi = Get.arguments['nomor_resi'];

  bool isLoading = false;
  bool isLogin = false;

  BaseResponse<PostLacakKirimanModel>? trackModel;

  @override
  void onInit() {
    super.onInit();
    cekToken();
    if (resi != null) {
      searchField.text = resi ?? '';
      Future.delayed(Duration.zero, () async {
        if (await cekToken()) {
          cekResi(resi ?? '', '');
        } else {
          Get.to(() => PhoneNumberConfirmationScreen(
                awb: resi ?? '',
                cekResi: cekResi,
                isLoading: isLoading,
              ));
        }
      });
    }
  }

  Future<bool> cekToken() async {
    String? token = await storage.readAccessToken();
    AppLogger.d('token : $token');
    isLogin = token != null;
    update();

    return isLogin;
  }

  Future<BaseResponse<PostLacakKirimanModel>> cekResi(
      String nomorResi, String phoneNumber) async {
    isLoading = true;
    update();
    try {
      final response = await cekToken()
          ? await trace.postTracingByCnote(nomorResi)
          : await trace.postTracingByCnotePublic(nomorResi, phoneNumber);
      trackModel = response;
    } catch (e, i) {
      AppLogger.e('error cekResi $e, $i');
    }

    isLoading = false;
    update();

    return trackModel ?? BaseResponse(data: null);
  }
}
