import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

class PengaturanLabelController extends BaseController {
  bool isLoading = false;

  SettingLabelsModel? selectedSticker;
  String shipcost = "";
  String hiddenPhone = "";
  String copyLabel = "0";

  List<SettingLabelsModel> labelList = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    try {
      await setting.getSettingLabel().then((value) {
        labelList.addAll(value.data?.labels ?? []);
        selectedSticker = labelList.where((e) => e.enabled == true).first;
        shipcost = (value.data?.priceLabel != '0') ? "PUBLISH" : "HIDE";
        hiddenPhone =
            (value.data?.hideShipperphoneLabel != 'Y') ? "PUBLISH" : "HIDE";
        copyLabel = value.data?.copyLabel?.toString() ?? '0';
      });
    } catch (e) {
      AppLogger.e('error initData pengaturan label', e);
      selectedSticker = SettingLabelsModel.fromJson(
          await storage.readData(StorageCore.transactionLabel));
      shipcost = await storage.readString(StorageCore.shippingCost);
      hiddenPhone = await storage.readString(StorageCore.hiddenPhoneShipper);
      copyLabel = await storage.readString(StorageCore.isCopyLabel);
    }

    update();
  }

  Future<void> saveLabel() async {
    isLoading = true;
    update();
    try {
      setting
          .updateSettingLabel(
        selectedSticker?.id?.toString() ?? '',
        shipcost == "PUBLISH" ? 1 : 0,
        hiddenPhone == "PUBLISH" ? 'N' : 'Y',
        copyLabel,
      )
          .then((value) async {
        if (value.code == 200) {
          await storage.writeString(StorageCore.shippingCost, shipcost);
          await storage.writeString(
              StorageCore.hiddenPhoneShipper, hiddenPhone);
          await storage.writeString(StorageCore.isCopyLabel, copyLabel);
          await storage
              .writeString(StorageCore.transactionLabel, selectedSticker?.name)
              .then(
                (value) => AppSnackBar.success('Label di update'.tr),
              );
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
