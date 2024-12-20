import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_controller.dart';
import 'package:css_mobile/screen/cek_ongkir/components/cek_ongkir_data.dart';
import 'package:css_mobile/screen/cek_ongkir/components/cek_ongkir_form.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirScreen extends StatelessWidget {
  const CekOngkirScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CekOngkirController>(
        init: CekOngkirController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(title: 'Cek Ongkos Kirim'.tr),
            body: _bodyContent(controller, context),
            bottomNavigationBar: CustomFilledButton(
              color: primaryColor(context),
              title: 'Cek Ongkos Kirim'.tr,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              onPressed: () => controller.loadOngkir(),
            ),
          );
        });
  }

  Widget _bodyContent(CekOngkirController c, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            const CekOngkirForm(),
            c.state.isLoading
                ? LoadingDialog(
                    height: Get.width / 2,
                    background: Colors.transparent,
                  )
                : const CekOngkirData(),
          ],
        ),
      ),
    );
  }
}
