import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputLaporankuController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final noResi = TextEditingController();
  final category = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();
  final imageFile = TextEditingController();

  bool priority = false;
  File? gettedPhoto;
  int? imageSize;
  var maxImageSize = 2 * 1048576;

  Future<void> sendReport() async {}

  getSinglePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      File file = File(image.path);
      gettedPhoto = file;
      var imagePath = await image.readAsBytes();
      imageSize = imagePath.length;
      imageFile.text = file.path.split('/').last.toString();
      update();
    } else {
      // User canceled the picker
    }

    Get.back();
  }
}
