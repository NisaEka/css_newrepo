import 'package:css_mobile/screen/paketmu/input_kiriman/components/consignee_form.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/contact_appbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_receiver_controller.dart';

class AddReceiverScreen extends StatelessWidget {
  const AddReceiverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddReceiverController>(
        init: AddReceiverController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: ContactAppbar(title: 'Tambah Data Penerima'.tr),
                body: const ConsigneeForm(),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
