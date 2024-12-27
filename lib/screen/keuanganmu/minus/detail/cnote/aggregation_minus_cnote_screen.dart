import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/util/ext/int_ext.dart';

class AggregationMinusCnoteScreen extends StatelessWidget {
  final AggregationMinusDocModel data;

  const AggregationMinusCnoteScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _aggregationMinusCnoteAppBar(), body: _bodyContent(context));
  }

  PreferredSizeWidget _aggregationMinusCnoteAppBar() {
    return CustomTopBar(
      title: 'Laporan Aggregasi Minus'.tr,
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: const EdgeInsets.all(0),
            child: Column(
              children: [
                Text(
                  data.dCnoteNo ?? '',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: primaryColor(context)),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Container(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      right: 20), // Margin between the two text widgets
                  child: Text(
                    'Informasi Aggregasi'.tr,
                    style: listTitleTextStyle.copyWith(
                      color: primaryColor(context),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "No Document".tr,
                  data.dAggMinDoc ?? '-',
                  false,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Pay Reff".tr,
                  data.dAggPayRef ?? '-',
                  false,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal Aggregasi".tr,
                  data.dAggDate?.toShortDateFormat() ?? '-',
                  false,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: greyLightColor3,
                ),
                const SizedBox(height: 16),
                Container(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      right: 20), // Margin between the two text widgets
                  child: Text(
                    'Informasi Kiriman'.tr,
                    style: listTitleTextStyle.copyWith(
                      color: primaryColor(context),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "${data.dCustId} - ${data.dCustName}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal Cnote".tr,
                  data.dCnoteDate?.toDateTimeFormat(),
                  false,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Order ID".tr,
                  data.dOrderid ?? '-',
                  false,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "POD Code".tr,
                  data.dPodCode ?? '-',
                  false,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal POD".tr,
                  data.dPodDateSys?.toDateTimeFormat(),
                  false,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: greyLightColor3,
                ),
                const SizedBox(height: 16),
                Container(
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(
                      right: 20), // Margin between the two text widgets
                  child: Text(
                    'Detail Aggregasi'.tr,
                    style: listTitleTextStyle.copyWith(
                      color: primaryColor(context),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "Freight Charge".tr,
                  'Rp. ${data.dShipFee?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Discount".tr,
                  'Rp. ${data.dDiscount?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Freight Charge After Discount".tr,
                  'Rp. ${data.dFchargeAftDisc?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Freight Charge VAT".tr,
                  'Rp. ${data.dFchargeVat?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "COD Amount".tr,
                  'Rp. ${data.dCodAmt?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "COD Fee".tr,
                  'Rp. ${data.dCodFee?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "COD Fee Include VAT".tr,
                  'Rp. ${data.dCodfeeInclvat?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 2.0,
                  dashColor: greyLightColor3,
                  dashGapLength: 2.0,
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "Insurance Charge".tr,
                  'Rp. ${data.dInsCharge?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Packing Fee".tr,
                  'Rp. ${data.dPackingFee?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Surcharge".tr,
                  'Rp. ${data.dSurcharge?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 2.0,
                  dashColor: greyLightColor3,
                  dashGapLength: 2.0,
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "Return Fee".tr,
                  'Rp. ${data.dReturnFee?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Return Freight Charge After Discount".tr,
                  'Rp. ${data.dRtFchargeAftDisc?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Return Freight Charge VAT".tr,
                  'Rp. ${data.dRtFchargeVat?.toInt().toCurrency() ?? 0}',
                  false,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 16),
                const DottedLine(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.center,
                  lineLength: double.infinity,
                  lineThickness: 1.0,
                  dashLength: 2.0,
                  dashColor: greyLightColor3,
                  dashGapLength: 2.0,
                ),
                const SizedBox(height: 16),
                _textRow(context, "Netto AWB Amount".tr,
                    'Rp. ${data.dNetAwbAmt?.toInt().toCurrency() ?? 0}', false,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? successColor
                            : successLightColor1),
                    titleStyle: Theme.of(context).textTheme.titleMedium),
                const SizedBox(
                  height: 50,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textRow(
      BuildContext context, String title, String? value, bool isLoading,
      {TextStyle? style, TextStyle? titleStyle}) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Spread the columns
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          // Ensures that the title takes up only as much space as it needs
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                title.tr,
                style: titleStyle ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          // Makes the value take the rest of the space in the row
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                value,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
                textAlign: TextAlign.end, // Align the value to the right
              ),
            ),
          ),
        ),
      ],
    );
  }
}
