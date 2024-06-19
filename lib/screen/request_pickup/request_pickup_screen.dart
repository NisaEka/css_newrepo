import 'dart:ui';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_delivery_type_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_status_enum.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_bottom_sheet_scaffold.dart';
import 'package:css_mobile/widgets/request_pickup/request_pickup_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class RequestPickupScreen extends StatefulWidget {
  const RequestPickupScreen({ super.key });

  @override
  State<StatefulWidget> createState() => _RequestPickupScreenState();
}

class _RequestPickupScreenState extends State<RequestPickupScreen> {

  bool _checkMode = false;
  bool _checkAll = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestPickupController>(
      init: RequestPickupController(),
      builder: (controller) {
        return Scaffold(
          appBar: _requestPickupAppBar(),
          body: _requestPickupBody(controller),
        );
      },
    );
  }

  PreferredSizeWidget _requestPickupAppBar() {
    return CustomTopBar(
      title: "Minta Dijemput".tr
    );
  }

  Widget _requestPickupBody(RequestPickupController controller) {
    if (controller.showLoadingIndicator) {
      return const Center(
        child: CircularProgressIndicator()
      );
    }

    if (controller.showEmptyContent) {
      return const Center(
        child: Text("Tidak ada data tersedia")
      );
    }

    if (controller.showErrorContent) {
      return Center(
        child: Column(
          children: [
            Text("Terjadi kesalahan ketika mengambil data".tr),
            const Padding(padding: EdgeInsets.only(top: 16)),
            FilledButton(onPressed: () => controller.requireRetry(), child: Text("Muat ulang"))
          ],
        )
      );
    }

    if (controller.showMainContent) {
      return _mainContent(controller);
    }

    return Text("No Content".tr);
  }

  Widget _mainContent(RequestPickupController controller) {
    return Column(
      children: [
        _buttonFilters(controller),
        _checkAllItemBox(),
        Expanded(child: ListView(
          children: controller.requestPickups.map((requestPickup) {
            return RequestPickupItem(
              data: requestPickup,
              onTap: () {
                if (_checkMode) {
                  setState(() {
                    _checkMode = false;
                    _checkAll = false;
                  });
                }
              },
              onLongTap: () {
                setState(() {
                  _checkMode = true;
                });
              },
              checkMode: _checkMode,
            );
          }).toList(),
        ))
      ],
    );
  }

  Widget _checkAllItemBox() {
    if (_checkMode) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Checkbox(
              value: _checkAll,
              onChanged: (newValue) {
                setState(() {
                  _checkAll = newValue ?? _checkAll;
                });
              },
            ),
            Text(
              "Pilih Semua".tr,
              style: inputTextStyle,
            )
          ],
        ),
      );
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
            _buttonFilter(
              controller.filterDateText.tr, () { _filterDateBottomSheet(); }
            ),
            const SizedBox(width: 16),
            _buttonFilter(
              controller.filterStatusText.tr, () { _filterStatusBottomSheet(controller); }
            ),
            const SizedBox(width: 16),
            _buttonFilter(
              controller.filterDeliveryTypeText.tr, () { _filterDeliveryTypeBottomSheet(controller); }
            ),
            const SizedBox(width: 16),
            _buttonFilter(
              controller.filterDeliveryCityText.tr, () { _filterDeliveryCityBottomSheet(); }
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }

  Widget _buttonFilter(String text , Function onPressed) {
    return OutlinedButton(
      onPressed: () { onPressed(); },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        side: const BorderSide(width: 1, color: greyColor),
      ),
      child: Row(
        children: [
          Text(
            text.tr,
            style: sublistTitleTextStyle.copyWith(
                fontWeight: semiBold
            ),
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

  _filterDateBottomSheet() {
    _requestPickupBottomSheetScaffold("Pilih Tanggal", Container(
        child: Expanded(
          child: Row(
            children: [
              Text("hello")
            ],
          )
        )),);
  }

  _filterStatusBottomSheet(RequestPickupController controller) {
    const items = RequestPickupStatus.values;

    _requestPickupBottomSheetScaffold("Pilih Status".tr, Expanded(
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
          bool isSelected = controller.selectedFilterStatus == items[index];
          return GestureDetector(
            onTap: () {
              controller.setSelectedFilterStatus(items[index]);
              Get.back();
            },
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index].asName().tr),
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
    const items = RequestPickupDeliveryType.values;

    _requestPickupBottomSheetScaffold("Pilih Tipe Kiriman".tr, Expanded(
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
          bool isSelected = controller.selectedDeliveryType == items[index];
          return GestureDetector(
            onTap: () {
              controller.setSelectedDeliveryType(items[index]);
              Get.back();
            },
            child: Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(items[index].asName().tr),
                  Icon(isSelected ? Icons.circle : Icons.circle_outlined)
                ],
              ),
            ),
          );
        },
      ),
    ));
  }

  _filterDeliveryCityBottomSheet() {
    _requestPickupBottomSheetScaffold("Pilih Kota Pengiriman", Container(
        child: Expanded(
          child: Text("hello")
        )),);
  }

  _requestPickupBottomSheetScaffold(String title, Widget content) {
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true ,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return RequestPickupBottomSheetScaffold(content: content, title: title);
      }),
    );
  }

}