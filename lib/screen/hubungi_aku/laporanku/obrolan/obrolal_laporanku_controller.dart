import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
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
      await laporanku
          .getTickeMessage(QueryModel(
              table: true,
              where: [
                {"ticketId": id}
              ],
              sort: [
                {"createdDate": "desc"}
              ],
              page: 1,
              limit: pageSize))
          .then((value) {
        messages.addAll(value.data ?? []);
        subject = value.data?.first.subject;
        update();
      });
    } catch (e) {
      AppLogger.e('error initData obrolan laporanku $e');
    }
  }

  Future<void> getMessages(int page) async {
    isLoading = true;
    try {
      final message = await laporanku.getTickeMessage(QueryModel(
          table: true,
          where: [
            {"ticketId": id}
          ],
          sort: [
            {"createdDate": "desc"}
          ],
          page: page,
          limit: pageSize));

      final isLastPage = message.meta!.currentPage == message.meta!.lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(message.data ?? []);
        messages.addAll(message.data ?? []);
        // subject = message.payload?.first.subject;
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(message.data ?? [], nextPageKey);
        messages.addAll(message.data ?? []);
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
            categoryId: ticket.category?.categoryId,
            ticketId: id,
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
          AppSnackBar.error(value.message?.tr);
        }
      });
    } catch (e) {
      AppLogger.e('error sendMessage $e');
      AppSnackBar.error('Bad Request'.tr);
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
