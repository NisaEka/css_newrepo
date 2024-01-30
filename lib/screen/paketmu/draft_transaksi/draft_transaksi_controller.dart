import 'dart:convert';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/transaction/transaction_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_draft_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_kiriman/informasi_kiriman_screen.dart';
import 'package:get/get.dart';

class DraftTransaksiController extends BaseController {
  List<TransactionDataModel> draftList = [];
  TransactionDraftModel? draftData;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  Future<void> initData() async {
    draftList = [];
    var data = TransactionDraftModel.fromJson(await storage.readData(StorageCore.draftTransaction));
    draftList.addAll(data.draft);

    update();
  }

  void delete(int index) async {
    draftList.removeAt(index);
    var data = '{"draft" : ${jsonEncode(draftList)}}';
    draftData = TransactionDraftModel.fromJson(jsonDecode(data));

    await storage.saveData(StorageCore.draftTransaction, draftData).then(
          (_) => update(),
        );
    // initData();

    update();
  }

  void validate(int index) {
    var data = draftList.elementAt(index);
    print('test validate ${data}');
    Get.to(const InformasiKirimanScreen(), arguments: {
      "cod_ongkir": data.delivery?.codOngkir == "Y" ? true : false,
      "account": data.dataAccount,
      "origin": data.origin,
      "dropship": data.shipper?.dropship,
      "shipper": data.shipper,
      "receiver": data.receiver,
      "destination": data.dataDestination,
      "delivery": data.delivery,
      "goods": data.goods,
      "draft": true
    });
  }
}
