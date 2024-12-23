import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggByCnoteScreen extends StatelessWidget {
  const AggByCnoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AggByCnoteController>(
      init: AggByCnoteController(),
      builder: (controller) => Scaffold(
        appBar: CustomTopBar(
          title: 'Laporan Pembayaran Aggregasi'.tr,
        ),
        body: _bodyContent(controller, context),
      ),
    );
  }

  Widget _bodyContent(AggByCnoteController controller, BuildContext context) {
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
                  Shimmer(
                    isLoading: controller.isLoading,
                    child: Container(
                      height: controller.isLoading ? 20 : null,
                      width: controller.isLoading ? Get.width / 2 : null,
                      color: controller.isLoading ? greyColor : null,
                      child: Text(
                        controller.data.dpayDetWdrCnoteno ?? '',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: AppConst.isLightTheme(context)
                                ? blueJNE
                                : warningColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Shimmer(
                  isLoading: controller.isLoading,
                  child: Container(
                    color:
                        controller.isLoading ? greyColor : Colors.transparent,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        right: 20), // Margin between the two text widgets
                    child: Text(
                      'Informasi Aggregasi'.tr,
                      style: listTitleTextStyle.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? blueJNE
                            : warningColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "No Document".tr,
                  controller.data.mpayWdrGrpPayNo,
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Pay Reff".tr,
                  controller.data.dpayDetWdrNo ?? '-',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal Aggregasi".tr,
                  controller.data.mpayWdrDate?.toShortDateFormat() ?? '-',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: greyLightColor3,
                ),
                const SizedBox(height: 16),
                Shimmer(
                  isLoading: controller.isLoading,
                  child: Container(
                    color:
                        controller.isLoading ? greyColor : Colors.transparent,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        right: 20), // Margin between the two text widgets
                    child: Text(
                      'Informasi Kiriman'.tr,
                      style: listTitleTextStyle.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? blueJNE
                            : warningColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Shimmer(
                  isLoading: controller.isLoading,
                  child: Text(
                    controller.data.custName ?? '-',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: regular,
                        ),
                  ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal Cnote".tr,
                  controller.data.dpayDetWdrCnotedate?.toDateTimeFormat(),
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Order ID".tr,
                  controller.data.orderIdTmp ?? '-',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "POD Status".tr,
                  '${controller.data.dpayDetWdrPod ?? ''} - ${controller.data.podGroupName ?? '-'}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Tanggal POD".tr,
                  controller.data.dpayDUpdPodDate?.toDateTimeFormat(),
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                Shimmer(
                  isLoading: controller.isLoading,
                  child: Container(
                    color:
                        controller.isLoading ? greyColor : Colors.transparent,
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                        right: 20), // Margin between the two text widgets
                    child: Text(
                      'Detail Aggregasi'.tr,
                      style: listTitleTextStyle.copyWith(
                        color: AppConst.isLightTheme(context)
                            ? blueJNE
                            : warningColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                _textRow(
                  context,
                  "Paid Date".tr,
                  controller.data.mpayWdrGrpPayDatePaid?.toDateTimeFormat() ??
                      '-',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: regular,
                      ),
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "COD Amount".tr,
                  'Rp. ${controller.data.dpayDetWdrCodamount?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "COD Fee Include VAT".tr,
                  'Rp. ${controller.data.dpayDWdrRtFchargeVat?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Freight Charge".tr,
                  'Rp. ${controller.data.dpayDFreightCharge?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Discount".tr,
                  'Rp. ${controller.data.dpayDWdrDisc?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Freight Charge After Discount".tr,
                  'Rp. ${controller.data.dpayDWdrFchargeAftDisc?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Freight Charge VAT".tr,
                  'Rp. ${controller.data.dpayDWdrFchargeVat?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
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
                  'Rp. ${controller.data.dpayDInsCharge?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Packing Fee".tr,
                  'Rp. ${controller.data.dpayDPackingFee?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Surcharge".tr,
                  'Rp. ${controller.data.dpayDSurcharge?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
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
                  "Return Freight Charge After Discount".tr,
                  'Rp. ${controller.data.dpayDWdrRtFchargeAftDisc?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                _textRow(
                  context,
                  "Return Freight Charge VAT".tr,
                  'Rp. ${controller.data.dpayDWdrCodFeeInclVat?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
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
                  "Netto AWB Amount".tr,
                  'Rp. ${controller.data.dpayDNetAmt?.toInt().toCurrency() ?? 0}',
                  controller.isLoading,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: AppConst.isLightTheme(context)
                          ? successColor
                          : successLightColor1),
                  titleStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppConst.isLightTheme(context)
                          ? blueJNE
                          : warningColor),
                ),
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
              color: isLoading ? greyColor : Colors.transparent,
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
              color: isLoading ? greyColor : Colors.transparent,
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
