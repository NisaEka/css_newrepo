import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddDropshipperController extends BaseController {
  AccountNumberModel account = Get.arguments['account'];

  final formKey = GlobalKey<FormState>();
  final namaPengirim = TextEditingController();
  final noHP = TextEditingController();
  final kotaPengirim = TextEditingController();
  final alamatPengirim = TextEditingController();
  final kodePos = TextEditingController();

  List<OriginModel> originList = [];
  bool isLoadOrigin = false;
  OriginModel? selectedOrigin;

  @override
  void onInit() {
    super.onInit();
  }

  Future<List<OriginModel>> getOriginList(String keyword, String accountID) async {
    originList = [];
    isLoadOrigin = true;
    var response = await transaction.getOrigin(keyword, accountID);
    var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    return models ?? [];
  }
}
