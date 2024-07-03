import 'dart:io';

import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePickerContainer extends StatelessWidget {
  final String containerTitle;
  final String? pickedImagePath;
  final Function onPickImage;

  const ImagePickerContainer({
    super.key,
    required this.containerTitle,
    required this.pickedImagePath,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color:
          Theme.of(context).brightness == Brightness.light
              ? Colors.black
              : Colors.white,
        ),
      ),
      child: _imagePickerContent(context),
    );
  }

  Widget _imagePickerContent(BuildContext context) {
    if (pickedImagePath != null) {
      return GestureDetector(
        onTap: () => onPickImage(),
        child: Container(
          width: Get.width,
          height: Get.width / 2,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
          child: Image(
              image: FileImage(File(pickedImagePath!)), fit: BoxFit.fitWidth),
        ),
      );
    } else {
      return TextButton(
        onPressed: () => onPickImage(),
        child: Text(
          containerTitle.tr,
          style: sublistTitleTextStyle.copyWith(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black
                  : Colors.white),
        ),
      );
    }
  }

}
