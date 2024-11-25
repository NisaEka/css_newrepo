import 'package:barcode_widget/barcode_widget.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
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
    if (controller.showLoadingIndicator) {
      return Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      );
    }

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
            _contentSection(context, controller.requestPickup),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _contentSection(
      BuildContext context, RequestPickupDetailModel requestPickup) {
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
                // escapes: true,
              ),
              data: requestPickup.awb,
              drawText: false,
              style: const TextStyle(fontSize: 20),
              height: 100,
              // width: Get.width ,
            ),
            CustomCodeLabel(
              label: requestPickup.awb,
              isLoading: false,
              alignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                  right: 20), // Margin between the two text widgets
              child: Text(
                'Detail Permintaan Pickup'.tr,
                style: listTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow("ID", requestPickup.awb),
            const SizedBox(height: 10),
            _textRow("Tanggal dan Jam",
                requestPickup.createdDateSearch.toDateTimeFormat(),
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Nama PIC", requestPickup.pickupName,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Telepon", requestPickup.pickupPicPhone,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Kota Penjemputan", requestPickup.pickupCity,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Kecamatan Penjemputan", requestPickup.pickupDistrict,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Alamat Penjemputan", requestPickup.pickupAddress,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Layanan Pickup", requestPickup.pickupService,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Kendaraan Pickup", requestPickup.pickupVehicle,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 16),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                  right: 20), // Margin between the two text widgets
              child: Text(
                'Status Permintaan Pickup'.tr,
                style: listTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow("Tanggal Pickup",
                '${requestPickup.pickupDate} ${requestPickup.pickupTime}'),
            const SizedBox(height: 6),
            _textRow("Status Pickup", requestPickup.pickupStatus),
            const SizedBox(height: 6),
            _textRow("Kendaraan Pickup", requestPickup.statusDesc ?? "-",
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 16),
            const Divider(
              color: greyLightColor3,
            ),
            const SizedBox(height: 16),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(
                  right: 20), // Margin between the two text widgets
              child: Text(
                'Detail kiriman'.tr,
                style: listTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _textRow("Account", requestPickup.custId,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Pengirim", requestPickup.shipperName,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Petugas Entry", requestPickup.petugasEntry,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Kota Pengiriman", requestPickup.shipperCity,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Penerima", requestPickup.receiverName,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Kota Penerima", requestPickup.receiverCity,
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow("Deskripsi Kiriman", requestPickup.goodDesc ?? "-",
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
            _textRow(
                "Berat Kiriman",
                requestPickup.weight != null
                    ? '${requestPickup.weight?.toDouble().toString()} KG'
                    : "- KG",
                style: listTitleTextStyle.copyWith(fontWeight: regular)),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String title, String? value, {TextStyle? style}) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.start, // Spread the columns
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          // Ensures that the title takes up only as much space as it needs
          child: Text(
            title.tr,
            style: sublistTitleTextStyle,
          ),
        ),
        Expanded(
          // Makes the value take the rest of the space in the row
          child: Text(
            value,
            style: style ?? listTitleTextStyle,
            textAlign: TextAlign.start, // Align the value to the right
          ),
        ),
      ],
    );
  }
}
