import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'invoice_controller.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
      init: InvoiceController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Tagihan Kamu".tr),
          body: _invoiceBody(context, controller),
        );
      },
    );
  }

  Widget _invoiceBody(BuildContext context, InvoiceController controller) {
    if (controller.showLoadingIndicator) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.showEmptyContent) {
      return const Center(child: Text("Tidak ada data tersedia"));
    }

    if (controller.showErrorContent) {
      return Center(
        child: Column(
          children: [
            Text("Terjadi kesalahan ketika mengambil data".tr),
            const Padding(padding: EdgeInsets.only(top: 16)),
            FilledButton(
              onPressed: () => controller.requireRetry(),
              child: const Text("Muat ulang"),
            )
          ],
        ),
      );
    }

    if (controller.showMainContent) {
      // return _mainContentStack(context, controller);
    }

    return Text("No Content".tr);
  }

}