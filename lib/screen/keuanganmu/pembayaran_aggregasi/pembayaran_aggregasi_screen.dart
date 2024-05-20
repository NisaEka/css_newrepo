import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/report_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PembayaranAggergasiScreen extends StatelessWidget {
  const PembayaranAggergasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PembayaranAggergasiController>(
        init: PembayaranAggergasiController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Laporan Pembayaran Aggregasi'.tr,
              action: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    color: controller.isFiltered ? redJNE : Colors.transparent,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.bottomSheet(
                        enableDrag: true,
                        isDismissible: false,
                        // isScrollControlled: true,
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Filter',
                                      style: appTitleTextStyle.copyWith(
                                        color: blueJNE,
                                      ),
                                    ),
                                    IconButton(
                                      // onPressed: () => controller.resetFilter(),
                                      onPressed: () {
                                        if (!controller.isFiltered) {
                                          controller.resetFilter();
                                        }
                                      },
                                      icon: const Icon(Icons.close),
                                    ),
                                  ],
                                ),
                                // const Divider(color: greyColor),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomFormLabel(label: 'Nomor Akun'.tr),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: controller.accountList
                                                    .map(
                                                      (e) => AccountListItem(
                                                        data: e,
                                                        isSelected: controller.selectedAccount.where((accounts) => accounts == e).isNotEmpty,
                                                        onTap: () {
                                                          setState(() {
                                                            if (controller.selectedAccount.where((accounts) => accounts == e).isNotEmpty) {
                                                              controller.selectedAccount.removeWhere((accounts) => accounts == e);
                                                            } else {
                                                              controller.selectedAccount.add(e);
                                                            }
                                                            controller.update();
                                                          });
                                                        },
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            CustomFormLabel(label: 'Tanggal Pembayaran'.tr),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                CustomTextFormField(
                                                  controller: controller.startDateField,
                                                  readOnly: true,
                                                  width: Get.width / 2.3,
                                                  hintText: 'Tanggal Awal'.tr,
                                                  // label: ,
                                                  onTap: () => controller.selectDate(context).then((value) {
                                                    setState(() {
                                                      controller.startDate = value;
                                                      controller.startDateField.text = value.toString().toDateTimeFormat();
                                                      controller.endDate = value;
                                                      controller.endDateField.text = value.toString().toDateTimeFormat();

                                                      controller.update();
                                                    });
                                                  }),
                                                  // hintText: 'Dari Tanggal',
                                                ),
                                                CustomTextFormField(
                                                  controller: controller.endDateField,
                                                  readOnly: true,
                                                  width: Get.width / 2.3,
                                                  hintText: 'Tanggal Akhir'.tr,
                                                  onTap: () => controller.selectDate(context).then((value) {
                                                    setState(() {
                                                      controller.endDate = value;
                                                      controller.endDateField.text = value.toString().toDateTimeFormat();
                                                      controller.update();
                                                    });
                                                  }),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.isFiltered
                                        ? CustomFilledButton(
                                            color: whiteColor,
                                            fontColor: blueJNE,
                                            borderColor: blueJNE,
                                            width: Get.width / 2.5,
                                            title: 'Reset Filter'.tr,
                                            onPressed: () => controller.resetFilter(),
                                          )
                                        : const SizedBox(),
                                    CustomFilledButton(
                                      color: controller.startDate != null ||
                                              controller.endDate != null ||
                                              !controller.accountList.equals(controller.selectedAccount)
                                          ? blueJNE
                                          : (Theme.of(context).brightness == Brightness.light ? greyColor : greyLightColor3),
                                      width: controller.isFiltered ? Get.width / 2.5 : Get.width - 40,
                                      title: 'Terapkan'.tr,
                                      onPressed: () {
                                        if (controller.startDate != null ||
                                            controller.endDate != null ||
                                            !controller.accountList.equals(controller.selectedAccount)) {
                                          controller.isFiltered = true;
                                          if (controller.startDate != null && controller.endDate != null) {
                                            controller.transDate =
                                                "${controller.startDate?.millisecondsSinceEpoch ?? ''}-${controller.endDate?.millisecondsSinceEpoch ?? ''}";
                                          }
                                          controller.update();

                                          controller.pagingController.refresh();
                                          Get.back();
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        }),
                        backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : greyColor,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      );
                    },
                    icon: const Icon(Icons.filter_alt_outlined),
                    color: controller.isFiltered ? whiteColor : redJNE,
                    tooltip: 'filter',
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  PaymentBox(
                    title: "Total nilai yang sudah dibayarkan".tr,
                    value: "Rp. 3.910.000",
                  ),
                  CustomSearchField(
                    controller: controller.searchField,
                    hintText: 'Cari Data Agregasi'.tr,
                    prefixIcon: SvgPicture.asset(
                      IconsConstant.search,
                      color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
                    ),
                    onChanged: (value) {
                      controller.searchField.text = value;
                      controller.update();
                      controller.pagingController.refresh();
                    },
                    onClear: () {
                      controller.searchField.clear();
                      controller.pagingController.refresh();
                    },
                  ),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => controller.pagingController.refresh(),
                      ),
                      child: PagedListView<int, AggregationModel>(
                        pagingController: controller.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<AggregationModel>(
                          transitionDuration: const Duration(milliseconds: 500),
                          itemBuilder: (context, item, index) => ReportListItem(
                            status: item.statusGv,
                            data: item,
                          ),
                          firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                          firstPageProgressIndicatorBuilder: (context) => Column(
                            children: List.generate(
                              3,
                              (index) => const ReportListItem(
                                isLoading: true,
                              ),
                            ),
                          ),
                          noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
                          noMoreItemsIndicatorBuilder: (context) => const Center(
                            child: Divider(
                              indent: 100,
                              endIndent: 100,
                              thickness: 2,
                              color: blueJNE,
                            ),
                          ),
                          newPageProgressIndicatorBuilder: (context) => const LoadingDialog(
                            background: Colors.transparent,
                            height: 50,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
