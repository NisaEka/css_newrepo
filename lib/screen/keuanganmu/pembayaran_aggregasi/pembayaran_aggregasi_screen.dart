import 'package:collection/collection.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/pembayaran_aggregasi_controller.dart';
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
                _filterContent(controller, context),
              ],
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(PembayaranAggergasiController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          PaymentBox(
            title: "Total nilai yang sudah dibayarkan".tr,
            value: "Rp. 3.910.000",
          ),
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari Data Agregasi'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
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
                    onTapButton: () => Get.to(const AggByDocScreen()),
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
    );
  }

  Widget _filterContent(PembayaranAggergasiController c, BuildContext context) {
    return Container(
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
                color: AppConst.isDarkTheme(context) ? greyDarkColor2 : greyLightColor2,
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
                            color: AppConst.isDarkTheme(context) ? redJNE : blueJNE,
                          ),
                        ),
                        IconButton(
                          // onPressed: () => controller.resetFilter(),
                          onPressed: () {
                            if (!c.isFiltered) {
                              c.resetFilter();
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
                                    children: c.accountList
                                        .map(
                                          (e) => AccountListItem(
                                            data: e,
                                            isSelected: c.selectedAccount.where((accounts) => accounts == e).isNotEmpty,
                                            onTap: () => setState(() => c.onSelectAccount(e)),
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
                                      controller: c.startDateField,
                                      readOnly: true,
                                      width: Get.width / 2.3,
                                      hintText: 'Tanggal Awal'.tr,
                                      // label: ,
                                      onTap: () => c.selectDate(context).then((value) {
                                        setState(() => c.onSelectStartDate(value!));
                                      }),
                                      // hintText: 'Dari Tanggal',
                                    ),
                                    CustomTextFormField(
                                      controller: c.endDateField,
                                      readOnly: true,
                                      width: Get.width / 2.3,
                                      hintText: 'Tanggal Akhir'.tr,
                                      onTap: () => c.selectDate(context).then(
                                            (value) => setState(() => c.onSelectEndDate(value!)),
                                          ),
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
                          color: c.startDate != null || c.endDate != null || !c.accountList.equals(c.selectedAccount)
                              ? blueJNE
                              : (AppConst.isLightTheme(context) ? greyColor : greyLightColor3),
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
            backgroundColor: AppConst.isLightTheme(context) ? Colors.white : greyColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          );
        },
        icon: const Icon(Icons.filter_alt_outlined),
        color: c.isFiltered ? whiteColor : redJNE,
        tooltip: 'filter'.tr,
      ),
    );
  }
}
