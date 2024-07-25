import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/laporanku/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ObrolanLaporankuController extends BaseController {
  final messageInsert = TextEditingController();

  // ignore: deprecated_member_use
  final List<ChatModel> messsages = [];
  late String markMsg;
  var spellMsg;
  var respMsg;

  File? gettedPhoto;
  int? imageSize;
  var maxImageSize = 2 * 1048576;

  void response(String message) async {
    messsages.add(
      ChatModel(
        data: 0,
        message: message,
      ),
    );
    update();
  }

  void sendMessage() {
    messsages.add(ChatModel(
      data: 1,
      message: messageInsert.text,
    ));
    messageInsert.clear();
    gettedPhoto = null;
    update();
  }

  getSinglePhoto(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: source);

    if (image != null) {
      File file = File(image.path);
      gettedPhoto = file;
      var imagePath = await image.readAsBytes();
      imageSize = imagePath.length;
      update();
    } else {
      // User canceled the picker
    }

    Get.back();
  }
}
