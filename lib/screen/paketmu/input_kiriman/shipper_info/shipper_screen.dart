import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/shipper_form.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_appbar.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_controller.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InformasiPengirimScreen extends StatelessWidget {
  const InformasiPengirimScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipperController>(
        init: ShipperController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: TransactionAppbar(
                  data: controller.state.data,
                  isOnline: controller.state.isOnline,
                ),
                body: RefreshIndicator(
                  color: greyColor,
                  onRefresh: () => controller.initData(),
                  child: const ShipperForm(),
                ),
              ),
              controller.state.isLoadSave
                  ? const LoadingDialog()
                  : const SizedBox()
            ],
          );
        });
  }
}
