import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/receiver_form.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/transaction_appbar.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver_controller.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiverScreen extends StatefulWidget {
  const ReceiverScreen({super.key});

  @override
  State<ReceiverScreen> createState() => _ReceiverScreenState();
}

class _ReceiverScreenState extends State<ReceiverScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReceiverController>(
        init: ReceiverController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: TransactionAppbar(
                  data: controller.state.data,
                  isOnline: controller.state.isOnline,
                  currentStep: 1,
                ),
                body: RefreshIndicator(
                  color: greyColor,
                  onRefresh: () => controller.initData(),
                  child: const ReceiverForm(),
                ),
              ),
              controller.state.isLoadSave ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }
}
