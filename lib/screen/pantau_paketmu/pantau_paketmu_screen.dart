import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
    Get.find<PantauPaketmuController>();

    return GetX<PantauPaketmuController>(builder: (controller) {
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
          filterContent: _filterContent(c),
          isFiltered: c.state.isFiltered.value,
          isApplyFilter:
              (c.state.selectedStatusKiriman.value != "Total Kiriman"),
          onResetFilter: () {
            c.resetFilter(isDetail: true);
            Get.back();
          },
          onApplyFilter: () {
            c.applyFilter(isDetail: true);
            Get.back();
          },
          onCloseFilter: () {
            Get.back();
          },
        ),
      ],
    );
  }

  Widget _filterContent(PantauPaketmuController c) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() => Customradiobutton(
                      title: "1 Bulan Terakhir".tr,
                      value: '1',
                      groupValue: c.state.dateFilter.value,
                      onChanged: (value) => c.selectDateFilter(1),
                      onTap: () => c.selectDateFilter(1),
                    )),
                Obx(() => Customradiobutton(
                      title: "1 Minggu Terakhir".tr,
                      value: '2',
                      groupValue: c.state.dateFilter.value,
                      onChanged: (value) => c.selectDateFilter(2),
                      onTap: () => c.selectDateFilter(2),
                    )),
                Obx(() => Customradiobutton(
                      title: "Hari Ini".tr,
                      value: '3',
                      groupValue: c.state.dateFilter.value,
                      onChanged: (value) => c.selectDateFilter(3),
                      onTap: () => c.selectDateFilter(3),
                    )),
                Obx(() => Customradiobutton(
                      title: "Pilih Tanggal Sendiri".tr,
                      value: '4',
                      groupValue: c.state.dateFilter.value,
                      onChanged: (value) => c.selectDateFilter(4),
                      onTap: () => c.selectDateFilter(4),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextFormField(
                      controller: c.state.startDateField,
                      readOnly: true,
                      width: Get.width / 3,
                      hintText: 'Tanggal Awal'.tr,
                      onTap: () => c.state.dateFilter.value == '4'
                          ? c.selectDate().then((value) {
                              if (value != null) {
                                if (c.state.endDate.value != null &&
                                    value.isAfter(c.state.endDate.value!)) {
                                  AppSnackBar.error(
                                      'Start date cannot be after end date');
                                  return;
                                }
                                c.state.startDate.value = DateTime(value.year,
                                    value.month, value.day, 0, 0, 0);
                                c.state.startDateField.text = c.state.startDate
                                    .toString()
                                    .toShortDateFormat();
                              }
                            })
                          : null,
                      // hintText: 'Dari Tanggal',
                    ),
                    CustomTextFormField(
                      controller: c.state.endDateField,
                      readOnly: true,
                      width: Get.width / 3,
                      hintText: 'Tanggal Akhir'.tr,
                      onTap: () => c.state.dateFilter.value == '4'
                          ? c.selectDate().then((value) {
                              if (value != null) {
                                c.state.endDate.value = DateTime(value.year,
                                    value.month, value.day, 23, 59, 59);
                              }
                              c.state.endDateField.text = c.state.endDate
                                  .toString()
                                  .toShortDateFormat();
                            })
                          : null,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                CustomDropDownField<String>(
                  items: c.state.listStatusKiriman
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ),
                      )
                      .toList(),
                  label: 'Status Kiriman'.tr,
                  hintText: 'Status Kiriman'.tr,
                  // selectedItem: c.selectedStatusKiriman,
                  value: c.state.selectedStatusKiriman.value,
                  onChanged: (value) {
                    c.state.selectedStatusKiriman.value = value as String;
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
                  items: c.state.listTipeKiriman
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e.toUpperCase()),
                        ),
                      )
                      .toList(),
                  label: 'Tipe Kiriman'.tr,
                  hintText: 'Tipe Kiriman'.tr,
                  value: c.state.selectedTipeKiriman.value,
                  onChanged: (value) {
                    c.state.selectedTipeKiriman.value = value as String;
                  },
                ),
                // CustomDropDownField(
                //   items: c.state.listOfficerEntry
                //       .map(
                //         (e) => DropdownMenuItem(
                //           value: e,
                //           child: Text(e),
                //         ),
                //       )
                //       .toList(),
                //   label: 'Petugas Entry'.tr,
                //   hintText: 'Petugas Entry'.tr,
                //   value: c.state.selectedPetugasEntry,
                //   onChanged: (value) {
                //     setState(() {
                //       c.state.selectedPetugasEntry = value;
                //       c.update();
                //     });
                //   },
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyContent(PantauPaketmuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 0),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.state.searchField,
            hintText: 'Cari'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? whiteColor
                  : blueJNE,
            ),
            onChanged: (value) {
              c.onSearchChanged(value);
            },
            onClear: () {
              c.state.searchField.clear();
              c.state.pagingController.refresh();
            },
            margin: const EdgeInsets.only(top: 20),
          ),
          // _tipeKiriman(context, c),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  AppLogger.i('Refresh');
                  c.applyFilter(isDetail: true);
                },
              ),
              child: PagedListView<int, PantauPaketmuModel>(
                pagingController: c.state.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PantauPaketmuModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                    data: TransactionModel(
                      awb: item.awbNo,
                      // orderId: item.orderId,
                      // status: item.statusPod ?? item.status,
                      serviceCode: item.service,
                      // type: item.awbType,
                      receiverName: item.receiverName,
                      createdDate: item.awbDate,
                    ),
                    isLoading: false,
                    index: index,
                    isSelected: c.state.selectedTransaction
                        .where((e) => e == item)
                        .isNotEmpty,
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
                  newPageProgressIndicatorBuilder: (context) =>
                      const LoadingDialog(
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

  // Widget _tipeKiriman(BuildContext context, PantauPaketmuController c) {
  //   return Shimmer(
  //     isLoading: c.state.isLoadCount.value,
  //     child: Container(
  //       margin: const EdgeInsets.symmetric(vertical: 15),
  //       decoration: BoxDecoration(
  //         color: blueJNE,
  //         border: Border.all(),
  //         borderRadius: BorderRadius.circular(8),
  //       ),
  //       child: Row(
  //         children: [
  //           // First GestureDetector wrapped in Expanded for equal width
  //           Expanded(
  //             child: GestureDetector(
  //               onTap: () {
  //                 AppLogger.i('Tapped');
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(vertical: 4),
  //                 decoration: const BoxDecoration(
  //                   color: blueJNE,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(8),
  //                     bottomLeft: Radius.circular(8),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment:
  //                       MainAxisAlignment.center, // Ensure center alignment
  //                   children: [
  //                     Text(
  //                       c.state.total.toString(),
  //                       style: listTitleTextStyle.copyWith(
  //                         color: whiteColor,
  //                       ),
  //                     ),
  //                     Text(
  //                       c.state.selectedStatusKiriman.value.tr,
  //                       style: sublistTitleTextStyle.copyWith(
  //                         color: c.state.tipeKiriman.value == 0
  //                             ? whiteColor
  //                             : greyColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //           // Second GestureDetector wrapped in Expanded for equal width
  //           if (c.state.selectedTipeKiriman.value == 'cod')
  //             Expanded(
  //               child: GestureDetector(
  //                 onTap: () {
  //                   AppLogger.i('Tapped');
  //                 },
  //                 child: Container(
  //                   padding: const EdgeInsets.symmetric(vertical: 4),
  //                   decoration: const BoxDecoration(
  //                     color: whiteColor,
  //                   ),
  //                   child: Column(
  //                     mainAxisAlignment:
  //                         MainAxisAlignment.center, // Ensure center alignment
  //                     children: [
  //                       Text(
  //                         'Rp ${c.state.cod.toInt().toCurrency()}',
  //                         style: listTitleTextStyle.copyWith(
  //                           color: c.state.tipeKiriman.value == 1
  //                               ? whiteColor
  //                               : blueJNE,
  //                         ),
  //                       ),
  //                       Text(
  //                         'COD'.tr,
  //                         style: sublistTitleTextStyle.copyWith(
  //                           color: c.state.tipeKiriman.value == 1
  //                               ? whiteColor
  //                               : greyColor,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           // Third GestureDetector wrapped in Expanded for equal width
  //           Expanded(
  //             child: GestureDetector(
  //               onTap: () {
  //                 c.state.tipeKiriman.value = 3;
  //                 c.state.selectedTipeKiriman.value = 'cod ongkir';
  //                 c.update();
  //                 c.state.pagingController.refresh();
  //               },
  //               child: Container(
  //                 padding: const EdgeInsets.symmetric(vertical: 4),
  //                 decoration: const BoxDecoration(
  //                   color: whiteColor,
  //                   borderRadius: BorderRadius.only(
  //                     topRight: Radius.circular(8),
  //                     bottomRight: Radius.circular(8),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   mainAxisAlignment:
  //                       MainAxisAlignment.center, // Ensure center alignment
  //                   children: [
  //                     Text(
  //                       c.state.selectedTipeKiriman.value == 'cod ongkir'
  //                           ? 'Rp ${c.state.codOngkir.toInt().toCurrency()}'
  //                           : 'Rp ${c.state.ongkir.toInt().toCurrency()}',
  //                       style: listTitleTextStyle.copyWith(
  //                         color: c.state.tipeKiriman.value == 3
  //                             ? whiteColor
  //                             : blueJNE,
  //                       ),
  //                     ),
  //                     Text(
  //                       c.state.selectedTipeKiriman.value == 'cod ongkir'
  //                           ? 'COD ONGKIR'.tr
  //                           : 'ONGKIR'.tr,
  //                       style: sublistTitleTextStyle.copyWith(
  //                         color: c.state.tipeKiriman.value == 3
  //                             ? whiteColor
  //                             : greyColor,
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _loading() {
    return Column(
      children: List.generate(
        10,
        (index) => const RiwayatKirimanListItem(isLoading: true),
      ),
    );
  }
}
