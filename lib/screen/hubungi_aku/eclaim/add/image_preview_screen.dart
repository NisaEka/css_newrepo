import 'dart:io';
import 'package:css_mobile/screen/hubungi_aku/eclaim/add/add_eclaim_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePreviewScreen extends StatelessWidget {
  final File image;

  const ImagePreviewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddEclaimController>(
        init: AddEclaimController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "E-Claim".tr,
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.file(image),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        });
  }
}
