import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RequestPickupDetailScreen extends StatelessWidget {
  const RequestPickupDetailScreen({ super.key });

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RequestPickupDetailController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Detail Kiriman".tr),
          body: _detailBody(controller)
        );
      });
  }

  Widget _detailBody(RequestPickupDetailController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _basicSection(controller.requestPickupArgs),
          const SizedBox(height: 32),
          _detailedSectionTitle(),
          const SizedBox(height: 16),
          _detailedSection(controller.requestPickupArgs)
        ],
      ),
    );
  }

  Widget _basicSection(RequestPickupModel requestPickup) {
    return Card.filled(
      color: infoLightColor1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textRow("No Resi", requestPickup.awb),
            const SizedBox(height: 16),
            _textRow("Status Upload", "Berhasil Dijemput"),
            const SizedBox(height: 16),
            _textRow("Status Pickup", requestPickup.status)
          ],
        ),
      ),
    );
  }

  Widget _detailedSectionTitle() {
    return Text(
      "Detail Pesanan".tr,
      style: sublistTitleTextStyle.copyWith(
          fontWeight: semiBold
      ),
      textAlign: TextAlign.start,
    );
  }

  Widget _detailedSection(RequestPickupModel requestPickup) {
    return Card.filled(
      color: infoLightColor1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textRow("Tanggal Pesanan", requestPickup.transactionDate),
            const SizedBox(height: 16),
            _textRow("Tipe", requestPickup.transactionType),
            const SizedBox(height: 16),
            _textRow("Service", requestPickup.transactionService),
            const SizedBox(height: 16),
            _textRow("Dana COD", "Rp12.000"),
            const SizedBox(height: 16),
            _textRow("Pengirim", requestPickup.name),
            const SizedBox(height: 16),
            _textRow("Kota Pengiriman", "Bandung"),
            const SizedBox(height: 16),
            _textRow("Penerima", "Andi"),
            const SizedBox(height: 16),
            _textRow("Kontak Penerima", "085315903382"),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: sublistTitleTextStyle,
        ),
        Text(
          value,
          style: listTitleTextStyle
        )
      ],
    );
  }

}