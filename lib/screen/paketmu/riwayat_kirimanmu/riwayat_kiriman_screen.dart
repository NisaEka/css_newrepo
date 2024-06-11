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

class RiwayatKirimanScreen extends StatelessWidget {
  const RiwayatKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: _bodyContent(controller, context),
          );
        });
  }

  CustomTopBar _appBarContent(RiwayatKirimanController c) {
    return CustomTopBar(
      title: 'Riwayat Kiriman'.tr,
      leading: CustomBackButton(
        onPressed: () => Get.offAll(const DashboardScreen()),
      ),
      action: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            color: c.isFiltered ? redJNE : Colors.transparent,
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
                    color: Theme.of(context).brightness == Brightness.light ? greyLightColor2 : greyDarkColor2,
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
                                color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                if (!c.isFiltered) {
                                  c.resetFilter();
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
                                          controller: c.startDateField,
                                          readOnly: true,
                                          width: Get.width / 2.3,
                                          hintText: 'Tanggal Awal'.tr,
                                          onTap: () => c.selectDate(context).then((value) {
                                            setState(() {
                                              c.startDate = value;
                                              c.startDateField.text = value.toString().toDateTimeFormat();
                                              c.endDate = DateTime.now();
                                              c.endDateField.text = DateTime.now().toString().toDateTimeFormat();
                                              c.update();
                                            });
                                          }),
                                          // hintText: 'Dari Tanggal',
                                        ),
                                        CustomTextFormField(
                                          controller: c.endDateField,
                                          readOnly: true,
                                          width: Get.width / 2.3,
                                          hintText: 'Tanggal Akhir'.tr,
                                          onTap: () => c.selectDate(context).then((value) {
                                            setState(() {
                                              c.endDate = value;
                                              c.endDateField.text = value.toString().toDateTimeFormat();
                                              c.update();
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
                                        if (c.selectedStatusKiriman != c.listStatusKiriman[index]) {
                                          c.selectedStatusKiriman = c.listStatusKiriman[index];
                                        } else {
                                          c.selectedStatusKiriman = null;
                                        }
                                        c.update();
                                      }),
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: c.selectedStatusKiriman == c.listStatusKiriman[index] ? blueJNE : whiteColor,
                                          border: Border.all(
                                            color: c.selectedStatusKiriman != c.listStatusKiriman[index] ? blueJNE : whiteColor,
                                          ),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          c.listStatusKiriman[index].tr,
                                          textAlign: TextAlign.center,
                                          style: listTitleTextStyle.copyWith(
                                              color: c.selectedStatusKiriman == c.listStatusKiriman[index] ? whiteColor : blueJNE),
                                        ),
                                      ),
                                    ),
                                    childCount: c.listStatusKiriman.length,
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
                                      items: c.listOfficerEntry
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e),
                                            ),
                                          )
                                          .toList(),
                                      label: 'Petugas Entry'.tr,
                                      hintText: 'Petugas Entry'.tr,
                                      value: c.selectedPetugasEntry,
                                      onChanged: (value) {
                                        setState(() {
                                          c.selectedPetugasEntry = value;
                                          c.update();
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
                            c.isFiltered
                                ? CustomFilledButton(
                                    color: whiteColor,
                                    fontColor: blueJNE,
                                    borderColor: blueJNE,
                                    width: Get.width / 2.5,
                                    title: 'Reset Filter'.tr,
                                    onPressed: () => c.resetFilter(),
                                  )
                                : const SizedBox(),
                            CustomFilledButton(
                              color: c.startDate != null || c.endDate != null || c.selectedPetugasEntry != null || c.selectedStatusKiriman != null
                                  ? blueJNE
                                  : greyColor,
                              width: c.isFiltered ? Get.width / 2.5 : Get.width - 40,
                              title: 'Terapkan'.tr,
                              onPressed: () {
                                if (c.startDate != null || c.endDate != null || c.selectedPetugasEntry != null || c.selectedStatusKiriman != null) {
                                  c.isFiltered = true;
                                  if (c.startDate != null && c.endDate != null) {
                                    c.transDate = "${c.startDate?.millisecondsSinceEpoch ?? ''}-${c.endDate?.millisecondsSinceEpoch ?? ''}";
                                  }
                                  c.update();

                                  c.pagingController.refresh();
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
            color: c.isFiltered ? whiteColor : redJNE,
            tooltip: 'filter',
          ),
        )
      ],
    );
  }

  Widget _bodyContent(RiwayatKirimanController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari Transaksimu'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
            ),
            onChanged: (value) {
              c.searchField.text = value;
              c.update();
              c.pagingController.refresh();
            },
            onClear: () {
              c.searchField.clear();
              c.pagingController.refresh();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  c.selectedKiriman = 0;
                  c.transType = '';
                  c.update();
                  c.pagingController.refresh();
                },
                child: Container(
                  width: Get.width / 4,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: c.selectedKiriman == 0 ? blueJNE : whiteColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                    border: Border.all(color: greyDarkColor1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        c.total.toString(),
                        style: listTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 0 ? whiteColor : blueJNE,
                        ),
                      ),
                      Text(
                        'Kiriman'.tr,
                        style: sublistTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 0 ? whiteColor : greyColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  c.selectedKiriman = 1;
                  c.transType = 'COD';
                  c.update();
                  c.pagingController.refresh();
                },
                child: Container(
                  width: Get.width / 4,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: c.selectedKiriman == 1 ? blueJNE : whiteColor,
                    border: const Border.symmetric(
                      horizontal: BorderSide(color: greyDarkColor1),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        c.cod.toString(),
                        style: listTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 1 ? whiteColor : blueJNE,
                        ),
                      ),
                      Text(
                        'COD'.tr,
                        style: sublistTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 1 ? whiteColor : greyColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  c.selectedKiriman = 2;
                  c.transType = 'NON COD';
                  c.update();
                  c.pagingController.refresh();
                },
                child: Container(
                  width: Get.width / 4,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  decoration: BoxDecoration(
                    color: c.selectedKiriman == 2 ? blueJNE : whiteColor,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                    border: Border.all(color: greyDarkColor1),
                  ),
                  child: Column(
                    children: [
                      Text(
                        c.noncod.toString(),
                        style: listTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 2 ? whiteColor : blueJNE,
                        ),
                      ),
                      Text(
                        'NON COD'.tr,
                        style: sublistTitleTextStyle.copyWith(
                          color: c.selectedKiriman == 2 ? whiteColor : greyColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // const SizedBox(height: 10),
          c.isSelect
              ? CustomCheckbox(
                  value: c.isSelectAll,
                  label: 'Pilih Semua'.tr,
                  onChanged: (value) {
                    c.selectAll(value!);
                  },
                )
              : const SizedBox(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => c.pagingController.refresh(),
              ),
              child: PagedListView<int, TransactionModel>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<TransactionModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                    data: item,
                    isLoading: false,
                    index: index,
                    isSelected: c.selectedTransaction.where((e) => e == item).isNotEmpty,
                    onLongPress: () {
                      c.select(item);
                    },
                    onTap: () {
                      c.unselect(item);
                    },
                    isDelete: item.status == "MASIH DI KAMU",
                    onDelete: (context) => showDialog(
                      context: context,
                      builder: (context) => DeleteAlertDialog(
                        onDelete: () {
                          c.delete(item);
                          c.initData();
                          Get.back();
                        },
                        onBack: () {
                          Get.back();
                          c.pagingController.refresh();
                          c.initData();
                        },
                      ),
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const RiwayatKirimanListItem(isLoading: true),
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
    );
  }
}
