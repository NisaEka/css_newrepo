import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/lappembayaran_box.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/value_item.dart';
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

  Widget _bodyContent(AggByCnoteController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          PaymentBox(
            title: "Connote No".tr,
            value: "# ${c.data.cnoteNo}",
          ),
          Expanded(
            child: ListView(
              children: [
                CustomFormLabel(
                  label: "Informasi Kiriman".tr,
                  isBold: true,
                ),
                ValueItem(
                  title: c.data.custName ?? '',
                  fontSize: 12,
                  width: 0,
                ),
                ValueItem(
                  title: "Tanggal Cnote".tr,
                  value: c.data.cnoteDate?.toShortDateFormat() ?? '-',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Order ID".tr,
                  value: c.data.orderIdTmp ?? '-',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "POD".tr,
                  value: '${c.data.podCode ?? ''} - ${c.data.podGroupName ?? '-'}',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Tanggal POD".tr,
                  value: c.data.podDateSys?.toDateTimeFormat(),
                  fontSize: 12,
                ),
                const Divider(
                  thickness: 5,
                  color: greyColor,
                ),
                CustomFormLabel(
                  label: "Informasi Aggregasi".tr,
                  isBold: true,
                ),
                ValueItem(
                  title: "Document No".tr,
                  value: c.data.aggDocNo ?? '-',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Pay Reff".tr,
                  value: c.data.aggPayReff ?? '-',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Tanggal Aggregasi".tr,
                  value: c.data.aggDocDate?.toShortDateFormat() ?? '-',
                  fontSize: 12,
                ),
                const Divider(
                  thickness: 5,
                  color: greyColor,
                ),
                CustomFormLabel(
                  label: "Detail Aggregasi".tr,
                  isBold: true,
                ),
                ValueItem(
                  title: "COD Amount".tr,
                  value: 'Rp ${c.data.codAmount?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: blueJNE,
                ),
                const Divider(),
                ValueItem(
                  title: "Freight Charge".tr,
                  value: 'Rp ${c.data.freightCharge?.toInt().toCurrency()}',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Insurance Charge".tr,
                  value: 'Rp ${c.data.insuranceCharge?.toInt().toCurrency()}',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Discount".tr,
                  value: 'Rp ${c.data.discount?.toInt().toCurrency()}',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Freight Charge After Discount".tr,
                  value: '-Rp ${c.data.fchargeDisc?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Freight Charge VAT".tr,
                  value: '-Rp ${c.data.fchargeVat?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Packing Fee".tr,
                  value: 'Rp ${c.data.packingFee?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Surcharge".tr,
                  value: 'Rp ${c.data.surcharge?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Return Freight Charge After Discount".tr,
                  value: 'Rp ${c.data.rtfChargeDisc?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Return Freight Charge VAT".tr,
                  value: 'Rp ${c.data.rtfChargeVat?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                const Divider(),
                ValueItem(
                  title: "COD Fee Include VAT".tr,
                  value: 'Rp ${c.data.codFeeVat?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Netto AWB Amount".tr,
                  value: 'Rp ${c.data.netAwbAmt?.toInt().toCurrency()}',
                  fontSize: 12,
                  valueFontColor: successColor,
                ),
                ValueItem(
                  title: 'Paid Date',
                  value: c.data.paidDate?.toDateTimeFormat() ?? '-',
                  fontSize: 12,
                  valueTextStyle: TextStyle(fontWeight: regular, fontSize: 12),
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
}
