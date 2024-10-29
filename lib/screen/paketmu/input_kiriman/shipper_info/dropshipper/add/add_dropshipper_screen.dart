import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/contact_appbar.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/dropshipper_form.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/dropshipper/add/add_dropshipper_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class AddDropshipperScreen extends StatelessWidget {
  const AddDropshipperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDropshipperController>(
        init: AddDropshipperController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: ContactAppbar(
                  title: 'Tambah Data Dropshipper'.tr,
                ),
                body: const DropshipperForm(),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }


}
