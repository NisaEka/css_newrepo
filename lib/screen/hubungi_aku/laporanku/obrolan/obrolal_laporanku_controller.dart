import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ObrolanLaporankuController extends BaseController {
  String id = Get.arguments['id'];
  TicketModel ticket = Get.arguments['ticket'];
  final messageInsert = TextEditingController();

  // ignore: deprecated_member_use
  List<TicketMessageModel> messages = [];
  late String markMsg;
  String? subject;
  bool isLoading = false;
  int currentPage = 1;
  var spellMsg;
  var respMsg;

  File? gettedPhoto;
  int? imageSize;
  var maxImageSize = 2 * 1048576;
  final PagingController<int, TicketMessageModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getMessages(pageKey);
    });
    print("idMessage$id");
  }

  Future<void> initData() async {
    messages = [];
    try {
      await laporanku.getTickeMessage(id, 1).then((value) {
        messages.addAll(value.payload ?? []);
        subject = value.payload?.first.subject;
        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> getMessages(int page) async {
    isLoading = true;
    try {
      final message = await laporanku.getTickeMessage(id, page);

      final isLastPage = (message.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(message.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        currentPage++;
        update();
        final nextPageKey = page + 1;
        pagingController.appendPage(message.payload ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e) {
      e.printError(info: 'error message paging');
      pagingController.error = e;
    }

    isLoading = false;
    update();
  }

  void response(String message) async {
    messages.add(
      TicketMessageModel(
        type: 'S',
        message: message,
      ),
    );
    update();
  }

  void sendMessage() async {
    try {
      await laporanku
          .postTicketMessage(
        DataPostTicketModel(
          id: id,
          subject: subject,
          message: messageInsert.text.toUpperCase(),
          type: 'S',
          image: '',
        ),
      )
          .then((value) {
        if (value.code == 201) {
          pagingController.refresh();
          initData();
          messageInsert.clear();
          gettedPhoto = null;
          update();
        }
      });
    } catch (e) {
      e.printError();
    }
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
