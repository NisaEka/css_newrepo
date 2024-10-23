import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';

import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDropshipperController extends BaseController {
  Account account = Get.arguments['account'];

  final formKey = GlobalKey<FormState>();
  final namaPengirim = TextEditingController();
  final noHP = TextEditingController();
  final kotaPengirim = TextEditingController();
  final alamatPengirim = TextEditingController();
  final kodePos = TextEditingController();

  List<Origin> originList = [];
  bool isLoadOrigin = false;
  bool isLoading = false;
  Origin? selectedOrigin;

  Future<List<Origin>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    // var response = await master.getOrigins(keyword, accountID);
    // var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    // return models ?? [];
    return [];
  }

  Future<void> saveDropshipper() async {
    isLoading = true;
    update();
    try {
      await transaction
          .postDropshipper(DropshipperModel(
            name: namaPengirim.text,
            phone: noHP.text,
            origin: selectedOrigin?.originCode,
            zipCode: kodePos.text,
            address: alamatPengirim.text,
            city: selectedOrigin?.originName,
          ))
          .then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: "Data dropshipper berhasil di simpan".tr,
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 201 ? successColor : errorColor,
              ),
            ),
          )
          .then((_) => Get.close(1));
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}
