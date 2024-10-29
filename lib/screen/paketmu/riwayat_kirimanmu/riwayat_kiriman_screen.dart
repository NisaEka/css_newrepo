import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
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
        FilterButton(
          filterContent: StatefulBuilder(
            builder: (context, setState) {
              return _filterContent(context, c, setState);
            },
          ),
          isFiltered: c.isFiltered,
          isApplyFilter: c.startDate != null || c.endDate != null,
          onResetFilter: () => c.resetFilter(),
          onApplyFilter: () => c.applyFilter(),
          onCloseFilter: () {
            if (!c.isFiltered) {
              c.resetFilter();
            } else {
              Get.back();
            }
          },
        ),
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
            margin: EdgeInsets.zero,
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
          Container(
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
                    c.selectedKiriman = 0;
                    c.transType = '';
                    c.update();
                    c.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 4.76,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.selectedKiriman == 0 ? blueJNE : whiteColor,
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
                    width: Get.width / 4.76,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.selectedKiriman == 1 ? blueJNE : whiteColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      //   left: BorderSide(color: greyDarkColor1),
                      // ),
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
                    width: Get.width / 4.76,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.selectedKiriman == 2 ? blueJNE : whiteColor,
                      // border: const Border(
                      //   right: BorderSide(color: greyDarkColor1),
                      // ),
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
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    c.selectedKiriman = 3;
                    c.transType = 'COD ONGKIR';
                    c.update();
                    c.pagingController.refresh();
                  },
                  child: Container(
                    width: Get.width / 4.76,
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: c.selectedKiriman == 3 ? blueJNE : whiteColor,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          c.codOngkir.toString(),
                          style: listTitleTextStyle.copyWith(
                            color: c.selectedKiriman == 3 ? whiteColor : blueJNE,
                          ),
                        ),
                        Text(
                          'COD ONGKIR'.tr,
                          style: sublistTitleTextStyle.copyWith(
                            color: c.selectedKiriman == 3 ? whiteColor : greyColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
                () {
                  c.pagingController.refresh();
                  c.transactionCount();
                },
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
                    // isDelete: item.status == "MASIH DI KAMU",
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

  Widget _filterContent(BuildContext context, RiwayatKirimanController c, StateSetter setState) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomFormLabel(label: 'Tanggal Entry'.tr),
                const SizedBox(height: 10),
                Customradiobutton(
                  title: "Semua Tanggal".tr,
                  value: '0',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(0)),
                  onTap: () => setState(() => c.selectDateFilter(0)),
                ),
                Customradiobutton(
                  title: "1 Bulan Terakhir".tr,
                  value: '1',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(1)),
                  onTap: () => setState(() => c.selectDateFilter(1)),
                ),
                Customradiobutton(
                  title: "1 Minggu Terakhir".tr,
                  value: '2',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(2)),
                  onTap: () => setState(() => c.selectDateFilter(2)),
                ),
                Customradiobutton(
                  title: "Hari Ini".tr,
                  value: '3',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(3)),
                  onTap: () => setState(() => c.selectDateFilter(3)),
                ),
                Customradiobutton(
                  title: "Pilih Tanggal Sendiri".tr,
                  value: '4',
                  groupValue: c.dateFilter,
                  onChanged: (value) => setState(() => c.selectDateFilter(4)),
                  onTap: () => setState(() => c.selectDateFilter(4)),
                ),
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
                      style: listTitleTextStyle.copyWith(color: c.selectedStatusKiriman == c.listStatusKiriman[index] ? whiteColor : blueJNE),
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
    );
  }
}
