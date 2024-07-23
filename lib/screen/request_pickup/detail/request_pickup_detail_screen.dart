import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:css_mobile/screen/request_pickup/detail/request_pickup_detail_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _basicSection(context, controller.requestPickup),
          const SizedBox(height: 32),
          _detailedSectionTitle(context),
          const SizedBox(height: 16),
          _detailedSection(context, controller.requestPickup)
        ],
      ),
    );
  }

  Widget _basicSection(
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
            _textRow("No Resi", requestPickup.awb),
            const SizedBox(height: 16),
            _textRow("Status Upload", requestPickup.status),
            const SizedBox(height: 16),
            _textRow("Status Pickup", requestPickup.statusPickup)
          ],
        ),
      ),
    );
  }

  Widget _detailedSectionTitle(BuildContext context) {
    return Text(
      "Detail Pesanan".tr,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: semiBold),
      textAlign: TextAlign.start,
    );
  }

  Widget _detailedSection(
      BuildContext context, RequestPickupDetailModel requestPickup) {
    return Card.filled(
      color: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _textRow("Tanggal Pesanan", requestPickup.date),
            const SizedBox(height: 16),
            _textRow("Tipe", requestPickup.type),
            const SizedBox(height: 16),
            _textRow("Service", requestPickup.service),
            const SizedBox(height: 16),
            _textRow("Dana COD", (requestPickup.codFee ?? 0).toInt().toCurrency()),
            const SizedBox(height: 16),
            _textRow("Pengirim", requestPickup.receiverName),
            const SizedBox(height: 16),
            _textRow("Kota Pengiriman", requestPickup.receiverCity),
            const SizedBox(height: 16),
            _textRow("Penerima", requestPickup.receiverName),
            const SizedBox(height: 16),
            _textRow("Kontak Penerima", requestPickup.receiverPhone),
          ],
        ),
      ),
    );
  }

  Widget _textRow(String title, String? value) {
    if (value == null) {
      return Container();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title.tr,
          style: sublistTitleTextStyle,
        ),
        Text(value, style: listTitleTextStyle)
      ],
    );
  }
}
