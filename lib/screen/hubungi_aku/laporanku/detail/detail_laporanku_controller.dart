import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailLaporankuController extends BaseController {
  bool isLoading = false;

  Future<void> updateStatus(String id) async {
    isLoading = true;
    update();
    id.printInfo(info: "TicketID");

    try {
      await laporanku.putTicket(id, "Closed").then(
            (value) => value.code == 201
                ? Get.back()
                : Get.showSnackbar(
                    GetSnackBar(
                      icon: const Icon(
                        Icons.info,
                        color: whiteColor,
                      ),
                      message: value.message?.tr,
                      isDismissible: true,
                      duration: const Duration(seconds: 3),
                      backgroundColor: errorColor,
                    ),
                  ),
          );
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}
