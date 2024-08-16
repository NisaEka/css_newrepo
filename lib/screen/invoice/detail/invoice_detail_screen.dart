import 'package:css_mobile/data/model/invoice/invoice_detail_model.dart';
import 'package:css_mobile/screen/invoice/cnote/invoice_cnote_screen.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_controller.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/items/text_col_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoiceDetailScreen extends StatelessWidget {
  const InvoiceDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: InvoiceDetailController(),
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

  Widget _detailBody(BuildContext context, InvoiceDetailController controller) {
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
      BuildContext context, InvoiceDetailController controller) {
    return Expanded(
      child: ListView(
        children: [
          _viewAwbList(
            context,
            controller.invoiceDetailModel!.invoiceNumberEncoded!,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _basicSection(context, controller.invoiceDetailModel!),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "Informasi Pelanggan",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _customerSection(context, controller.invoiceDetailModel!),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Text(
              "Informasi Pembayaran",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _paymentSection(context, controller.invoiceDetailModel!),
          )
        ],
      ),
    );
  }

  Widget _basicSection(BuildContext context, InvoiceDetailModel invoiceDetail) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Invoice Number".tr,
              value: invoiceDetail.invoiceNumber,
            ),
            TextColItem(
              title: "Invoice Date".tr,
              value: invoiceDetail.invoiceDate,
            ),
            TextColItem(
              title: "Term Of Payment".tr,
              value: invoiceDetail.top,
            ),
            TextColItem(
              title: "Description".tr,
              value: invoiceDetail.description,
            ),
            TextColItem(
              title: "Due Date".tr,
              value: invoiceDetail.dueDate,
            ),
            TextColItem(
              title: "Period".tr,
              value: invoiceDetail.period,
            ),
            TextColItem(
              title: "Invoice Status".tr,
              value: invoiceDetail.invoiceStatus,
            ),
            TextColItem(
              title: "Invoice Reference".tr,
              value: invoiceDetail.invoiceReference,
              lastItem: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _customerSection(
      BuildContext context, InvoiceDetailModel invoiceDetailModel) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Customer Id".tr,
              value: invoiceDetailModel.customerId,
            ),
            TextColItem(
              title: "Customer Name".tr,
              value: invoiceDetailModel.customerName,
            ),
            TextColItem(
              title: "Address".tr,
              value: invoiceDetailModel.address,
            ),
            TextColItem(
              title: "Zip Code".tr,
              value: invoiceDetailModel.zipCode,
            ),
            TextColItem(
              title: "Phone".tr,
              value: invoiceDetailModel.phone,
            ),
            TextColItem(
              title: "Email".tr,
              value: invoiceDetailModel.email,
            ),
            TextColItem(
              title: "Tax Number".tr,
              value: invoiceDetailModel.taxNumber,
            ),
            TextColItem(
              title: "Npwp Id".tr,
              value: invoiceDetailModel.npwpId,
            ),
            TextColItem(
              title: "Npwp Name".tr,
              value: invoiceDetailModel.npwpName,
            ),
            TextColItem(
              title: "Npwp Address".tr,
              value: invoiceDetailModel.npwpAddress,
              lastItem: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentSection(
      BuildContext context, InvoiceDetailModel invoiceDetail) {
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextColItem(
              title: "Gross Total".tr,
              value: "Rp${invoiceDetail.grossTotal?.toCurrency()}",
            ),
            TextColItem(
              title: "Discount".tr,
              value: "Rp${invoiceDetail.discount?.toCurrency()}",
            ),
            TextColItem(
              title: "Reward".tr,
              value: "Rp${invoiceDetail.reward?.toCurrency()}",
            ),
            TextColItem(
              title: "Total After Discount".tr,
              value: "Rp${invoiceDetail.totalAfterDiscount?.toCurrency()}",
            ),
            TextColItem(
              title: "VAT".tr,
              value: "Rp${invoiceDetail.vat?.toCurrency()}",
            ),
            TextColItem(
              title: "Commission Fee".tr,
              value: "Rp${invoiceDetail.commissionFee?.toCurrency()}",
            ),
            TextColItem(
              title: "VAT Commission Fee".tr,
              value: "Rp${invoiceDetail.vatCommissionFee?.toCurrency()}",
            ),
            TextColItem(
              title: "Insurance".tr,
              value: "Rp${invoiceDetail.insurance?.toCurrency()}",
            ),
            TextColItem(
              title: "Stamp".tr,
              value: "Rp${invoiceDetail.stamp?.toCurrency()}",
            ),
            TextColItem(
              title: "Total Paid".tr,
              value: "Rp${invoiceDetail.totalPaid?.toCurrency()}",
              lastItem: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _viewAwbList(BuildContext context, String encodedInvoiceNumber) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Get.to(
          const InvoiceCnoteScreen(),
          arguments: { "invoice_number": encodedInvoiceNumber }
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Daftar Transaksi".tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );
  }
}
