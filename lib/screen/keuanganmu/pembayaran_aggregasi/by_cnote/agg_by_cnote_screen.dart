import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/keuanganmu/pembayaran_aggregasi/by_cnote/agg_by_cnote_controller.dart';
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
            title: "Document No".tr,
            value: "# JNEPWD2400000662",
          ),
          Expanded(
            child: ListView(
              children: [
                CustomFormLabel(
                  label: "Informasi Kiriman".tr,
                  isBold: true,
                ),
                const ValueItem(
                  title: "80774504 - HUDA MUSLIM / COD",
                  fontSize: 12,
                  width: 0,
                ),
                ValueItem(
                  title: "Tanggal Cnote".tr,
                  value: '24-APR-24',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Order ID".tr,
                  value: '191613172',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "POD".tr,
                  value: 'D01 - D - Delivered',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Tanggal POD".tr,
                  value: '13-05-2024 22:32:06',
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
                  value: 'JNEPWD2400026931',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Pay Reff".tr,
                  value: 'JNEPNW2400023328',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Tanggal Aggregasi".tr,
                  value: '14-MAY-24',
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
                  value: 'Rp165.000',
                  fontSize: 12,
                  valueFontColor: blueJNE,
                ),
                const Divider(),
                ValueItem(
                  title: "Freight Charge".tr,
                  value: 'Rp165.000',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Insurance Charge".tr,
                  value: 'Rp165.000',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Discount".tr,
                  value: 'Rp165.000',
                  fontSize: 12,
                ),
                ValueItem(
                  title: "Freight Charge After Discount".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Freight Charge VAT".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Packing Fee".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Surcharge".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Return Freight Charge After Discount".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Return Freight Charge VAT".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                const Divider(),
                ValueItem(
                  title: "COD Fee Include VAT".tr,
                  value: '-Rp165.000',
                  fontSize: 12,
                  valueFontColor: errorColor,
                ),
                ValueItem(
                  title: "Netto AWB Amount".tr,
                  value: 'Rp165.000',
                  valueTextStyle: listTitleTextStyle.copyWith(fontSize: 12, color: successColor, fontWeight: FontWeight.bold),
                ),
                const ValueItem(
                  title: 'Paid Date',
                  value: '14-05-2024 20:38:00',
                ),
                const SizedBox(height: 50,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
