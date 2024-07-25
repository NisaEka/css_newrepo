import 'dart:async';
import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/laporanku/data_post_ticket_model.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_category_model.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputLaporankuController extends BaseController {
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
    try {
      await laporanku.getTicketCategory().then((value) {
        listCategory.addAll(value.payload ?? []);
        update();
      });
    } catch (e) {
      e.printError();
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
            color: AppConst.isLightTheme(context) ? whiteColor : greyDarkColor1,
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
                style: appTitleTextStyle.copyWith(
                  color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1,
                ),
              ),
              CustomSearchField(
                controller: searchCategory,
                hintText: 'Cari'.tr,
                margin: const EdgeInsets.only(top: 20),
                // validate: searchCategory.text.length < 3,
                autoFocus: false,
                // validationText: 'Masukan 3 atau lebih karakter'.tr,
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
                                    e.description ?? '',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  style: ListTileStyle.list,
                                  onTap: () {
                                    selectedCategory = e;
                                    category.text = e.description ?? '';
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
                                    e.description ?? '',
                                    style: Theme.of(context).textTheme.titleMedium,
                                  ),
                                  style: ListTileStyle.list,
                                  onTap: () {
                                    selectedCategory = e;
                                    category.text = e.description ?? '';
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
            (e) => e.description?.toLowerCase().contains(search.toLowerCase()) ?? false,
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
            categoryId: selectedCategory?.id,
            subject: subject.text,
            message: message.text,
            priority: priority ? "Y" : "N",
          ))
          .then(
            (value) => value.code == 200
                ? Get.back()
                : value.code == 404
                    ? Get.showSnackbar(
                        GetSnackBar(
                          icon: const Icon(
                            Icons.warning,
                            color: whiteColor,
                          ),
                          message: 'Nomor Resi Tidak Terdaftar'.tr,
                          isDismissible: true,
                          duration: const Duration(seconds: 3),
                          backgroundColor: warningColor,
                        ),
                      )
                    : value.code == 403
                        ? Get.showSnackbar(
                            GetSnackBar(
                              icon: const Icon(
                                Icons.warning,
                                color: whiteColor,
                              ),
                              message: 'Tiket Sudah Terdaftar'.tr,
                              isDismissible: true,
                              duration: const Duration(seconds: 3),
                              backgroundColor: warningColor,
                            ),
                          )
                        : Get.showSnackbar(
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
                          ),
          );
    } catch (e) {
      e.printError();
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
