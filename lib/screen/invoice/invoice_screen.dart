import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/screen/invoice/components/invoice_filter_button.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/invoice/invoice_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          appBar: CustomTopBar(title: "Tagihan Kamu".tr, action: const [
            InvoiceFilterButton(),
          ]),
          body: _mainContent(context, controller),
        );
      },
    );
  }

  Widget _mainContent(BuildContext context, InvoiceController controller) {
    return Column(
      children: [
        _invoiceSearchBar(context, controller),
        _invoiceCountCard(context, controller),
        _invoiceTitle(context, controller),
        _invoiceList(context, controller),
      ],
    );
  }

  Widget _invoiceSearchBar(BuildContext context, InvoiceController controller) {
    return CustomSearchField(
      controller: controller.searchTextController,
      hintText: 'Cari'.tr,
      prefixIcon: SvgPicture.asset(
        IconsConstant.search,
        color: Theme.of(context).brightness == Brightness.light
            ? whiteColor
            : blueJNE,
      ),
      onChanged: (value) {
        controller.onKeywordChange(value);
      },
      onClear: () {
        controller.onKeywordChange("");
      },
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    );
  }

  Widget _invoiceCountCard(BuildContext context, InvoiceController controller) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(ImageConstant.folderIcon),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Invoice".tr,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    controller.invoiceCount.toString(),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _invoiceTitle(BuildContext context, InvoiceController controller) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Daftar Invoice".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _invoiceList(BuildContext context, InvoiceController controller) {
    return Expanded(
      child: RefreshIndicator(
        color: Theme.of(context).colorScheme.outline,
        onRefresh: () => Future.sync(() => controller.refreshInvoices()),
        child: PagedListView.separated(
          pagingController: controller.pagingController,
          builderDelegate: PagedChildBuilderDelegate<InvoiceModel>(
            itemBuilder: (context, item, index) {
              double paddingTop = index == 0 ? 5 : 0;
              return Padding(
                padding: EdgeInsets.only(top: paddingTop, left: 5, right: 5),
                child: InvoiceItem(
                  invoice: item,
                  onTap: (String invoiceNumber) {
                    Get.to(const InvoiceDetailScreen(),
                        arguments: {"invoice_number": item.invoiceNoEncoded});
                  },
                ),
              );
            },
            newPageErrorIndicatorBuilder: (BuildContext context) {
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
                child: DataEmpty(),
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
    );
  }
}
