import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/invoice/invoice_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'invoice_controller.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceController>(
      init: InvoiceController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Tagihan Kamu".tr),
          body: _mainContent(context, controller),
        );
      },
    );
  }

  Widget _mainContent(BuildContext context, InvoiceController controller) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            color: Theme.of(context).colorScheme.outline,
            onRefresh: () => Future.sync(() => controller.refreshInvoices()),
            child: PagedListView.separated(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<InvoiceModel>(
                itemBuilder: (context, item, index) {
                  double paddingTop = index == 0 ? 16 : 0;
                  return Padding(
                    padding: EdgeInsets.only(top: paddingTop),
                    child: InvoiceItem(
                      invoice: item,
                      onTap: (String invoiceNumber) {
                        Get.to(const InvoiceDetailScreen(), arguments: {
                          "invoice_number": item.invoiceNoEncoded
                        });
                      },
                    ),
                  );
                },
                firstPageProgressIndicatorBuilder: (BuildContext context) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.outline,
                    ),
                  );
                },
                newPageProgressIndicatorBuilder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                  );
                },
                firstPageErrorIndicatorBuilder: (BuildContext context) {
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
                },
                noItemsFoundIndicatorBuilder: (BuildContext context) {
                  return const Center(
                    child: Text("Tidak ada data tersedia"),
                  );
                },
                noMoreItemsIndicatorBuilder: (BuildContext context) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      ".",
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  );
                },
                transitionDuration: const Duration(milliseconds: 500),
              ),
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
