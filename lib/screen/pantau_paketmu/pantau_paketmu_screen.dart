import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
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

  Widget _filterContent(BuildContext context, PantauPaketmuController c, StateSetter setState) {
    return Expanded(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  c.pagingController.refresh();
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
                      status: item.statusPod,
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
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const RiwayatKirimanListItem(isLoading: true),
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
    );
  }
}
