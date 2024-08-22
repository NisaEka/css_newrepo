import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuScreen extends StatelessWidget {
  const PantauPaketmuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: _bodyContent(controller, context),
          );
        });
  }

  CustomTopBar _appBarContent(PantauPaketmuController c) {
    return CustomTopBar(
      title: "Pantau Paketmu".tr,
      action: [
        FilterButton(
          filterContent: StatefulBuilder(
            builder: (context, setState) {
              return _filterContent(context, c, setState);
            },
          ),
          isFiltered: c.isFiltered,
          isApplyFilter: (c.selectedStatusKiriman != "Total Kiriman"),
          onResetFilter: () => c.resetFilter(),
          onApplyFilter: () {
            c.applyFilter();
            Get.back();
          },
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

  Widget _filterContent(BuildContext context, PantauPaketmuController c, StateSetter setState) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Customradiobutton(
                //   title: "Semua Tanggal".tr,
                //   value: '0',
                //   groupValue: c.dateFilter,
                //   onChanged: (value) => setState(() => c.selectDateFilter(0)),
                //   onTap: () => setState(() => c.selectDateFilter(0)),
                // ),
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
                      width: Get.width / 3,
                      hintText: 'Tanggal Awal'.tr,
                      onTap: () => c.dateFilter == '4'
                          ? c.selectDate(context).then((value) {
                              setState(() {
                                c.startDate = value;
                                c.startDateField.text = value.toString().toShortDateFormat();
                                c.endDate = DateTime.now();
                                c.endDateField.text = DateTime.now().toString().toShortDateFormat();
                                c.update();
                              });
                            })
                          : null,
                      // hintText: 'Dari Tanggal',
                    ),
                    CustomTextFormField(
                      controller: c.endDateField,
                      readOnly: true,
                      width: Get.width / 3,
                      hintText: 'Tanggal Akhir'.tr,
                      onTap: () => c.dateFilter == '4'
                          ? c.selectDate(context).then((value) {
                              setState(() {
                                c.endDate = value;
                                c.endDateField.text = value.toString().toShortDateFormat();
                                c.update();
                              });
                            })
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomDropDownField<String>(
                  items: c.listStatusKiriman
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  label: 'Status Kiriman'.tr,
                  hintText: 'Status Kiriman'.tr,
                  // selectedItem: c.selectedStatusKiriman,
                  value: c.selectedStatusKiriman,
                  onChanged: (value) {
                    setState(() {
                      c.selectedStatusKiriman = value;
                      c.update();
                    });
                  },
                ),
                // CustomDropDownField(
                //   items: c.listStatusPrint
                //       .map(
                //         (e) => DropdownMenuItem(
                //           value: e,
                //           child: Text(e),
                //         ),
                //       )
                //       .toList(),
                //   label: 'Status Print'.tr,
                //   hintText: 'Status Print'.tr,
                //   value: c.selectedStatusPrint,
                //   onChanged: (value) {
                //     setState(() {
                //       c.selectedStatusPrint = value;
                //       c.update();
                //     });
                //   },
                // ),
                CustomDropDownField(
                  items: c.listTipeKiriman
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ),
                      )
                      .toList(),
                  label: 'Tipe Kiriman'.tr,
                  hintText: 'Tipe Kiriman'.tr,
                  value: c.selectedTipeKiriman,
                  onChanged: (value) {
                    setState(() {
                      c.selectedTipeKiriman = value;
                      c.update();
                    });
                  },
                ),
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

  Widget _bodyContent(PantauPaketmuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari'.tr,
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
            margin: const EdgeInsets.only(top: 20),
          ),
          _tipeKiriman(context, c),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  c.count();
                  c.applyFilter();
                  // c.transactionCount();
                },
              ),
              child: PagedListView<int, PantauPaketmuModel>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PantauPaketmuModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                    data: TransactionModel(
                      awb: item.awbNo,
                      orderId: item.orderId,
                      status: item.statusPod ?? item.status,
                      service: item.service,
                      type: item.awbType,
                      receiver: Receiver(
                        name: item.receiverName,
                      ),
                      createdDate: item.awbDate,
                    ),
                    isLoading: false,
                    index: index,
                    isSelected: c.selectedTransaction.where((e) => e == item).isNotEmpty,
                    onLongPress: () {
                      // c.select(item);
                    },
                    onTap: () {
                      // c.unselect(item);
                    },
                  ),
                  firstPageErrorIndicatorBuilder: (context) => _loading(),
                  firstPageProgressIndicatorBuilder: (context) => _loading(),
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

  Widget _tipeKiriman(BuildContext context, PantauPaketmuController c) {
    return Shimmer(
      isLoading: c.isLoadCount,
      child: Container(
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
                c.tipeKiriman = 0;
                c.selectedTipeKiriman = 'SEMUA';
                c.update();
                c.pagingController.refresh();
              },
              child: Container(
                width: Get.width / 4.76,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: c.tipeKiriman == 0 ? blueJNE : whiteColor,
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
                        color: c.tipeKiriman == 0 ? whiteColor : blueJNE,
                      ),
                    ),
                    Text(
                      'Kiriman'.tr,
                      style: sublistTitleTextStyle.copyWith(
                        color: c.tipeKiriman == 0 ? whiteColor : greyColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                c.tipeKiriman = 0;
                c.selectedTipeKiriman = 'SEMUA';
                c.update();
                c.pagingController.refresh();
                c.count();
              },
              child: Container(
                width: Get.width / 4.76,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: c.tipeKiriman == 1 ? blueJNE : whiteColor,
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
                        color: c.tipeKiriman == 1 ? whiteColor : blueJNE,
                      ),
                    ),
                    Text(
                      'COD'.tr,
                      style: sublistTitleTextStyle.copyWith(
                        color: c.tipeKiriman == 1 ? whiteColor : greyColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                c.tipeKiriman = 2;
                c.selectedTipeKiriman = 'NON COD';
                c.update();
                c.pagingController.refresh();
              },
              child: Container(
                width: Get.width / 4.76,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: c.tipeKiriman == 2 ? blueJNE : whiteColor,
                  // border: const Border(
                  //   right: BorderSide(color: greyDarkColor1),
                  // ),
                ),
                child: Column(
                  children: [
                    Text(
                      c.noncod.toString(),
                      style: listTitleTextStyle.copyWith(
                        color: c.tipeKiriman == 2 ? whiteColor : blueJNE,
                      ),
                    ),
                    Text(
                      'NON COD'.tr,
                      style: sublistTitleTextStyle.copyWith(
                        color: c.tipeKiriman == 2 ? whiteColor : greyColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                c.tipeKiriman = 3;
                c.selectedTipeKiriman = 'COD ONGKIR';
                c.update();
                c.pagingController.refresh();
              },
              child: Container(
                width: Get.width / 4.76,
                padding: const EdgeInsets.symmetric(vertical: 4),
                decoration: BoxDecoration(
                  color: c.tipeKiriman == 3 ? blueJNE : whiteColor,
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
                        color: c.tipeKiriman == 3 ? whiteColor : blueJNE,
                      ),
                    ),
                    Text(
                      'COD ONGKIR'.tr,
                      style: sublistTitleTextStyle.copyWith(
                        color: c.tipeKiriman == 3 ? whiteColor : greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Column(
      children: List.generate(
        10,
        (index) => const RiwayatKirimanListItem(isLoading: true),
      ),
    );
  }
}
