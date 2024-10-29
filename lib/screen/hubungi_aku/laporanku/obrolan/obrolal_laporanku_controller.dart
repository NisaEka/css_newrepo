import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/util/logger.dart';
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
  String? spellMsg;
  String? respMsg;

  File? gettedPhoto;
  int? imageSize;
  var maxImageSize = 2 * 1048576;
  final PagingController<int, TicketMessageModel> pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getMessages(pageKey);
    });
    AppLogger.d('idMessage$id');
  }

  Future<void> initData() async {
    messages = [];
    try {
      await laporanku.getTickeMessage(id, 1, pageSize).then((value) {
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
      final message = await laporanku.getTickeMessage(id, page, pageSize);

      final isLastPage = (message.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(message.payload ?? []);
        messages.addAll(message.payload ?? []);
        // subject = message.payload?.first.subject;
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(message.payload ?? [], nextPageKey);
        messages.addAll(message.payload ?? []);
        // subject = message.payload?.first.subject;
      }
    } catch (e) {
      e.printError(info: 'error message paging');
      pagingController.error = e;
    }
    AppLogger.d('messages.length ${messages.length}');
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
            cnote: ticket.cnote,
            categoryId: ticket.category?.id,
            id: id,
            subject: subject,
            message: messageInsert.text.toUpperCase(),
            type: 'S',
            image: null,
            priority: ticket.priority),
      )
          .then((value) {
        value.toJson().printInfo(info: "tm response");
        if (value.code == 201) {
          pagingController.refresh();
          initData();
          messageInsert.clear();
          gettedPhoto = null;
          update();
        } else {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: whiteColor,
              ),
              message: value.message?.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: errorColor,
            ),
          );
        }
      });
    } catch (e) {
      e.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.warning,
            color: whiteColor,
          ),
          message: 'Bad Request'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
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
