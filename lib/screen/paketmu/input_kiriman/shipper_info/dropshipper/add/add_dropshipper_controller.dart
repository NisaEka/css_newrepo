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
  final dropshipperName = TextEditingController();
  final dropshipperPhone = TextEditingController();
  final dropshipperOrigin = TextEditingController();
  final dropshipperAddress = TextEditingController();
  final dropshipperZipCode = TextEditingController();

  List<OriginModel> originList = [];
  bool isLoadOrigin = false;
  bool isLoading = false;
  OriginModel? selectedOrigin;

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
        Get.showSnackbar(
          GetSnackBar(
            icon: const Icon(
              Icons.info,
              color: whiteColor,
            ),
            message: value.code == 201
                ? "Data dropshipper berhasil di simpan".tr
                : value.error[0].toString(),
            isDismissible: true,
            duration: const Duration(seconds: 3),
            backgroundColor: value.code == 201 ? successColor : errorColor,
          ),
        );
        if (value.code == 201) {
          Get.close(1);
        }
      });
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }
}
