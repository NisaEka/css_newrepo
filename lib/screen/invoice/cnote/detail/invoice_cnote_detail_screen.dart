import 'package:css_mobile/data/model/invoice/invoice_cnote_detail_model.dart';
import 'package:css_mobile/screen/invoice/cnote/detail/invoice_cnote_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/text_col_item.dart';
import 'package:flutter/cupertino.dart';
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
          appBar: CustomTopBar(title: "Detail AWB Info".tr),
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
            padding: const EdgeInsets.all(16),
            child: _basicSection(context, controller.invoiceCnoteDetailModel!),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "Informasi Biaya",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
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
              title: "AWB Number".tr,
              value: invoiceDetail.awbNumber,
            ),
            TextColItem(
              title: "AWB Date".tr,
              value: invoiceDetail.awbDate,
            ),
            TextColItem(
              title: "Shipper Name".tr,
              value: invoiceDetail.shipperName,
            ),
            TextColItem(
              title: "Consignee Name".tr,
              value: invoiceDetail.consigneeName,
            ),
            TextColItem(
              title: "Quantity".tr,
              value: (invoiceDetail.quantity ?? 0).toString(),
            ),
            TextColItem(
              title: "Weight (KG)".tr,
              value: (invoiceDetail.weightKg ?? 0).toString(),
            ),
            TextColItem(
              title: "Serivce Code".tr,
              value: invoiceDetail.serviceCode,
            ),
            TextColItem(
              title: "Origin Name".tr,
              value: invoiceDetail.originName,
            ),
            TextColItem(
              title: "Destination Name".tr,
              value: invoiceDetail.destinationName,
              lastItem: true,
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
              title: "Original Amount".tr,
              value:
                  "Rp${(invoiceDetail.originalAmountNumber ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Packing".tr,
              value: "Rp${(invoiceDetail.packing ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Surcharge".tr,
              value: "Rp${(invoiceDetail.surcharge ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Other Charges".tr,
              value: "Rp${(invoiceDetail.otherCharges ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Discount Amount AWB".tr,
              value: "Rp${(invoiceDetail.discountAmountAwb ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Total Adjusted Insurance Amount".tr,
              value:
                  "Rp${(invoiceDetail.totalAdjustedInsAmt ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Goods Value".tr,
              value: "Rp${(invoiceDetail.goodsValue ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "Presentase COD Fee".tr,
              value: "Rp${(invoiceDetail.persentaseCodFee ?? 0).toCurrency()}",
            ),
            TextColItem(
              title: "COD Fee Amount".tr,
              value: "Rp${(invoiceDetail.codFeeAmount ?? 0).toCurrency()}",
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
