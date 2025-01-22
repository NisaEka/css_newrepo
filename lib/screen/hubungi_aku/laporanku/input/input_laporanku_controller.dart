import 'dart:async';
import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/dialog/success_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputLaporankuController extends BaseController {
  final String? awb = Get.arguments['awb'];

  final formKey = GlobalKey<FormState>();
  final noResi = TextEditingController();
  final category = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();
  final imageFile = TextEditingController();
  final searchCategory = TextEditingController();

  bool priority = false;
  bool isLoading = false;
  File? gettedPhoto;
  int? imageSize;
  var maxImageSize = 2 * 1048576;

  List<TicketCategory> listCategory = [];
  List<TicketCategory> listSearchCategory = [];
  TicketCategory? selectedCategory;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    listCategory = [];
    isLoading = true;
    if (awb != null) {
      noResi.text = awb ?? '';
      update();
    }
    try {
      await laporanku
          .getTicketCategory(QueryModel(table: true, limit: 0))
          .then((value) {
        listCategory.addAll(value.data ?? []);
        update();
      });
    } catch (e) {
      AppLogger.e('error initData input laporanku $e');
    }

    isLoading = false;
    update();
  }

  void showCategoryList() {
    searchCategory.clear();
    selectedCategory = null;
    update();
    Get.bottomSheet(
      enableDrag: true,
      isDismissible: true,
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: dropDownColor(context),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kategori".tr,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              CustomSearchField(
                controller: searchCategory,
                hintText: 'Cari'.tr,
                margin: const EdgeInsets.only(top: 20),
                autoFocus: false,
                onChanged: (value) {
                  update();
                  setState(() {
                    searchListCategory(searchCategory.text);
                  });
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView(
                  children: listSearchCategory.isNotEmpty
                      ? listSearchCategory
                          .map(
                            (e) => Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    (e.categoryDescription?.toUpperCase())
                                            ?.tr ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  style: ListTileStyle.list,
                                  onTap: () {
                                    selectedCategory = e;
                                    category.text =
                                        (e.categoryDescription?.toUpperCase())
                                                ?.tr ??
                                            '';
                                    update();
                                    Get.back();
                                  },
                                ),
                                const Divider(color: greyColor, height: 1),
                              ],
                            ),
                          )
                          .toList()
                      : listCategory
                          .map(
                            (e) => Column(
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    (e.categoryDescription?.toUpperCase())
                                            ?.tr ??
                                        '',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  style: ListTileStyle.list,
                                  onTap: () {
                                    selectedCategory = e;
                                    category.text =
                                        (e.categoryDescription?.toUpperCase())
                                                ?.tr ??
                                            '';
                                    update();
                                    Get.back();
                                  },
                                ),
                                const Divider(color: greyColor, height: 1),
                              ],
                            ),
                          )
                          .toList(),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  void searchListCategory(String search) {
    if (search == "") {
      listSearchCategory = [];
      update();
    } else {
      listSearchCategory = listCategory
          .where(
            (e) =>
                e.categoryDescription
                    ?.toLowerCase()
                    .contains(search.toLowerCase()) ??
                false,
          )
          .toList();

      update();
    }
  }

  Future<void> sendReport() async {
    isLoading = true;
    update();

    try {
      await laporanku
          .postTicket(DataPostTicketModel(
        cnote: noResi.text,
        categoryId: selectedCategory?.categoryId,
        subject: subject.text,
        message: message.text,
        priority: priority ? "Y" : "N",
      ))
          .then((value) {
        switch (value.code) {
          case 201:
            Get.to(() => SuccessScreen(
                  message:
                      'Laporanmu berhasil dibuat dan akan diproses lebih lanjut'
                          .tr,
                  thirdButtonTitle: 'OK'.tr,
                  onThirdAction: () => Get.close(2),
                ));
            break;
          case 404:
            AppSnackBar.warning('Nomor Resi Tidak Terdaftar'.tr);
            break;
          case 409:
            AppSnackBar.warning('Tiket Sudah Terdaftar'.tr);
            break;
          default:
            AppSnackBar.error('Bad Request'.tr);
            break;
        }
      });
    } catch (e) {
      AppLogger.e('error sendReport $e');
    }

    isLoading = false;
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
      imageFile.text = file.path.split('/').last.toString();
      update();
    } else {
      // User canceled the picker
    }

    Get.back();
  }
}
