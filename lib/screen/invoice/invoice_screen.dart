import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/screen/invoice/detail/invoice_detail_screen.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_filter_item.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/invoice/invoice_item.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_bottom_sheet_scaffold.dart';
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
          appBar: CustomTopBar(title: "Tagihan Kamu".tr),
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
      margin: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget _invoiceCountCard(BuildContext context, InvoiceController controller) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _invoiceTitle(BuildContext context, InvoiceController controller,) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Daftar Invoice".tr,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          _buttonFilter(context, controller.filterDateText.tr, () {
            _filterDateBottomSheet(controller);
          }),
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
              double paddingTop = index == 0 ? 16 : 0;
              return Padding(
                padding: EdgeInsets.only(top: paddingTop),
                child: InvoiceItem(
                  invoice: item,
                  onTap: (String invoiceNumber) {
                    Get.to(const InvoiceDetailScreen(),
                        arguments: {"invoice_number": item.invoiceNoEncoded});
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
    );
  }

  Widget _buttonFilter(BuildContext context, String text, Function onPressed) {
    return OutlinedButton(
      onPressed: () {
        onPressed();
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        side: const BorderSide(width: 1, color: greyColor),
      ),
      child: Row(
        children: [
          Text(
            text.tr,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            Icons.keyboard_arrow_down,
            size: 24,
            color: Theme.of(context).colorScheme.outline,
          )
        ],
      ),
    );
  }

  _filterDateBottomSheet(InvoiceController controller) {
    const items = RequestPickupDateEnum.values;

    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return RequestPickupBottomSheetScaffold(
          title: "Pilih Tanggal".tr,
          content: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: (Get.height / 2) / 1.5,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    if (index <= items.length) {
                      return const SizedBox(
                        height: 16,
                      );
                    } else {
                      return Container();
                    }
                  },
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    bool isSelected =
                        controller.selectedFilterDate == items[index];
                    bool isCustom = controller.selectedFilterDate ==
                        RequestPickupDateEnum.custom;
                    bool showDatePickerContent = isCustom && isSelected;

                    return RequestPickupFilterItem(
                      onItemSelected: () {
                        setState(() =>
                            controller.setSelectedFilterDate(items[index]));
                      },
                      itemName: items[index].asName(),
                      isSelected: isSelected,
                      requireDatePicker: showDatePickerContent,
                      startDate: controller.selectedDateStartText,
                      endDate: controller.selectedDateEndText,
                      onStartDateChange: (newDateTime) {
                        setState(
                                () => controller.setSelectedDateStart(newDateTime));
                      },
                      onEndDateChange: (newDateTime) {
                        setState(
                                () => controller.setSelectedDateEnd(newDateTime));
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: FilledButton(
                      onPressed: () {
                        controller.applyFilterDate();
                        Get.back();
                      },
                      child: Text(
                        "Terapkan".tr,
                        style: const TextStyle(color: whiteColor),
                      ),
                    ),
                  ))
            ],
          ),
        );
      }),
    );
  }
}
