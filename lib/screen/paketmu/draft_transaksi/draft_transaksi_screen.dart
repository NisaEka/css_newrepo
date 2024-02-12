import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/draft_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DraftTransaksiScreen extends StatelessWidget {
  const DraftTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DraftTransaksiController>(
        init: DraftTransaksiController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: CustomTopBar(
                  title: 'Draft Transaksi'.tr,
                  leading: CustomBackButton(
                    onPressed: () => Get.off(const DashboardScreen()),
                  ),
                  action: [
                    controller.isOnline && controller.isSync
                        ? CustomFilledButton(
                            color: successColor,
                            icon: Icons.sync,
                            width: 100,
                            title: 'Sync Data'.tr,
                            onPressed: () => controller.syncData(),
                          )
                        : const SizedBox(),
                    const SizedBox(width: 20)
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // CustomFilledButton(
                      //   color: errorColor,
                      //   title: 'clear draft',
                      //   onPressed: () {
                      //     controller.storage.deleteString(StorageCore.draftTransaction);
                      //     controller.initData();
                      //     controller.update();
                      //   },
                      // ),
                      CustomSearchField(
                        hintText: 'Cari transaksimu'.tr,
                        prefixIcon: SvgPicture.asset(IconsConstant.search),
                      ),
                      Expanded(
                        child: controller.draftList.isNotEmpty
                            ? ListView(
                                children: controller.draftList
                                    .mapIndexed(
                                      (i, e) => DraftTransactionListItem(
                                        data: e,
                                        index: i,
                                        onDelete: () => showDialog(
                                          context: context,
                                          builder: (context) => DeleteAlertDialog(
                                            onDelete: () {
                                              controller.delete(i);
                                              controller.initData();
                                              Get.back();
                                            },
                                            onBack: () {
                                              Get.back();
                                              controller.initData();
                                            },
                                          ),
                                        ),
                                        onValidate: () => controller.validate(i),
                                      ),
                                    )
                                    .toList(),
                              )
                            : DataEmpty(text: "Draft Kosong".tr),
                      ),
                    ],
                  ),
                ),
              ),
              controller.isLoading ? const LoadingDialog() : Container(),
            ],
          );
        });
  }
}
