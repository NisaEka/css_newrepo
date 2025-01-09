import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/screen/keuanganmu/minus/detail/doc/aggregation_minus_doc_screen.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_doc/agg_by_doc_screen.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/type_transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardAggregationCountItem extends StatelessWidget {
  final AggregationModel? aggregationPembayaran;
  final AggregationMinusModel? aggregationMinus;
  final bool isLoading;

  const DashboardAggregationCountItem({
    super.key,
    this.isLoading = false,
    this.aggregationMinus,
    this.aggregationPembayaran,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Shimmer(
      isLoading: isLoading,
      child: (aggregationPembayaran?.mpayWdrGrpPayNo?.isEmpty ?? false) &&
              (aggregationMinus?.aggMinDoc.isEmpty ?? false)
          ? const SizedBox()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppConst.isLightTheme(context)
                      ? greyLightColor3
                      : greyDarkColor1,
                ),
                color: isLoading
                    ? greyColor
                    : AppConst.isLightTheme(context)
                        ? greyLightColor3
                        : greyDarkColor1,
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppConst.isLightTheme(context)
                          ? whiteColor
                          : bgDarkColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          aggregationPembayaran?.mpayWdrGrpPayNo?.isEmpty ??
                                  false
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.start,
                      children: [
                        aggregationPembayaran?.mpayWdrGrpPayNo?.isNotEmpty ??
                                false
                            ? SizedBox(
                                width: Get.width / 2.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Aggregasi Pembayaran".tr,
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: screenWidth < 400
                                                    ? 12
                                                    : 14)),
                                    TypeTransactionCard(
                                      value1: aggregationPembayaran
                                              ?.mpayWdrGrpPayNo ??
                                          '-',
                                      value2:
                                          'Rp. ${aggregationPembayaran?.mpayWdrGrpPayCodAmt?.toCurrency().toString() ?? '0'}',
                                      description: aggregationPembayaran
                                              ?.createddtm
                                              ?.toLongDateTimeFormat() ??
                                          '-',
                                      lineColor: successColor,
                                      value1fontSize:
                                          screenWidth < 400 ? 10 : 12,
                                      value2fontSize: 14,
                                      isSuccess: true,
                                      onTap: () => Get.to(
                                        const AggByDocScreen(),
                                        arguments: {
                                          "aggregationID": aggregationPembayaran
                                              ?.mpayWdrGrpPayNo,
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        aggregationMinus?.aggMinDoc.isNotEmpty ?? false
                            ? SizedBox(
                                width: screenWidth < 400
                                    ? Get.width / 2.3
                                    : Get.width / 2.2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Aggregasi Minus".tr,
                                        textAlign: TextAlign.left,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
                                                fontSize: screenWidth < 400
                                                    ? 12
                                                    : 14)),
                                    const SizedBox(height: 3),
                                    TypeTransactionCard(
                                      value1:
                                          aggregationMinus?.aggMinDoc ?? '-',
                                      value2:
                                          'Rp. ${aggregationMinus?.codAmt.toCurrency().toString() ?? '0'}',
                                      description: aggregationMinus?.createddtm
                                              .toLongDateTimeFormat() ??
                                          '-',
                                      lineColor: errorLightColor3,
                                      value1fontSize: 12,
                                      value2fontSize: 14,
                                      onTap: () => Get.to(
                                        const AggregationMinusDocScreen(),
                                        arguments: {
                                          "doc": aggregationMinus?.aggMinDoc,
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
