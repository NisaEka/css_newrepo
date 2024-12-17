import 'dart:io';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_screen.dart';
import 'package:css_mobile/screen/request_pickup/components/request_pickup_filter_button.dart';
import 'package:css_mobile/screen/request_pickup/components/request_pickup_status_button.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_screen.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_confirmation_dialog.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_select_address_content.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/input_formatter/custom_formatter.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_bottom_sheet_scaffold.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
// import 'package:css_mobile/screen/request_pickup/request_pickup_filter_item.dart';
// import 'package:css_mobile/widgets/forms/customtextformfield.dart';

class RequestPickupScreen extends StatelessWidget {
  const RequestPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
      init: RequestPickupController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: 'Minta Dijemput'.tr,
            leading: CustomBackButton(
              onPressed: () =>
                  Get.delete<DashboardController>().then((_) => Get.back()),
            ),
            action: const [
              RequstPickupFilterButton(),
            ],
          ),
          body: _requestPickupBody(context, controller),
          bottomNavigationBar: _requestPickupBottomBar(context, controller),
        );
      },
    );
  }

  Widget? _requestPickupBottomBar(
      BuildContext context, RequestPickupController controller) {
    if (controller.state.checkMode) {
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
                    controller.state.selectedAwbs.length.toString(),
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
              style: FilledButtonTheme.of(context).style,
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

  Widget _requestPickupBody(
      BuildContext context, RequestPickupController controller) {
    if (controller.state.showLoadingIndicator) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.state.showEmptyContent) {
      return const Center(child: DataEmpty());
    }

    if (controller.state.showErrorContent) {
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

    if (controller.state.showMainContent) {
      return _mainContentStack(context, controller);
    }

    return Text("No Content".tr);
  }

  Widget _mainContentStack(
      BuildContext context, RequestPickupController controller) {
    return Stack(
      children: [
        _mainContent(context, controller),
        if (controller.state.createDataLoading) const LoadingDialog(),
        if (controller.state.createDataFailed ||
            controller.state.createDataSuccess)
          MessageInfoDialog(
            message:
                'Success: ${controller.state.data?.successCount}. Error: ${controller.state.data?.errorCount}\n'
                'Error Details:\n'
                '${controller.state.data?.errorDetails.map((e) => '- ${e.awb} (${e.reason})').join('\n')}',
            onClickAction: () => controller.refreshState(),
          ),
        // if (controller.createDataSuccess)
        //   MessageInfoDialog(
        //     message: 'Pickup request created successfully!',
        //     onClickAction: () => controller.refreshState(),
        //   ),
      ],
    );
  }

  Widget _mainContent(
      BuildContext context, RequestPickupController controller) {
    return Column(
      children: [
        // _buttonFilters(context, controller),
        _checkAllItemBox(context, controller),
        CustomSearchField(
          controller: controller.state.searchField,
          hintText: 'Cari'.tr,
          inputFormatters: [
            UpperCaseTextFormatter(),
          ],
          prefixIcon: SvgPicture.asset(
            IconsConstant.search,
            color: Theme.of(context).brightness == Brightness.light
                ? whiteColor
                : blueJNE,
          ),
          onChanged: (value) {
            controller.onSearchChanged(value);
          },
          onClear: () {
            controller.state.searchField.clear();
            controller.state.pagingController.refresh();
          },
          margin: const EdgeInsets.only(left: 30, right: 30, top: 16),
        ),
        const RequestPickupStatusButton(),
        Expanded(
            child: RefreshIndicator(
          onRefresh: () =>
              Future.sync(() => controller.state.pagingController.refresh()),
          child: PagedListView<int, RequestPickupModel>(
            pagingController: controller.state.pagingController,
            builderDelegate: PagedChildBuilderDelegate<RequestPickupModel>(
              transitionDuration: const Duration(milliseconds: 500),
              itemBuilder: (context, item, index) {
                return RequestPickupItem(
                  data: item,
                  onTap: (String awb) {
                    if (controller.state.checkMode) {
                      if (item.status !=
                          Constant.statusAlreadyRequestPickedUp) {
                        controller.selectItem(awb);
                      }
                    } else {
                      Get.to(
                        const RequestPickupDetailScreen(),
                        arguments: {"awb": item.awb},
                      );
                    }
                  },
                  onLongTap: () {
                    controller.setCheckMode(true);
                  },
                  checkMode: controller.state.checkMode,
                  checked: controller.isItemChecked(item.awb),
                );
              },
              noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
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
              },
            ),
          ),
        ))
      ],
    );
  }

  Widget _checkAllItemBox(
      BuildContext context, RequestPickupController controller) {
    if (controller.state.checkMode) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  controller.setCheckMode(false);
                  controller.onCancel();
                },
                child: Text(
                  "Batal".tr,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              )
            ],
          ));
    } else {
      return Container();
    }
  }

  // Widget _buttonFilters(
  //     BuildContext context, RequestPickupController controller) {
  //   return SizedBox(
  //     height: 64,
  //     child: SingleChildScrollView(
  //       scrollDirection: Axis.horizontal,
  //       child: Row(
  //         children: [
  //           const SizedBox(width: 16),
  //           _buttonFilter(
  //               context, controller.state.filterDateText.tr, Constant.allDate,
  //               () {
  //             _filterDateBottomSheet(controller);
  //           }),
  //           const SizedBox(width: 16),
  //           _buttonFilter(context, controller.state.filterStatusText.tr,
  //               Constant.allStatus, () {
  //             _filterStatusBottomSheet(controller);
  //           }),
  //           const SizedBox(width: 16),
  //           _buttonFilter(context, controller.state.filterDeliveryTypeText.tr,
  //               Constant.allDeliveryType, () {
  //             _filterDeliveryTypeBottomSheet(controller);
  //           }),
  //           const SizedBox(width: 16),
  //           _buttonFilter(context, controller.state.filterDeliveryCityText.tr,
  //               Constant.allDeliveryCity, () {
  //             _filterDeliveryCityBottomSheet(controller);
  //           }),
  //           const SizedBox(width: 16),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buttonFilter(BuildContext context, String text, String defaultFilter,
  //     Function onPressed) {
  //   return OutlinedButton(
  //     onPressed: () {
  //       onPressed();
  //     },
  //     style: OutlinedButton.styleFrom(
  //       padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //       side: const BorderSide(width: 1, color: greyColor),
  //       backgroundColor: text == defaultFilter ? whiteColor : blueJNE,
  //     ),
  //     child: Row(
  //       children: [
  //         Text(text.tr,
  //             style: Theme.of(context)
  //                 .textTheme
  //                 .labelMedium
  //                 ?.copyWith(color: text == defaultFilter ? null : whiteColor)),
  //         const SizedBox(width: 8),
  //         Icon(
  //           Icons.keyboard_arrow_down,
  //           size: 24,
  //           color: Theme.of(context).colorScheme.outline,
  //         )
  //       ],
  //     ),
  //   );
  // }

  // _filterDateBottomSheet(RequestPickupController controller) {
  //   const items = RequestPickupDateEnum.values;

  //   Get.bottomSheet(
  //     enableDrag: true,
  //     isDismissible: true,
  //     StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
  //       return RequestPickupBottomSheetScaffold(
  //         title: "Pilih Tanggal".tr,
  //         content: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             SizedBox(
  //               height: (Get.height / 2) / 1.5,
  //               child: ListView.separated(
  //                 separatorBuilder: (BuildContext context, int index) {
  //                   if (index <= items.length) {
  //                     return const SizedBox(
  //                       height: 16,
  //                     );
  //                   } else {
  //                     return Container();
  //                   }
  //                 },
  //                 padding: const EdgeInsets.all(16),
  //                 itemCount: items.length,
  //                 itemBuilder: (context, index) {
  //                   bool isSelected =
  //                       controller.state.selectedFilterDate == items[index];
  //                   bool isCustom = controller.state.selectedFilterDate ==
  //                       RequestPickupDateEnum.custom;
  //                   bool showDatePickerContent = isCustom && isSelected;

  //                   return RequestPickupFilterItem(
  //                     onItemSelected: () {
  //                       setState(() =>
  //                           controller.setSelectedFilterDate(items[index]));
  //                     },
  //                     itemName: items[index].asName(),
  //                     isSelected: isSelected,
  //                     requireDatePicker: showDatePickerContent,
  //                     startDate: controller.state.selectedDateStartText,
  //                     endDate: controller.state.selectedDateEndText,
  //                     onStartDateChange: (newDateTime) {
  //                       setState(
  //                           () => controller.setSelectedDateStart(newDateTime));
  //                     },
  //                     onEndDateChange: (newDateTime) {
  //                       setState(
  //                           () => controller.setSelectedDateEnd(newDateTime));
  //                     },
  //                   );
  //                 },
  //               ),
  //             ),
  //             SizedBox(
  //                 width: Get.width,
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(
  //                     horizontal: 16,
  //                   ),
  //                   child: FilledButton(
  //                     onPressed: () {
  //                       controller.applyFilterDate();
  //                       Get.back();
  //                     },
  //                     child: Text(
  //                       "Terapkan".tr,
  //                       style: const TextStyle(color: whiteColor),
  //                     ),
  //                   ),
  //                 ))
  //           ],
  //         ),
  //       );
  //     }),
  //   );
  // }

  // _filterStatusBottomSheet(RequestPickupController controller) {
  //   List<String> items = controller.state.statuses;

  //   _requestPickupBottomSheetScaffold(
  //     "Pilih Status".tr,
  //     Expanded(
  //       child: ListView.separated(
  //         separatorBuilder: (BuildContext context, int index) {
  //           if (index <= items.length) {
  //             return const SizedBox(
  //               height: 16,
  //             );
  //           } else {
  //             return Container();
  //           }
  //         },
  //         padding: const EdgeInsets.all(16),
  //         itemCount: items.length,
  //         itemBuilder: (context, index) {
  //           bool isSelected = controller.state.filterStatusText == items[index];
  //           return GestureDetector(
  //             onTap: () {
  //               controller.setSelectedFilterStatus(items[index]);
  //               Get.back();
  //             },
  //             child: Expanded(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(items[index].tr),
  //                   Icon(isSelected ? Icons.circle : Icons.circle_outlined)
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // _filterDeliveryTypeBottomSheet(RequestPickupController controller) {
  //   List<String> items = controller.state.types;

  //   _requestPickupBottomSheetScaffold(
  //     "Pilih Tipe Kiriman".tr,
  //     Expanded(
  //       child: ListView.separated(
  //         separatorBuilder: (BuildContext context, int index) {
  //           if (index <= items.length) {
  //             return const SizedBox(
  //               height: 16,
  //             );
  //           } else {
  //             return Container();
  //           }
  //         },
  //         padding: const EdgeInsets.all(16),
  //         itemCount: items.length,
  //         itemBuilder: (context, index) {
  //           bool isSelected =
  //               controller.state.filterDeliveryTypeText == items[index];
  //           return GestureDetector(
  //             onTap: () {
  //               controller.setSelectedDeliveryType(items[index]);
  //               Get.back();
  //             },
  //             child: Expanded(
  //               child: Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Text(items[index].tr),
  //                   Icon(isSelected ? Icons.circle : Icons.circle_outlined)
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       ),
  //     ),
  //   );
  // }

  // _filterDeliveryCityBottomSheet(RequestPickupController controller) {
  //   List<Map<String, dynamic>> items = controller.state.cities;

  //   Get.bottomSheet(
  //     enableDrag: true,
  //     isDismissible: true,
  //     StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
  //       return RequestPickupBottomSheetScaffold(
  //         title: "Pilih Kota Pengiriman",
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
  //               child: CustomTextFormField(
  //                 controller: controller.state.cityKeyword,
  //                 label: 'Nama Kota'.tr,
  //                 hintText: 'Masukkan nama kota',
  //                 inputType: TextInputType.streetAddress,
  //                 onChanged: (newText) =>
  //                     setState(() => controller.onCityKeywordChange(newText)),
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 16,
  //             ),
  //             Expanded(
  //               child: ListView.separated(
  //                 shrinkWrap: true,
  //                 separatorBuilder: (BuildContext context, int index) {
  //                   if (index <= items.length) {
  //                     return const SizedBox(
  //                       height: 16,
  //                     );
  //                   } else {
  //                     return Container();
  //                   }
  //                 },
  //                 padding: const EdgeInsets.all(16),
  //                 itemCount: items.length,
  //                 itemBuilder: (context, index) {
  //                   bool isSelected = controller.state.filterDeliveryCityText ==
  //                       items[index]['label'];
  //                   return GestureDetector(
  //                     onTap: () {
  //                       controller.setSelectedFilterCity(items[index]);
  //                       Get.back();
  //                     },
  //                     child: Expanded(
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           Text(items[index]['label']),
  //                           Icon(isSelected
  //                               ? Icons.circle
  //                               : Icons.circle_outlined)
  //                         ],
  //                       ),
  //                     ),
  //                   );
  //                 },
  //               ),
  //             )
  //           ],
  //         ),
  //       );
  //     }),
  //   );
  // }

  _pickupAddressBottomSheet(RequestPickupController controller) {
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return RequestPickupBottomSheetScaffold(
          title: 'Pilih Alamat Penjemputan'.tr,
          content: RequestPickupSelectAddressContent(
            addresses: controller.state.addresses,
            pagingController:
                controller.state.pagingControllerPickupDataAddress,
            onAddNewAddressClick: () {
              Get.to(() => const RequestPickupAddressUpsertScreen())
                  ?.then((result) {
                if (result == HttpStatus.created) {
                  controller.state.pagingControllerPickupDataAddress.refresh();
                  setState(() => controller.update());
                }
              });
            },
            onPickupClick: () {
              Get.dialog(RequestPickupConfirmationDialog(
                pickupTime: controller.getSelectedPickupTime(),
                onConfirmAction: () {
                  controller.onPickupAction();
                  Get.back();
                  Get.back();
                },
                onCancelAction: () {
                  Get.back();
                },
              ));
            },
            onTimeSet: (String newTime) {
              setState(() => controller.onSetPickupTime(newTime));
            },
            selectedTime: controller.state.selectedPickupTime,
            onSelectAddress: (String addressId) {
              setState(() => controller.onSelectAddress(addressId));
            },
            selectedAddressId: controller.state.selectedAddressId,
          ),
        );
      }),
    );
  }

  // _requestPickupBottomSheetScaffold(String title, Widget content) {
  //   Get.bottomSheet(
  //     enableDrag: true,
  //     isDismissible: true,
  //     StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
  //       return RequestPickupBottomSheetScaffold(content: content, title: title);
  //     }),
  //   );
  // }
}
