import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/laporanku_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LaporankuScreen extends StatelessWidget {
  const LaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: _bodyContent(controller, context),
            floatingActionButton: CustomFilledButton(
              color: redJNE,
              title: "Buat Laporan",
              width: Get.width / 3,
              icon: Icons.add,
              radius: 30,
              height: 50,
            ),
          );
        });
  }

  CustomTopBar _appBarContent(LaporankuController c) {
    return CustomTopBar(
      title: "Laporanku".tr,
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
                                    CustomFormLabel(label: 'Tanggal Laporan'.tr),
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
                                              c.startDateField.text = value.toString().toDateFormat();
                                              c.endDate = DateTime.now();
                                              c.endDateField.text = DateTime.now().toString().toDateFormat();
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
                                              c.endDateField.text = value.toString().toDateFormat();
                                              c.update();
                                            });
                                          }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    // CustomFormLabel(label: 'Petugas Entry'),
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
                              color: c.startDate != null || c.endDate != null ? blueJNE : greyColor,
                              width: c.isFiltered ? Get.width / 2.5 : Get.width - 40,
                              title: 'Terapkan'.tr,
                              onPressed: () => c.applyFilter(),
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

  Widget _bodyContent(LaporankuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: [
          CustomSearchField(
            hintText: "Cari".tr,
            controller: c.searchField,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
            ),
          ),
          _statusLaporanku(c),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  c.pagingController.refresh();
                },
              ),
              child: PagedListView<int, dynamic>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => LaporankuListItem(),
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const LaporankuListItem(isLoading: true),
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
          ),
        ],
      ),
    );
  }

  Widget _statusLaporanku(LaporankuController c) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: blueJNE,
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              c.status = '';
              c.selectedStatus = 0;
              c.update();
              c.pagingController.refresh();
            },
            child: Container(
              width: Get.width / 3.56,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: c.selectedStatus == 0 ? blueJNE : whiteColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
                // border: const Border(
                //   right: BorderSide(color: greyDarkColor1),
                // ),
              ),
              child: Column(
                children: [
                  Text(
                    c.total.toString(),
                    style: listTitleTextStyle.copyWith(
                      color: c.selectedStatus == 0 ? whiteColor : blueJNE,
                    ),
                  ),
                  Text(
                    'Semua Laporan'.tr,
                    style: sublistTitleTextStyle.copyWith(
                      color: c.selectedStatus == 0 ? whiteColor : greyColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              c.selectedStatus = 1;
              c.status = 'onProcess';
              c.update();
              c.pagingController.refresh();
            },
            child: Container(
              width: Get.width / 3.56,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: c.selectedStatus == 1 ? blueJNE : whiteColor,
                // border: const Border(
                //   right: BorderSide(color: greyDarkColor1),
                //   left: BorderSide(color: greyDarkColor1),
                // ),
              ),
              child: Column(
                children: [
                  Text(
                    c.onProcess.toString(),
                    style: listTitleTextStyle.copyWith(
                      color: c.selectedStatus == 1 ? whiteColor : blueJNE,
                    ),
                  ),
                  Text(
                    'Masih Diproses'.tr,
                    style: sublistTitleTextStyle.copyWith(
                      color: c.selectedStatus == 1 ? whiteColor : greyColor,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              c.selectedStatus = 2;
              c.status = 'closed';
              c.update();
              c.pagingController.refresh();
            },
            child: Container(
              width: Get.width / 3.56,
              padding: const EdgeInsets.symmetric(vertical: 4),
              decoration: BoxDecoration(
                color: c.selectedStatus == 2 ? blueJNE : whiteColor,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    c.closed.toString(),
                    style: listTitleTextStyle.copyWith(
                      color: c.selectedStatus == 2 ? whiteColor : blueJNE,
                    ),
                  ),
                  Text(
                    'Selesai'.tr,
                    style: sublistTitleTextStyle.copyWith(
                      color: c.selectedStatus == 2 ? whiteColor : greyColor,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
