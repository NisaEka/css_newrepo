import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'add/tambah_petugas_screen.dart';

class PengaturanPetugasController extends BaseController {
  final searchOfficer = TextEditingController();
  final PagingController<int, PetugasModel> pagingController = PagingController(firstPageKey: 1);
  bool isLoading = false;
  int limit = 10;

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
          AppSnackBar.error(value.message!);
        }
      });
    } catch (e) {
      AppLogger.e('error delete petugas', e);
      AppSnackBar.error('Forbidden');
    }

    update();
  }

  Future<void> getOfficerList(int page) async {
    isLoading = true;
    try {
      final officer = await setting.getOfficers(page, searchOfficer.text, limit);

      final isLastPage =
          (officer.meta?.currentPage ?? 0) == (officer.meta?.lastPage ?? 0);
      if (isLastPage) {
        pagingController.appendLastPage(officer.data ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(officer.data ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e) {
      AppLogger.e('error getOfficerList $e');
      pagingController.error = e;
    }

    isLoading = false;
  }

  void onAdd() {
    Get.to(const TambahPetugasScreen(), arguments: {
      'isEdit': false,
    })?.then((value) => pagingController.refresh());
  }
}
