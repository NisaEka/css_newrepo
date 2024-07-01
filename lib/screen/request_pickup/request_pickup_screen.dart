import 'dart:io';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_screen.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_screen.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_filter_item.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_confirmation_dialog.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_select_address_content.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_bottom_sheet_scaffold.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupScreen extends StatelessWidget {
  const RequestPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
      init: RequestPickupController(),
      builder: (controller) {
        return Scaffold(
          appBar: _requestPickupAppBar(),
          body: _requestPickupBody(controller),
          bottomNavigationBar: _requestPickupBottomBar(controller),
        );
      },
    );
  }

  PreferredSizeWidget _requestPickupAppBar() {
    return CustomTopBar(title: "Minta Dijemput".tr);
  }

  Widget? _requestPickupBottomBar(RequestPickupController controller) {
    if (controller.checkMode) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total kiriman dipilih",
                    style: sublistTitleTextStyle.copyWith(
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.selectedAwbs.length.toString(),
                    style: sublistTitleTextStyle.copyWith(
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                _pickupAddressBottomSheet(controller);
              },
              child: Text(
                "Minta Dijemput".tr,
                style: const TextStyle(color: whiteColor),
              ),
            )
          ],
        ),
      );
    }

    return null;
  }

  Widget _requestPickupBody(RequestPickupController controller) {
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
              child: const Text("Muat ulang"))
        ],
      ));
    }

    if (controller.showMainContent) {
      return _mainContentStack(controller);
    }

    return Text("No Content".tr);
  }

  Widget _mainContentStack(RequestPickupController controller) {
    return Stack(
      children: [
        _mainContent(controller),
        controller.createDataLoading ? const LoadingDialog() : Container(),
        controller.createDataFailed ? const MessageInfoDialog(message: 'Gagal membuat permintaan pickup') : Container(),
        controller.createDataSuccess ? const MessageInfoDialog(message: 'Berhasil membuat permintaan pickup') : Container()
      ],
    );
  }

  Widget _mainContent(RequestPickupController controller) {
    return Column(
      children: [
        _buttonFilters(controller),
        _checkAllItemBox(controller),
        Expanded(
            child: RefreshIndicator(
          onRefresh: () =>
              Future.sync(() => controller.pagingController.refresh()),
          child: PagedListView<int, RequestPickupModel>(
            pagingController: controller.pagingController,
            builderDelegate: PagedChildBuilderDelegate<RequestPickupModel>(
                transitionDuration: const Duration(milliseconds: 500),
                itemBuilder: (context, item, index) {
                  return RequestPickupItem(
                    data: item,
                    onTap: (String awb) {
                      if (controller.checkMode) {
                        controller.selectItem(awb);
                      } else {
                        Get.to(const RequestPickupDetailScreen(),
                            arguments: {"data": item});
                      }
                    },
                    onLongTap: () {
                      controller.setCheckMode(true);
                    },
                    checkMode: controller.checkMode,
                    checked: controller.isItemChecked(item.awb),
                  );
                },
                firstPageErrorIndicatorBuilder: (context) {
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
                  ));
                }),
          ),
        ))
      ],
    );
  }

  Widget _checkAllItemBox(RequestPickupController controller) {
    if (controller.checkMode) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Checkbox(
                    value: false,
                    onChanged: (newValue) {},
                  ),
                  Text(
                    "Pilih Semua".tr,
                    style: inputTextStyle,
                  )
                ],
              ),
              TextButton(
                onPressed: () {
                  controller.setCheckMode(false);
                  controller.onCancel();
                },
                child: Text("Batal".tr),
              )
            ],
          ));
    } else {
      return Container();
    }
  }

  Widget _buttonFilters(RequestPickupController controller) {
    return SizedBox(
      height: 64,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            const SizedBox(width: 16),
            _buttonFilter(controller.filterDateText.tr, () {
              _filterDateBottomSheet(controller);
            }),
            const SizedBox(width: 16),
            _buttonFilter(controller.filterStatusText.tr, () {
              _filterStatusBottomSheet(controller);
            }),
            const SizedBox(width: 16),
            _buttonFilter(controller.filterDeliveryTypeText.tr, () {
              _filterDeliveryTypeBottomSheet(controller);
            }),
            const SizedBox(width: 16),
            _buttonFilter(controller.filterDeliveryCityText.tr, () {
              _filterDeliveryCityBottomSheet(controller);
            }),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buttonFilter(String text, Function onPressed) {
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
            style: sublistTitleTextStyle.copyWith(fontWeight: semiBold),
          ),
          const SizedBox(width: 8),
          const Icon(
            Icons.keyboard_arrow_down,
            size: 24,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  _filterDateBottomSheet(RequestPickupController controller) {
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

  _filterStatusBottomSheet(RequestPickupController controller) {
    List<String> items = controller.statuses;

    _requestPickupBottomSheetScaffold(
        "Pilih Status".tr,
        Expanded(
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
              bool isSelected = controller.filterStatusText == items[index];
              return GestureDetector(
                onTap: () {
                  controller.setSelectedFilterStatus(items[index]);
                  Get.back();
                },
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index].tr),
                      Icon(isSelected ? Icons.circle : Icons.circle_outlined)
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  _filterDeliveryTypeBottomSheet(RequestPickupController controller) {
    List<String> items = controller.types;

    _requestPickupBottomSheetScaffold(
        "Pilih Tipe Kiriman".tr,
        Expanded(
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
              bool isSelected = controller.filterStatusText == items[index];
              return GestureDetector(
                onTap: () {
                  controller.setSelectedDeliveryType(items[index]);
                  Get.back();
                },
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index].tr),
                      Icon(isSelected ? Icons.circle : Icons.circle_outlined)
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  _filterDeliveryCityBottomSheet(RequestPickupController controller) {
    List<String> items = controller.cities;

    _requestPickupBottomSheetScaffold(
        "Pilih Kota Pengiriman",
        Expanded(
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
                  controller.filterDeliveryCityText == items[index];
              return GestureDetector(
                onTap: () {
                  controller.setSelectedFilterCity(items[index]);
                  Get.back();
                },
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(items[index]),
                      Icon(isSelected ? Icons.circle : Icons.circle_outlined)
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }

  _pickupAddressBottomSheet(RequestPickupController controller) {
    _requestPickupBottomSheetScaffold(
        "Pilih Alamat Penjemputan".tr,
        RequestPickupSelectAddressContent(
          addresses: controller.addresses,
          onAddNewAddressClick: () async {
            var upsertResult =
                await Get.to(() => const RequestPickupAddressUpsertScreen());
            if (upsertResult == HttpStatus.created) {
              controller.onUpdateAddresses();
            }
          },
          onPickupClick: () {
            Get.dialog(RequestPickupConfirmationDialog(
              pickupTime: controller.selectedPickupTime,
              onConfirmAction: () {
                controller.onPickupAction();
                Get.back();
              },
              onCancelAction: () {
                Get.back();
              },
            ));
          },
          onTimeSet: (String newTime) {
            controller.onSetPickupTime(newTime);
          },
          selectedTime: controller.selectedPickupTime,
        ));
  }

  _requestPickupBottomSheetScaffold(String title, Widget content) {
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return RequestPickupBottomSheetScaffold(content: content, title: title);
      }),
    );
  }
}
