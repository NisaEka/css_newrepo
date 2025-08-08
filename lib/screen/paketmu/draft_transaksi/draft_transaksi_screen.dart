import 'package:collection/collection.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DraftTransaksiScreen extends StatelessWidget {
  const DraftTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DraftTransaksiController>(
        init: DraftTransaksiController(),
        builder: (controller) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (bool didPop, Object? result) => Get.delete<DashboardController>().then(
              (_) => Get.offAll(() => const DashboardScreen()),
            ),
            child: Scaffold(
              appBar: _appBarContent(controller),
              body: _bodyContent(controller, context),
            ),
          );
        });
  }

  CustomTopBar _appBarContent(DraftTransaksiController c) {
    final bool fromMenu = Get.arguments?['fromMenu'] ?? false;
    return CustomTopBar(
      title: 'Draft Transaksi'.tr,
      leading: CustomBackButton(
        onPressed: () {
          if (fromMenu) {
            Get.back();
          } else {
            Get.offAll(() => const DashboardScreen());
          }
        },
      ),
      action: [
        c.isOnline && c.isSync
            ? CustomFilledButton(
                color: successColor,
                prefixIcon: Icons.sync,
                width: 100,
                title: 'Sync Data'.tr,
                onPressed: () => c.syncData(),
              )
            : const SizedBox(),
        const SizedBox(width: 20)
      ],
    );
  }

  Widget _bodyContent(DraftTransaksiController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.search,
            hintText: 'Cari Transaksimu'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
            ),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                return newValue.copyWith(text: newValue.text.toUpperCase());
              })
            ],
            onChanged: (value) {
              c.searchDraft(value);
            },
            onClear: () {
              c.search.clear();
              c.initData();
            },
          ),
          c.isLoading
              ? LoadingDialog(
                  background: Colors.transparent,
                  width: Get.height / 2,
                  height: Get.height / 2,
                )
              : Expanded(
                  child: ListView(
                    shrinkWrap: false,
                    children: (c.search.text.isNotEmpty
                        ? c.searchList.isNotEmpty
                            ? c.searchList
                                .mapIndexed(
                                  (i, e) => c.draftItem(e, i, context),
                                )
                                .toList()
                            : [Center(child: DataEmpty(text: "Draft Kosong".tr))]
                        : c.draftList.isNotEmpty
                            ? c.draftList
                                .mapIndexed(
                                  (i, e) => c.draftItem(e, i, context),
                                )
                                .toList()
                            : [Center(child: DataEmpty(text: "Draft Kosong".tr))]),
                  ),
                ),
        ],
      ),
    );
  }
}
