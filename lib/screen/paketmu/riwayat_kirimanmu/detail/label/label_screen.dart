import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/label/label_controller.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DataTransactionModel data = Get.arguments['data'];

    return GetBuilder<LabelController>(
        init: LabelController(),
        builder: (controller) {
          return Scaffold(
              appBar: AppBar(
                title: Text("Lihat Resi".tr),
                leading: const CustomBackButton(),
              ),
              body: Screenshot(
                controller: controller.screenshotController,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(25),
                    padding: const EdgeInsets.only(top: 50),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: controller.myLongWidget(data),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                // shape: const CircleBorder(),
                backgroundColor: primaryColor(context),
                onPressed: () => controller.capture(context),
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: whiteColor,
                ),
                // ),
              ));
        });
  }
}
