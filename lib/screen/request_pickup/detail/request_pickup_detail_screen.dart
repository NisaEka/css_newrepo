import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcodelabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupDetailScreen extends StatelessWidget {
  const RequestPickupDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RequestPickupDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Detail Kiriman".tr),
          body: _detailBody(context, controller),
        );
      },
    );
  }

  Widget _detailBody(
      BuildContext context, RequestPickupDetailController controller) {
    if (controller.showEmptyContainer) {
      return const Center(child: Text("Not Found"));
    }

    if (controller.showErrorContainer) {
      return const Center(child: Text("Error"));
    }

    if (controller.showContent) {
      return _mainContent(context, controller);
    }

    return Container();
  }

  Widget _mainContent(
      BuildContext context, RequestPickupDetailController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _contentSection(context, controller.requestPickup, controller),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _contentSection(BuildContext context,
      RequestPickupDetailModel requestPickup, RequestPickupDetailController c) {
    return Card.filled(
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BarcodeWidget(
              barcode: Barcode.code128(
                useCode128A: true,
              ),
              color: CustomTheme().textColor(context) ?? greyColor,
              data: requestPickup.awb,
              drawText: false,
              style: const TextStyle(fontSize: 20),
              height: 100,
            ),
            CustomCodeLabel(
              label: requestPickup.awb,
              isLoading: false,
              alignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 16),
            Shimmer(
              isLoading: c.isLoading,
              child: Container(
                decoration: BoxDecoration(
                    color: c.isLoading ? greyColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Detail Permintaan Pickup'.tr,
                  style: listTitleTextStyle.copyWith(
                    color:
                        AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow(context, "ID", requestPickup.awb, c.isLoading),
            const SizedBox(height: 10),
            _textRow(
                context,
                "Tanggal dan Jam".tr,
                requestPickup.createdDateSearch.toLongDateTimeFormat(),
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(
                context, "Nama PIC".tr, requestPickup.pickupName, c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Telepon".tr, requestPickup.pickupPicPhone,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kota Penjemputan".tr, requestPickup.pickupCity,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kecamatan Penjemputan".tr,
                requestPickup.pickupDistrict, c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Alamat Penjemputan".tr,
                requestPickup.pickupAddress, c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Layanan Pickup".tr, requestPickup.pickupService,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kendaraan Pickup".tr,
                requestPickup.pickupVehicle, c.isLoading),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(height: 16),
            Shimmer(
              isLoading: c.isLoading,
              child: Container(
                decoration: BoxDecoration(
                    color: c.isLoading ? greyColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Status Permintaan Pickup'.tr,
                  style: listTitleTextStyle.copyWith(
                    color:
                        AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow(
                context,
                "Tanggal Pickup",
                '${requestPickup.pickupDate?.toDate(originFormat: 'dd-MM-yyyy').toString().toLongDateFormat()} ${requestPickup.pickupTime ?? ''}',
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Status Pickup".tr,
                requestPickup.pickupStatus ?? '-', c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kendaraan Pickup".tr,
                requestPickup.statusDesc ?? "-", c.isLoading),
            const SizedBox(height: 16),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(height: 16),
            Shimmer(
              isLoading: c.isLoading,
              child: Container(
                decoration: BoxDecoration(
                    color: c.isLoading ? greyColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(5)),
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(right: 20),
                child: Text(
                  'Detail Kiriman'.tr,
                  style: listTitleTextStyle.copyWith(
                    color:
                        AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow(context, "Account".tr, requestPickup.custId, c.isLoading),
            const SizedBox(height: 6),
            _textRow(
                context, "Pengirim".tr, requestPickup.shipperName, c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Petugas Entry".tr, requestPickup.petugasEntry,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kota Pengiriman".tr, requestPickup.shipperCity,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Penerima".tr, requestPickup.receiverName,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Kota Penerima".tr, requestPickup.receiverCity,
                c.isLoading),
            const SizedBox(height: 6),
            _textRow(context, "Deskripsi Kiriman".tr,
                requestPickup.goodDesc ?? "-", c.isLoading),
            const SizedBox(height: 6),
            _textRow(
                context,
                "Berat Kiriman".tr,
                requestPickup.weight != null
                    ? '${requestPickup.weight?.toDouble().toString()} KG'
                    : "- KG",
                c.isLoading),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _textRow(
      BuildContext context, String title, String? value, bool isLoading,
      {TextStyle? style}) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                title.tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: regular),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Shimmer(
            isLoading: isLoading,
            child: Container(
              decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                value,
                style: style ??
                    Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: regular),
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
