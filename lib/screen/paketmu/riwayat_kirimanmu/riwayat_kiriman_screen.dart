import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RiwayatKirimanScreen extends StatefulWidget {
  const RiwayatKirimanScreen({super.key});

  @override
  State<RiwayatKirimanScreen> createState() => _RiwayatKirimanScreenState();
}

class _RiwayatKirimanScreenState extends State<RiwayatKirimanScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Riwayat Kiriman'.tr,
              leading: CustomBackButton(
                onPressed: () => Get.offAll(const DashboardScreen()),
              ),
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
                                      onPressed: () {
                                        if (!controller.isFiltered) {
                                          controller.resetFilter();
                                        } else {
                                          Get.back();
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
                                            CustomFormLabel(label: 'Tanggal Entry'.tr),
                                            const SizedBox(height: 10),
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
                                                      // controller.startDateField.text = value?.millisecondsSinceEpoch.toString() ?? '';
                                                      // print(value?.millisecondsSinceEpoch.toString() ?? '');
                                                      controller.endDate = DateTime.now();
                                                      controller.endDateField.text = DateTime.now().toString().toDateTimeFormat();
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
                                            CustomFormLabel(label: 'Status Kiriman'.tr),
                                            const SizedBox(height: 10),
                                            // CustomFormLabel(label: 'Petugas Entry'),
                                          ],
                                        ),
                                      ),
                                      SliverPadding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        sliver: SliverGrid(
                                          delegate: SliverChildBuilderDelegate(
                                            (context, index) => GestureDetector(
                                              onTap: () => setState(() {
                                                if (controller.selectedStatusKiriman != controller.listStatusKiriman[index]) {
                                                  controller.selectedStatusKiriman = controller.listStatusKiriman[index];
                                                } else {
                                                  controller.selectedStatusKiriman = null;
                                                }
                                                controller.update();
                                              }),
                                              child: Container(
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: controller.selectedStatusKiriman == controller.listStatusKiriman[index]
                                                      ? blueJNE
                                                      : whiteColor,
                                                  border: Border.all(
                                                    color: controller.selectedStatusKiriman != controller.listStatusKiriman[index]
                                                        ? blueJNE
                                                        : whiteColor,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                                child: Text(
                                                  controller.listStatusKiriman[index].tr,
                                                  textAlign: TextAlign.center,
                                                  style: listTitleTextStyle.copyWith(
                                                      color: controller.selectedStatusKiriman == controller.listStatusKiriman[index]
                                                          ? whiteColor
                                                          : blueJNE),
                                                ),
                                              ),
                                            ),
                                            childCount: controller.listStatusKiriman.length,
                                          ),
                                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 140,
                                            mainAxisSpacing: 5,
                                            crossAxisSpacing: 16,
                                            childAspectRatio: 2,
                                            // mainAxisExtent: 100
                                          ),
                                        ),
                                      ),
                                      SliverToBoxAdapter(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 10),
                                            // const CustomFormLabel(label: 'Petugas Entry'),
                                            CustomDropDownField(
                                              items: controller.listOfficerEntry
                                                  .map(
                                                    (e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(e),
                                                    ),
                                                  )
                                                  .toList(),
                                              label: 'Petugas Entry'.tr,
                                              hintText: 'Petugas Entry'.tr,
                                              value: controller.selectedPetugasEntry,
                                              onChanged: (value) {
                                                setState(() {
                                                  controller.selectedPetugasEntry = value;
                                                  controller.update();
                                                });
                                              },
                                            )
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
                                              controller.selectedPetugasEntry != null ||
                                              controller.selectedStatusKiriman != null
                                          ? blueJNE
                                          : greyColor,
                                      width: controller.isFiltered ? Get.width / 2.5 : Get.width - 40,
                                      title: 'Terapkan'.tr,
                                      onPressed: () {
                                        if (controller.startDate != null ||
                                            controller.endDate != null ||
                                            controller.selectedPetugasEntry != null ||
                                            controller.selectedStatusKiriman != null) {
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
                        backgroundColor: Colors.white,
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
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                children: [
                  CustomSearchField(
                    controller: controller.searchField,
                    hintText: 'Cari Transaksimu'.tr,
                    prefixIcon: SvgPicture.asset(
                      IconsConstant.search,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 0;
                          controller.transType = '';
                          controller.update();
                          controller.pagingController.refresh();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 0 ? blueJNE : whiteColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                            border: Border.all(color: greyDarkColor1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.total.toString(),
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 0 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'Kiriman'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 0 ? whiteColor : greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 1;
                          controller.transType = 'COD';
                          controller.update();
                          controller.pagingController.refresh();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 1 ? blueJNE : whiteColor,
                            border: const Border.symmetric(
                              horizontal: BorderSide(color: greyDarkColor1),
                            ),
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.cod.toString(),
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 1 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'COD'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 1 ? whiteColor : greyColor,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.selectedKiriman = 2;
                          controller.transType = 'NON COD';
                          controller.update();
                          controller.pagingController.refresh();
                        },
                        child: Container(
                          width: Get.width / 4,
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            color: controller.selectedKiriman == 2 ? blueJNE : whiteColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                            ),
                            border: Border.all(color: greyDarkColor1),
                          ),
                          child: Column(
                            children: [
                              Text(
                                controller.noncod.toString(),
                                style: listTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 2 ? whiteColor : blueJNE,
                                ),
                              ),
                              Text(
                                'NON COD'.tr,
                                style: sublistTitleTextStyle.copyWith(
                                  color: controller.selectedKiriman == 2 ? whiteColor : greyColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10),
                  controller.isSelect
                      ? CustomCheckbox(
                          value: controller.isSelectAll,
                          label: 'Pilih Semua'.tr,
                          onChanged: (value) {
                            controller.selectAll(value!);
                          },
                        )
                      : const SizedBox(),
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: () => Future.sync(
                        () => controller.pagingController.refresh(),
                      ),
                      child: PagedListView<int, TransactionModel>(
                        pagingController: controller.pagingController,
                        builderDelegate: PagedChildBuilderDelegate<TransactionModel>(
                          transitionDuration: const Duration(milliseconds: 500),
                          itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                            isLoading: false,
                            index: index,
                            tanggalEntry: item.createdDate?.toShortDateTimeFormat() ?? '',
                            orderID: item.orderId ?? '-',
                            service: item.service.toString(),
                            noResi: item.awb.toString(),
                            apiType: item.type.toString(),
                            penerima: item.receiver?.name ?? '',
                            status: item.status.toString().tr,
                            isSelected: controller.selectedTransaction.where((e) => e == item).isNotEmpty,
                            onLongPress: () {
                              controller.select(item);
                            },
                            onTap: () {
                              controller.unselect(item);
                            },
                            onDelete: (context) => showDialog(
                              context: context,
                              builder: (c) => DeleteAlertDialog(
                                onDelete: () {
                                  controller.delete(item);
                                  controller.initData();
                                  Get.back();
                                },
                                onBack: () {
                                  Get.back();
                                  controller.pagingController.refresh();
                                  controller.initData();
                                },
                              ),
                            ),
                          ),
                          firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                          firstPageProgressIndicatorBuilder: (context) => Column(
                            children: List.generate(
                              3,
                              (index) => const RiwayatKirimanListItem(
                                isLoading: true,
                                tanggalEntry: '',
                                service: '',
                                noResi: '',
                                apiType: "",
                                penerima: "",
                                status: "",
                                orderID: "",
                                index: 0,
                              ),
                            ),
                          ),
                          // firstPageProgressIndicatorBuilder: (context) => const LoadingDialog(
                          //   height: 100,
                          //   background: Colors.transparent,
                          // ),
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
