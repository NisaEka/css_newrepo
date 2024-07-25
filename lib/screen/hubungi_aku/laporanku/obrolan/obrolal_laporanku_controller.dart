import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/laporanku/chat_model.dart';
import 'package:flutter/material.dart';

class ObrolanLaporankuController extends BaseController {
  final messageInsert = TextEditingController();

  // ignore: deprecated_member_use
  final List<ChatModel> messsages = [];
  late String markMsg;
  var spellMsg;
  var respMsg;

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
    update();
  }
}
