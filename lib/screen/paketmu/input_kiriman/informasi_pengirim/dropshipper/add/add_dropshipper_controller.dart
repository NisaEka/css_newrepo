import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
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
  Origin? selectedOrigin;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Origin>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    var response = await transaction.getOrigin(keyword, accountID);
    var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    return models ?? [];
  }

  Future<void> saveDropshipper() async {
    try {
      await transaction
          .postDropshipper(DropshipperModel(
            name: namaPengirim.text,
            phone: noHP.text,
            origin: selectedOrigin?.originCode,
            zipCode: kodePos.text,
            address: alamatPengirim.text,
          ))
          .then(
            (value) => Get.showSnackbar(
              GetSnackBar(
                icon: const Icon(
                  Icons.info,
                  color: whiteColor,
                ),
                message: value.message,
                isDismissible: true,
                duration: const Duration(seconds: 3),
                backgroundColor: value.code == 200 ? successColor : errorColor,
              ),
            ),
          )
          .then((_) => Get.close(2));
    } catch (e) {
      e.printError();
    }
  }
}
