import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

class PengaturanLabelController extends BaseController {
  bool copyLabel = false;
  bool isLoading = false;

  StickerLabelModel? selectedSticker;
  String shipcost = "";

  List<StickerLabelModel> labelList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      await setting.getSettingLabel().then((value) {
        labelList.addAll(value.data ?? []);
        selectedSticker = labelList.where((e) => e.enable == true).first;
        shipcost = (selectedSticker?.showPrice ?? false) ? "PUBLISH" : "HIDE";
      });
    } catch (e) {
      e.printError();
      selectedSticker = StickerLabelModel.fromJson(
          await storage.readData(StorageCore.transactionLabel));
      shipcost = await storage.readString(StorageCore.shippingCost);
    }

    update();
  }

  Future<void> saveLabel() async {
    isLoading = true;
    update();
    try {
      setting
          .updateSettingLabel(
        selectedSticker?.index?.toString() ?? '',
        shipcost == "HIDE" ? 1 : 0,
      )
          .then((value) async {
        if (value.code == 200) {
          await storage.writeString(StorageCore.shippingCost, shipcost);
          await storage
              .writeString(StorageCore.transactionLabel, selectedSticker?.name)
              .then((value) => AppSnackBar.success('Label di update'.tr));
        } else {
          AppSnackBar.error(value.error[0]);
        }
      });
    } catch (e) {
      AppLogger.e('error saveLabel', e);
    }
    isLoading = false;
    update();
  }
}
