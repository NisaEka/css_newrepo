import 'dart:io';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
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
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_bottom_sheet_scaffold.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total kiriman dipilih",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.state.selectedAwbs.length.toString(),
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ),
            FilledButton(
              onPressed: () {
                controller.state.selectedAwbs.isEmpty
                    ? Get.showSnackbar(
                        GetSnackBar(
                          icon: const Icon(
                            Icons.warning,
                            color: whiteColor,
                          ),
                          message: 'Pilih kiriman terlebih dahulu'.tr,
                          isDismissible: true,
                          duration: const Duration(seconds: 3),
                          backgroundColor: errorColor,
                        ),
                      )
                    : _pickupAddressBottomSheet(controller);
              },
              style: FilledButtonTheme.of(context).style?.copyWith(
                  backgroundColor:
                      WidgetStateProperty.all(primaryColor(context))),
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
          DefaultAlertDialog(
            title:
                "Success: ${controller.state.data?.successCount}. Error: ${controller.state.data?.errorCount}\n"
                    .tr,
            subtitle: 'Error Details:\n'
                '${controller.state.data?.errorDetails.map((e) => '- ${e.awb} (${e.reason})').join('\n')}',
            backButtonTitle: "Kembali",
            confirmButtonTitle: "Ok",
            onBack: Get.back,
            onConfirm: () => controller.refreshState(),
          ),
      ],
    );
  }

  Widget _mainContent(
      BuildContext context, RequestPickupController controller) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
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
                controller.getRequestPickupCount();
              },
              margin: const EdgeInsets.only(top: 30, bottom: 0),
            ),
            const RequestPickupStatusButton(),
            _checkAllItemBox(context, controller),
            if (!controller.state.checkMode)
              const SizedBox(
                height: 20,
              ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.sync(
                  () => controller.state.pagingController.refresh(),
                ),
                child: PagedListView.separated(
                  pagingController: controller.state.pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<RequestPickupModel>(
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
                              () => const RequestPickupDetailScreen(),
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
                    firstPageProgressIndicatorBuilder: (context) => Column(
                      children: List.generate(
                        10,
                        (index) => RequestPickupItem(
                          isLoading: true,
                          checked: false,
                          data: null,
                          onLongTap: () {},
                          checkMode: false,
                          onTap: (awb) => {},
                        ),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const DataEmpty(),
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
                    noMoreItemsIndicatorBuilder: (context) => Center(
                      child: Divider(
                        indent: 100,
                        endIndent: 100,
                        thickness: 2,
                        color: primaryColor(context),
                      ),
                    ),
                    newPageProgressIndicatorBuilder: (context) =>
                        const LoadingDialog(
                      background: Colors.transparent,
                      height: 50,
                      size: 30,
                    ),
                  ),
                  separatorBuilder: (context, index) {
                    return const Divider(color: greyLightColor3);
                  },
                ),
              ),
            )
          ],
        ));
  }

  Widget _checkAllItemBox(
      BuildContext context, RequestPickupController controller) {
    if (controller.state.checkMode) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              controller.setCheckMode(false);
              controller.onCancel();
            },
            child: Text(
              "Batal".tr,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      );
    } else {
      return Container();
    }
  }

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
}
