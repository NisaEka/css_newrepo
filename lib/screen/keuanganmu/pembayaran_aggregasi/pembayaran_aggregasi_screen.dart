import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/bar/filter_button.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customradiobutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
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
            appBar: _appBarContent(controller, context),
            body: _bodyContent(controller, context),
          );
        });
  }

  CustomTopBar _appBarContent(
      PembayaranAggergasiController c, BuildContext context) {
    return CustomTopBar(
      title: 'Laporan Pembayaran Aggregasi'.tr,
      action: [
        FilterButton(
          filterContent: StatefulBuilder(
            builder: (context, setState) {
              return _filterContent(c, context, setState);
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

  Widget _bodyContent(PembayaranAggergasiController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PaymentBox(
          //   isLoading: c.aggTotal == null,
          //   title: "Total nilai yang sudah dibayarkan".tr,
          //   value: "Rp. ${c.aggTotal?.toCurrency() ?? 0}",
          // ),
          Text(
            "Rp. ${c.aggTotal?.toCurrency() ?? 0}",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: primaryColor(context), fontWeight: bold),
          ),
          Text(
            "Total nilai yang sudah dibayarkan".tr,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const SizedBox(height: 16),
          CustomSearchField(
            margin: const EdgeInsets.only(top: 0),
            controller: c.searchField,
            hintText: 'Cari Data Agregasi'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: fifthColor(context),
            ),
            onChanged: (value) => c.onSearch(value),
            onClear: () => c.onSearchClear(),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () => c.pagingController.refresh(),
              ),
              child: PagedListView<int, AggregationModel>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<AggregationModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => ReportListItem(
                    status: item.statusGv,
                    data: item,
                    onTapButton: () => Get.to(
                      const AggByDocScreen(),
                      arguments: {
                        'aggregationID': item.mpayWdrGrpPayNo ?? '',
                      },
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) =>
                      const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const ReportListItem(
                        isLoading: true,
                      ),
                    ),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
                  noMoreItemsIndicatorBuilder: (context) => Center(
                    child: Divider(
                      indent: 100,
                      endIndent: 100,
                      thickness: 2,
                      color: primaryColor(context),
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

  Widget _filterContent(PembayaranAggergasiController c, BuildContext context,
      StateSetter setState) {
    return Expanded(
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
                    children: c.accountList
                        .map(
                          (e) => AccountListItem(
                            data: e,
                            isSelected: c.selectedAccount
                                .where((accounts) => accounts == e)
                                .isNotEmpty,
                            onTap: () => setState(() => c.onSelectAccount(e)),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 10),
                CustomFormLabel(label: 'Tanggal Pembayaran'.tr),
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
                      // label: ,
                      onTap: () => c.dateFilter == '4'
                          ? c.selectDate(context).then((value) {
                              setState(() => c.onSelectStartDate(value!));
                            })
                          : null,
                      // hintText: 'Dari Tanggal',
                    ),
                    CustomTextFormField(
                      controller: c.endDateField,
                      readOnly: true,
                      width: Get.width / 2.3,
                      hintText: 'Tanggal Akhir'.tr,
                      onTap: () => c.dateFilter == '4'
                          ? c.selectDate(context).then(
                                (value) =>
                                    setState(() => c.onSelectEndDate(value!)),
                              )
                          : null,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
