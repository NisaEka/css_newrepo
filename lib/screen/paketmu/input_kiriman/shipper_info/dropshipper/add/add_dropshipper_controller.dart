import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';

import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDropshipperController extends BaseController {
  Account account = Get.arguments['account'];

  final formKey = GlobalKey<FormState>();
  final dropshipperName = TextEditingController();
  final dropshipperPhone = TextEditingController();
  final dropshipperOrigin = TextEditingController();
  final dropshipperAddress = TextEditingController();
  final dropshipperZipCode = TextEditingController();

  List<Origin> originList = [];
  bool isLoadOrigin = false;
  bool isLoading = false;
  Origin? selectedOrigin;

  Future<void> saveDropshipper() async {
    isLoading = true;
    update();
    try {
      await master
          .postDropshipper(
        DropshipperModel(
          name: dropshipperName.text,
          phone: dropshipperPhone.text,
          originCode: selectedOrigin?.originCode,
          zipCode: dropshipperZipCode.text,
          address: dropshipperAddress.text,
          city: selectedOrigin?.originName,
        ),
      )
          .then((value) {
        if (value.code == 201) {
          AppSnackBar.success('Data dropshipper berhasil di simpan'.tr);
          Get.close(1);
        } else {
          AppSnackBar.error(value.error[0].toString());
        }
      });
    } catch (e) {
      AppLogger.e('error save dropshipper $e');
    }

    isLoading = false;
    update();
  }
}
