import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/invoice/cnote/detail/invoice_cnote_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 30, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // AWB
              Shimmer(
                isLoading: controller.isLoading,
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          controller.isLoading ? greyColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.invoiceCnoteDetailModel?.awbNumber ?? '',
                            style: appTitleTextStyle.copyWith(
                                fontWeight: bold, color: primaryColor(context)),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            controller.invoiceCnoteDetailModel?.picuUpOrderId ??
                                '',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                    fontSize: 9, fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () => Clipboard.setData(ClipboardData(
                            text:
                                controller.invoiceCnoteDetailModel?.awbNumber ??
                                    '')),
                        icon: const Icon(Icons.copy_rounded),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _textRow(
                context,
                "AWB Date".tr,
                controller.invoiceCnoteDetailModel?.awbDate
                        ?.toLongDateTimeFormat() ??
                    '',
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Shipper Name".tr,
                controller.invoiceCnoteDetailModel?.shipperName,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Receiver Name".tr,
                controller.invoiceCnoteDetailModel?.consigneeName,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? Colors.black
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Qty".tr,
                (controller.invoiceCnoteDetailModel?.quantity ?? 0).toString(),
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Weight".tr,
                (controller.invoiceCnoteDetailModel?.weightKg ?? 0).toString(),
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Service".tr,
                controller.invoiceCnoteDetailModel?.serviceCode,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              const SizedBox(height: 12),
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
                "Origin Code".tr,
                controller.invoiceCnoteDetailModel?.originSysCode,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Origin Name".tr,
                controller.invoiceCnoteDetailModel?.originName,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Destination Code".tr,
                controller.invoiceCnoteDetailModel?.destinationSysCode,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              _textRow(
                context,
                "Destination Name".tr,
                controller.invoiceCnoteDetailModel?.destinationName,
                controller.isLoading,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppConst.isLightTheme(context)
                        ? greyDarkColor1
                        : greyLightColor1),
              ),
              const SizedBox(height: 6),
              const Divider(
                color: greyLightColor3,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        // Informasi Tagihan
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 35,
          ),
          child: Shimmer(
            isLoading: controller.isLoading,
            child: Container(
              decoration: BoxDecoration(
                  color: controller.isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                "Informasi Tagihan",
                style: listTitleTextStyle.copyWith(
                  color: primaryColor(context),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 35, right: 30, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _textRow(
                context,
                "Freight Charge".tr,
                "Rp. ${(controller.invoiceCnoteDetailModel?.originalAmountNumber ?? 0).toCurrency()}",
                controller.isLoading,
                style: TextStyle(
                  fontWeight: bold,
                  color: primaryColor(context),
                ),
              ),
              _textRow(
                context,
                "Total Packing & Charges".tr,
                "Rp. ${((controller.invoiceCnoteDetailModel?.originalAmountNumber ?? 0) + (controller.invoiceCnoteDetailModel?.surcharge ?? 0) + (controller.invoiceCnoteDetailModel?.otherCharges ?? 0)).toCurrency()}",
                controller.isLoading,
                style: TextStyle(
                  fontWeight: bold,
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              ),
              _textRow(
                  context,
                  "Discount Amount".tr,
                  "Rp. ${(controller.invoiceCnoteDetailModel?.discountAmountAwb ?? 0).toCurrency()}",
                  controller.isLoading),
              _textRow(
                context,
                "Total Amount After Disc & Charges".tr,
                "Rp. ${(((controller.invoiceCnoteDetailModel?.originalAmountNumber ?? 0) + (controller.invoiceCnoteDetailModel?.surcharge ?? 0) + (controller.invoiceCnoteDetailModel?.otherCharges ?? 0)) - (controller.invoiceCnoteDetailModel?.discountAmountAwb ?? 0)).abs().toCurrency()}",
                controller.isLoading,
                style: TextStyle(
                  fontWeight: bold,
                  color: AppConst.isLightTheme(context) ? redJNE : warningColor,
                ),
              ),
              _textRow(
                  context,
                  "Insurance".tr,
                  "Rp. ${((controller.invoiceCnoteDetailModel?.totalAdjustedInsAmt ?? 0)).toCurrency()}",
                  controller.isLoading),
              _textRow(
                context,
                "Total Paid".tr,
                "Rp. ${(((controller.invoiceCnoteDetailModel?.originalAmountNumber ?? 0) + (controller.invoiceCnoteDetailModel?.surcharge ?? 0) + (controller.invoiceCnoteDetailModel?.otherCharges ?? 0)) - ((controller.invoiceCnoteDetailModel?.discountAmountAwb ?? 0) + (controller.invoiceCnoteDetailModel?.totalAdjustedInsAmt ?? 0))).abs().toCurrency()}",
                controller.isLoading,
                style: TextStyle(fontWeight: bold, color: successLightColor1),
                titleFontWeight: bold,
              ),
              const SizedBox(height: 10),
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
                  "Goods Value".tr,
                  "Rp. ${(controller.invoiceCnoteDetailModel?.goodsValue ?? 0).toCurrency()}",
                  controller.isLoading),
              _textRow(
                  context,
                  "COD Amount".tr,
                  "Rp. ${(controller.invoiceCnoteDetailModel?.codAmount ?? 0).toCurrency()}",
                  controller.isLoading),
              _textRow(
                  context,
                  "% COD Fee".tr,
                  "Rp. ${(controller.invoiceCnoteDetailModel?.persentaseCodFee ?? 0).toCurrency()}",
                  controller.isLoading),
              _textRow(
                  context,
                  "COD Fee Amount".tr,
                  "Rp. ${(controller.invoiceCnoteDetailModel?.codFeeAmount ?? 0).toCurrency()}",
                  controller.isLoading),
              _textRow(
                  context,
                  "COD Fee Zone".tr,
                  controller.invoiceCnoteDetailModel?.codFeeZone,
                  controller.isLoading),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _textRow(
      BuildContext context, String title, String? value, bool isLoading,
      {TextStyle? style, FontWeight? titleFontWeight}) {
    if (value == null) {
      return Container();
    }

    return Column(
      children: [
        Row(
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
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: titleFontWeight ?? regular),
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
        ),
        const SizedBox(height: 6)
      ],
    );
  }
}
