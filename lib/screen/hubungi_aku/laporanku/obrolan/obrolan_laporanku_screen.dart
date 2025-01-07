import 'package:bubble/bubble.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_message_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/obrolan/obrolal_laporanku_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
// import 'package:css_mobile/widgets/dialog/image_popup_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/items/show_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ObrolanLaporankuScreen extends StatelessWidget {
  const ObrolanLaporankuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ObrolanLaporankuController>(
        init: ObrolanLaporankuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller, context),
            body: _bodyContent(controller, context),
            backgroundColor:
                AppConst.isLightTheme(context) ? greyLightColor2 : bgDarkColor,
          );
        });
  }

  Widget _bodyContent(ObrolanLaporankuController c, BuildContext context) {
    return Column(
      children: [
        Container(
          color: primaryColor(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.headphones_rounded, color: whiteColor),
                const SizedBox(width: 15),
                Text(
                  "Customer Care".tr,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: whiteColor, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        // IconButton(
        //   onPressed: () {
        //     // c.pagingController.refresh();
        //     c.getMessages(c.currentPage);
        //     print(c.currentPage);
        //     // c.initData(c.currentPage+1);
        //   },
        //   icon: Icon(Icons.refresh),
        // ),
        Flexible(
          child: c.gettedPhoto != null
              ? SizedBox(
                  // height: Get.height / 2,
                  width: Get.width - 50,
                  child: Image.file(
                    c.gettedPhoto!,
                    fit: BoxFit.fill,
                  ),
                )
              : PagedListView<int, TicketMessageModel>(
                  reverse: true,
                  pagingController: c.pagingController,
                  builderDelegate:
                      PagedChildBuilderDelegate<TicketMessageModel>(
                    transitionDuration: const Duration(milliseconds: 500),
                    itemBuilder: (context, e, i) => Column(
                      children: [
                        Text(
                          // e.createdDate.toString(),
                          c.messages.length > i + 1
                              ? e.createdDate!.toShortDateFormat() !=
                                      c.messages[i + 1].createdDate!
                                          .toShortDateFormat()
                                  ? e.createdDate
                                          ?.toShortDateFormat()
                                          .toString() ??
                                      ''
                                  : ''
                              : e.createdDate?.toShortDateFormat().toString() ??
                                  '',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(
                                  color: AppConst.isLightTheme(context)
                                      ? greyDarkColor2
                                      : greyLightColor2),
                        ),
                        c.messages.length > i + 1
                            ? e.createdDate!.toShortDateFormat() !=
                                    c.messages[i + 1].createdDate!
                                        .toShortDateFormat()
                                ? const SizedBox(height: 10)
                                : const SizedBox()
                            : const SizedBox(),
                        chat(e, context),
                      ],
                    ),
                    firstPageProgressIndicatorBuilder: (context) =>
                        const LoadingDialog(
                      height: 100,
                      background: Colors.transparent,
                    ),
                    newPageProgressIndicatorBuilder: (context) =>
                        const LoadingDialog(
                      background: Colors.transparent,
                      height: 50,
                      size: 30,
                    ),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const DataEmpty(),
                  ),
                ),
          // child: ListView(
          //   reverse: true,
          //   children: c.gettedPhoto != null
          //       ? [
          //           SizedBox(
          //             // height: Get.height / 2,
          //             width: Get.width - 50,
          //             child: Image.file(
          //               c.gettedPhoto!,
          //               fit: BoxFit.fill,
          //             ),
          //           )
          //         ]
          //       : c.messages
          //           .mapIndexed(
          //             (i, e) => Column(
          //               children: [
          //                 Text(c.messages.length > i + 1
          //                     ? e.createdDate!.toShortDateFormat() != c.messages[i + 1].createdDate!.toShortDateFormat()
          //                         ? e.createdDate?.toShortDateFormat().toString() ?? ''
          //                         : ''
          //                     : e.createdDate?.toShortDateFormat().toString() ?? ''),
          //                 chat(e, context),
          //               ],
          //             ),
          //           )
          //           .toList(),
          // ),
        ),
        ListTile(
          title: TextFormField(
            controller: c.messageInsert,
            minLines: 1,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: "Tulis Pesan".tr,
              hintStyle: hintTextStyle,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(10),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: greyColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: greyColor)),
              suffixIcon: GestureDetector(
                onTap: () => Get.dialog(StatefulBuilder(
                  builder: (context, setState) => AlertDialog(
                    backgroundColor: AppConst.isLightTheme(context)
                        ? whiteColor
                        : bgDarkColor,
                    scrollable: false,
                    title: Text(
                      "Upload Gambar".tr,
                      style: TextStyle(
                          color: AppConst.isLightTheme(context)
                              ? greyDarkColor2
                              : greyLightColor2),
                      textAlign: TextAlign.center,
                    ),
                    alignment: Alignment.center,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Text("Upload Gambar".tr),
                        CustomFilledButton(
                          color: AppConst.isLightTheme(context)
                              ? blueJNE
                              : whiteColor,
                          title: "Ambil Gambar".tr,
                          isTransparent: true,
                          onPressed: () => c.getSinglePhoto(ImageSource.camera),
                        ),
                        CustomFilledButton(
                          color: primaryColor(context),
                          title: "Pilih dari galeri".tr,
                          onPressed: () =>
                              c.getSinglePhoto(ImageSource.gallery),
                        )
                      ],
                    ),
                  ),
                )),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: greyColor,
                ),
              ),
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: regular),
            onFieldSubmitted: (value) => c.sendMessage(),
          ),
          trailing: GestureDetector(
            onTap: () => c.sendMessage(),
            child: Container(
              height: 45,
              width: 45,
              decoration: BoxDecoration(
                  color: AppConst.isLightTheme(context)
                      ? successColor
                      : warningColor,
                  borderRadius: BorderRadius.circular(50)),
              padding: const EdgeInsets.only(left: 5),
              child: const Center(
                child: Icon(
                  Icons.send_rounded,
                  size: 25.0,
                  color: whiteColor,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget chat(TicketMessageModel msg, BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment:
            msg.type == "S" ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          msg.type == "R"
              ? avatar("${msg.user}\n${msg.branchCode}", context)
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: msg.type == "R"
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                Bubble(
                  radius: const Radius.circular(8),
                  color: msg.type == "R"
                      ? AppConst.isLightTheme(context)
                          ? Colors.grey[600]
                          : greyDarkColor2
                      : AppConst.isLightTheme(context)
                          ? whiteColor
                          : greyDarkColor1,
                  elevation: 0.0,
                  showNip: true,
                  nip: msg.type == "R"
                      ? BubbleNip.leftBottom
                      : BubbleNip.rightBottom,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: Get.width / 1.5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${msg.user} ${msg.branchCode != null ? '| ${msg.branchCode}' : ''}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        color: msg.type == "R"
                                            ? primaryColor(context)
                                            : AppConst.isLightTheme(context)
                                                ? redJNE
                                                : warningColor,
                                        fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${'Subjek'.tr} : ${msg.subject ?? ''}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: msg.type == "R"
                                          ? whiteColor
                                          : textColor(context),
                                    ),
                              ),
                              Text(
                                msg.message ?? '',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontWeight: regular,
                                      color: msg.type == "R"
                                          ? whiteColor
                                          : textColor(context),
                                    ),
                              ),
                              // GestureDetector(
                              //   onTap: () => showDialog(
                              //     context: context,
                              //     builder: (context) => ImagePopupDialog(
                              //       title: '',
                              //       img: msg.image != null &&
                              //               (msg.image!.startsWith('https') ||
                              //                   msg.image!.startsWith('http'))
                              //           ? msg.image!
                              //           : "https://css.jne.co.id/uploads/img/${msg.image ?? ''}",
                              //     ),
                              //   ),
                              //   child: Image.network(
                              //     msg.image != null &&
                              //             (msg.image!.startsWith('https') ||
                              //                 msg.image!.startsWith('http'))
                              //         ? msg.image!
                              //         : "https://css.jne.co.id/uploads/img/${msg.image ?? ''}",
                              //     errorBuilder: (context, error, stackTrace) =>
                              //         const SizedBox(),
                              //   ),
                              // )
                              GestureDetector(
                                onTap: () => showImagePreview(
                                  context,
                                  msg.image != null &&
                                          (msg.image!.startsWith('https') ||
                                              msg.image!.startsWith('http'))
                                      ? msg.image!
                                      : "https://css.jne.co.id/uploads/img/${msg.image ?? ''}",
                                ),
                                child: Image.network(
                                  msg.image != null &&
                                          (msg.image!.startsWith('https') ||
                                              msg.image!.startsWith('http'))
                                      ? msg.image!
                                      : "https://css.jne.co.id/uploads/img/${msg.image ?? ''}",
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SizedBox(),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  msg.createdDate?.toTimeFormat() ?? '',
                  style: Theme.of(context).textTheme.titleSmall,
                )
              ],
            ),
          ),
          msg.type == "S"
              ? avatar("${msg.user}\n${msg.branchCode}", context)
              : Container(),
        ],
      ),
    );
  }

  Widget avatar(String name, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: greyLightColor3, borderRadius: BorderRadius.circular(50)),
          child: Text(
            name.substring(0, 1),
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }

  CustomTopBar _appBarContent(
      ObrolanLaporankuController c, BuildContext context) {
    return CustomTopBar(
      title: "Obrolan".tr,
      action: [
        c.gettedPhoto != null
            ? IconButton(
                onPressed: () {
                  c.gettedPhoto = null;
                  c.update();
                },
                icon: const Icon(Icons.close),
                padding: EdgeInsets.zero,
              )
            : const SizedBox(),
      ],
    );
  }
}
