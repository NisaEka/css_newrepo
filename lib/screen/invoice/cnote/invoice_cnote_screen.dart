import 'package:css_mobile/data/model/invoice/invoice_cnote_model.dart';
import 'package:css_mobile/screen/invoice/cnote/detail/invoice_cnote_detail_screen.dart';
import 'package:css_mobile/screen/invoice/cnote/invoice_cnote_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/invoice/invoice_cnote_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceCnoteScreen extends StatelessWidget {
  const InvoiceCnoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<InvoiceCnoteController>(
      init: InvoiceCnoteController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Tagihan Kamu".tr),
          body: _invoiceBody(context, controller),
        );
      },
    );
  }

  Widget _invoiceBody(BuildContext context, InvoiceCnoteController controller) {
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

    return _mainContent(context, controller);
  }

  Widget _mainContent(BuildContext context, InvoiceCnoteController controller) {
    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => Future.sync(() => controller.refreshInvoices()),
            child: PagedListView.separated(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<InvoiceCnoteModel>(
                transitionDuration: const Duration(milliseconds: 500),
                itemBuilder: (context, item, index) {
                  double paddingTop = index == 0 ? 16 : 0;
                  return Padding(
                    padding: EdgeInsets.only(top: paddingTop),
                    child: InvoiceCnoteItem(
                      invoice: item,
                      onTap: (String invoiceNumber) {
                        Get.to(
                          const InvoiceCnoteDetailScreen(),
                          arguments: {
                            "invoice_number": controller.invoiceNumber,
                            "awb": item.awbNumber
                          },
                        );
                      },
                    ),
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
