import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PengaturanPetugasController extends BaseController {
  final searchOfficer = TextEditingController();
  final PagingController<int, PetugasModel> pagingController = PagingController(firstPageKey: 1);
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getOfficerList(pageKey);
    });
  }

  Future<void> delete(PetugasModel item) async {
    try {
      await setting.deleteOfficer(item.id.toString()).then((value) {
        pagingController.refresh();
        update();
        if (value.code == 403) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.info,
                color: whiteColor,
              ),
              message: value.message,
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
        const GetSnackBar(
          icon: Icon(
            Icons.info,
            color: whiteColor,
          ),
          message: "Forbidden",
          isDismissible: true,
          duration: Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
    }

    update();
  }

  Future<void> getOfficerList(int page) async {
    isLoading = true;
    try {
      final officer = await setting.getOfficer(page, searchOfficer.text);

      final isLastPage = (officer.payload?.length ?? 0) < 10;
      if (isLastPage) {
        pagingController.appendLastPage(officer.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(officer.payload ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e) {
      e.printError();
      pagingController.error = e;
    }

    isLoading = false;
    update();
  }
}
