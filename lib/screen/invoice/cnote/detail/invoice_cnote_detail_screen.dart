import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/screen/invoice/cnote/detail/invoice_cnote_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:css_mobile/widgets/items/text_col_item.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceCnoteDetailScreen extends StatelessWidget {
  const InvoiceCnoteDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InvoiceCnoteDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Detail Invoice".tr),
          body: RefreshIndicator(
            color: Theme.of(context).colorScheme.outline,
            onRefresh: () => Future.sync(() => controller.refreshInvoice()),
            child: _detailBody(context, controller),
          ),
        );
      },
    );
  }

  Widget _detailBody(
    BuildContext context,
    InvoiceCnoteDetailController controller,
  ) {
    if (controller.showLoadingIndicator) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.outline,
        ),
      );
    }

    if (controller.showEmptyContent) {
      return const Center(child: Text("Not Found"));
    }

    if (controller.showErrorContent) {
      return const Center(child: Text("Error"));
    }

    if (controller.showMainContent) {
      return _mainContent(context, controller);
    }

    return Container();
  }

  Widget _mainContent(
    BuildContext context,
    InvoiceCnoteDetailController controller,
  ) {
    return Expanded(
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomCodeLabel(
                  label: controller.invoiceCnoteDetailModel?.awbNumber ?? '',
                  isLoading: false,
                  alignment: MainAxisAlignment.start,
                ),
                Text(
                  'FILLWITHORDERNUMBER',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(fontSize: 10),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _basicSection(context, controller.invoiceCnoteDetailModel!),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 35,
            ),
            child: Text(
              "Informasi Tagihan",
              style: listTitleTextStyle.copyWith(
                color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child:
                _paymentSection(context, controller.invoiceCnoteDetailModel!),
          )
        ],
      ),
    );
  }

  Widget _basicSection(
    BuildContext context,
    InvoiceCnoteDetailModel invoiceDetail,
  ) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "AWB Date".tr,
              value: invoiceDetail.awbDate,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Shipper Name".tr,
              value: invoiceDetail.shipperName,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Consignee Name".tr,
              value: invoiceDetail.consigneeName,
              valueStyle: TextStyle(fontWeight: bold),
            ),
            TextColItem(
              title: "Qty".tr,
              value: (invoiceDetail.quantity ?? 0).toString(),
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Weight".tr,
              value: (invoiceDetail.weightKg ?? 0).toString(),
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Service".tr,
              value: invoiceDetail.serviceCode,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            const SizedBox(height: 10),
            const DottedLine(
              dashColor: greyLightColor3,
              dashLength: 4.0,
              dashGapLength: 2.0,
              lineThickness: 1.0,
              lineLength: double.infinity,
            ),
            const SizedBox(height: 10),
            TextColItem(
              title: "Origin Name".tr,
              value: invoiceDetail.originName,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Destination Code".tr,
              value: invoiceDetail.destinationSysCode,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            TextColItem(
              title: "Destination Name".tr,
              value: invoiceDetail.destinationName,
              lastItem: true,
              valueStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppConst.isLightTheme(context)
                      ? greyDarkColor1
                      : greyLightColor1),
            ),
            const Divider(
              color: greyLightColor3,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentSection(
    BuildContext context,
    InvoiceCnoteDetailModel invoiceDetail,
  ) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Freight Charge".tr,
              value:
                  "Rp. ${(invoiceDetail.originalAmountNumber ?? 0).toCurrency()}",
              valueStyle: TextStyle(
                fontWeight: bold,
                color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              ),
            ),
            TextColItem(
              title: "Total Packing & Charges".tr,
              value:
                  "Rp. ${((invoiceDetail.originalAmountNumber ?? 0) + (invoiceDetail.surcharge ?? 0) + (invoiceDetail.otherCharges ?? 0)).toCurrency()}",
              valueStyle: TextStyle(
                fontWeight: bold,
                color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
              ),
            ),
            TextColItem(
              title: "Discount Amount".tr,
              value:
                  "Rp. ${(invoiceDetail.discountAmountAwb ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Total Amount After Disc & Charges".tr,
              value:
                  "Rp. ${(((invoiceDetail.originalAmountNumber ?? 0) + (invoiceDetail.surcharge ?? 0) + (invoiceDetail.otherCharges ?? 0)) - (invoiceDetail.discountAmountAwb ?? 0)).abs().toCurrency()}",
              valueStyle:
                  const TextStyle(fontWeight: FontWeight.bold, color: redJNE),
            ),
            TextColItem(
              title: "Insurance".tr,
              value:
                  "Rp. ${((invoiceDetail.totalAdjustedInsAmt ?? 0)).abs().toCurrency()}",
            ),
            TextColItem(
              title: "Total Paid".tr,
              value:
                  "Rp. ${(((invoiceDetail.originalAmountNumber ?? 0) + (invoiceDetail.surcharge ?? 0) + (invoiceDetail.otherCharges ?? 0)) - ((invoiceDetail.discountAmountAwb ?? 0) + (invoiceDetail.totalAdjustedInsAmt ?? 0))).abs().toCurrency()}",
              valueStyle: TextStyle(fontWeight: bold, color: successColor),
            ),
            const SizedBox(height: 10),
            const DottedLine(
              dashColor: greyLightColor3,
              dashLength: 4.0,
              dashGapLength: 2.0,
              lineThickness: 1.0,
              lineLength: double.infinity,
            ),
            const SizedBox(height: 10),
            TextColItem(
              title: "Goods Value".tr,
              value: "Rp. ${(invoiceDetail.goodsValue ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "COD Amount".tr,
              value: "Rp. ${(invoiceDetail.codAmount ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "% COD Fee".tr,
              value:
                  "Rp. ${(invoiceDetail.persentaseCodFee ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "COD Fee Amount".tr,
              value: "Rp. ${(invoiceDetail.codFeeAmount ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "COD Fee Zone".tr,
              value: invoiceDetail.codFeeZone,
              lastItem: true,
            ),
          ],
        ),
      ),
    );
  }
}
