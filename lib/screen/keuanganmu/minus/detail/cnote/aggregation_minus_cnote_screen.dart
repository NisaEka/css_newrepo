import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregationMinusCnoteScreen extends StatelessWidget {
  final AggregationMinusDocModel data;

  const AggregationMinusCnoteScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _aggregationMinusCnoteAppBar(), body: _bodyContent());
  }

  PreferredSizeWidget _aggregationMinusCnoteAppBar() {
    return CustomTopBar(
      title: 'Laporan Aggregasi Minus'.tr,
    );
  }

  Widget _bodyContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
          child: AggregationMinusBox(
            title: "Connote No".tr,
            value: data.dCnoteNo ?? "",
          ),
        ),
        Expanded(
          child: _aggregationMinusCnoteContent(),
        )
      ],
    );
  }

  Widget _aggregationMinusCnoteContent() {
    return CustomScrollView(
      slivers: [
        _contentSpacer(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(child: _deliveryInfoContent()),
        ),
        _contentDivider(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(child: _aggregationInfoContent()),
        ),
        _contentDivider(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(child: _aggregationDetailContent()),
        ),
        _contentSpacer()
      ],
    );
  }

  Widget _contentSpacer() {
    return const SliverPadding(
      padding: EdgeInsets.only(bottom: 16),
    );
  }

  Widget _contentDivider() {
    return const SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8),
      sliver: SliverToBoxAdapter(
        child: Divider(thickness: 4),
      ),
    );
  }

  Widget _deliveryInfoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleText("Informasi Kiriman".tr),
        _rowText("${data.dCustId} - ${data.dCustName}", ""),
        _rowText("Connote Date".tr, data.dCnoteDate?.toDateFormat() ?? ""),
        _rowText("Order Id".tr, data.dOrderid ?? ""),
        _rowText("POD Code".tr, data.dPodCode ?? ""),
        _rowText("POD Date".tr, data.dPodDateSys?.toDateFormat() ?? "")
      ],
    );
  }

  Widget _aggregationInfoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleText("Informasi Aggregasi".tr),
        _rowText("Document No".tr, data.dAggMinDoc ?? ""),
        _rowText("Document Date".tr, data.dDocDate?.toDateFormat() ?? ""),
        _rowText("Pay Ref".tr, data.dAggPayRef ?? ""),
        _rowText("Aggregation Date".tr, data.dAggDate?.toDateFormat() ?? ""),
        _rowText("COD Type".tr, data.dCodType ?? ""),
        _rowText("Pay Type".tr, data.dPayType ?? ""),
        _rowText("Aggregation Period".tr, data.dAggPeriod ?? "")
      ],
    );
  }

  Widget _aggregationDetailContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleText("Detail Aggregasi".tr),
        _rowText("Shipping Fee".tr, data.dShipFee?.toString() ?? ""),
        _rowText("Insurance Charge".tr, data.dInsCharge?.toString() ?? ""),
        _rowText("COD Fee".tr, data.dCodFee?.toString() ?? ""),
        _rowText("Return Fee".tr, data.dReturnFee?.toString() ?? ""),
        _rowText("COD Amount".tr, data.dCodAmt?.toString() ?? ""),
        _rowText("Discount".tr, data.dDiscount?.toString() ?? ""),
        _rowText("Freight Charge After Discount".tr,
            data.dFchargeAftDisc?.toString() ?? ""),
        _rowText("Freight Charge VAT".tr, data.dFchargeVat?.toString() ?? ""),
        _rowText("Packing Fee".tr, data.dPackingFee?.toString() ?? ""),
        _rowText("Surcharge".tr, data.dSurcharge?.toString() ?? ""),
        const Divider(thickness: 0.5),
        _rowText("Return Freight Charge After Discount".tr,
            data.dRtFchargeAftDisc?.toString() ?? ""),
        _rowText("Return Freight Charge VAT".tr,
            data.dRtFchargeVat?.toString() ?? ""),
        _rowText(
            "COD Fee Include VAT".tr, data.dCodfeeInclvat?.toString() ?? ""),
        const Divider(thickness: 0.5),
        _rowText("Netto AWB Amount".tr, data.dNetAwbAmt?.toString() ?? "")
      ],
    );
  }

  Widget _titleText(String text) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: listTitleTextStyle,
          textAlign: TextAlign.start,
        ));
  }

  Widget _rowText(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: sublistTitleTextStyle,
        ),
        Text(
          value,
          style: sublistTitleTextStyle,
        )
      ],
    );
  }
}
