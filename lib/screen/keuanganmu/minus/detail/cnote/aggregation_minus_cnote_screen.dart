import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/laporan_pembayaran/aggregation_minus_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregationMinusCnoteScreen extends StatelessWidget {

  final AggregationMinusDocModel data;

  const AggregationMinusCnoteScreen({
    super.key,
    required this.data
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _aggregationMinusCnoteAppBar(),
      body: _bodyContent()
    );
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
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16
          ),
          child: AggregationMinusBox(
            title: "Connote No".tr,
            value: data.cnoteNo ?? "",
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
          sliver: SliverToBoxAdapter(
            child: _deliveryInfoContent()
          ),
        ),
        _contentDivider(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
              child: _aggregationInfoContent()
          ),
        ),
        _contentDivider(),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
              child: _aggregationDetailContent()
          ),
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
        _rowText("${data.custId} - ${data.custName}", ""),
        _rowText("Connote Date".tr, data.cnoteDate?.toDateFormat() ?? ""),
        _rowText("Order Id".tr, data.orderId ?? ""),
        _rowText("POD Code".tr, data.podCode ?? ""),
        _rowText("POD Date".tr, data.podDateSys?.toDateFormat() ?? "")
      ],
    );
  }

  Widget _aggregationInfoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleText("Informasi Aggregasi".tr),
        _rowText("Document No".tr, data.aggMinDoc ?? ""),
        _rowText("Document Date".tr, data.docDate?.toDateFormat() ?? ""),
        _rowText("Pay Ref".tr, data.aggPayRef ?? ""),
        _rowText("Aggregation Date".tr, data.aggDate?.toDateFormat() ?? ""),
        _rowText("COD Type".tr, data.codType ?? ""),
        _rowText("Pay Type".tr, data.payType ?? ""),
        _rowText("Aggregation Period".tr, data.aggPeriod ?? "")
      ],
    );
  }

  Widget _aggregationDetailContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleText("Detail Aggregasi".tr),
        _rowText("Shipping Fee".tr, data.shipFee?.toString() ?? ""),
        _rowText("Insurance Charge".tr, data.insuranceCharge?.toString() ?? ""),
        _rowText("COD Fee".tr, data.codFee?.toString() ?? ""),
        _rowText("Return Fee".tr, data.returnFee?.toString() ?? ""),
        _rowText("COD Amount".tr, data.codAmount?.toString() ?? ""),
        _rowText("Discount".tr, data.discount?.toString() ?? ""),
        _rowText("Freight Charge After Discount".tr, data.freightChargeAfterDisc?.toString() ?? ""),
        _rowText("Freight Charge VAT".tr, data.freightChargeVat?.toString() ?? ""),
        _rowText("Packing Fee".tr, data.packingFee?.toString() ?? ""),
        _rowText("Surcharge".tr, data.surcharge?.toString() ?? ""),
        const Divider(thickness: 0.5),
        _rowText("Return Freight Charge After Discount".tr, data.returnFreightChargeAfterDisc?.toString() ?? ""),
        _rowText("Return Freight Charge VAT".tr, data.returnFreightChargeVat?.toString() ?? ""),
        _rowText("COD Fee Include VAT".tr, data.codFeeIncludeVat?.toString() ?? ""),
        const Divider(thickness: 0.5),
        _rowText("Netto AWB Amount".tr, data.netAwbAmount?.toString() ?? "")
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
      )
    );
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