import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;

class PantauPaketmuController extends BaseController {
  final PantauPaketmuState state = PantauPaketmuState();
  static const pageSize = 10;
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    initData();
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    state.selectedStatusKiriman = 'Total Kiriman';
    AppLogger.i('selected status filter : ${state.statusFilter}');
    if (state.statusFilter != null) {
      state.selectedStatusKiriman = state.statusFilter;
      state.startDate = state.startDateFilter ??
          DateTime.now()
              .subtract(const Duration(days: 6))
              .copyWith(hour: 0, minute: 0);
      state.endDate = state.endDateFilter ?? DateTime.now();
      state.dateFilter = state.dateF ?? '2';
      state.selectedTipeKiriman = state.tipeFilter;
      update();
    }
    state.transDate = [
      {
        "awbDate": [state.startDate, state.endDate]
      }
    ];
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    update();
    applyFilter(isDetail: true);
  }

  @override
  void onClose() {
    // Dispose of controllers and subscriptions if needed
    state.pagingController.dispose();
    state.startDateField.dispose();
    state.endDateField.dispose();
    state.searchField.dispose();
    _debounceTimer
        ?.cancel(); // Cancel the timer when the controller is disposed
    super.onClose();
  }

  Future<void> initData() async {
    state.listStatusKiriman = [];
    state.isLoading = true;
    update();
    AppLogger.i('initDataaaa');
    try {
      state.basic =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
      update();

      state.listOfficerEntry.add('SEMUA');
      state.listOfficerEntry.add(state.basic?.name ?? '');

      if (state.basic?.userType != "PEMILIK") {
        state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      }

      await pantau.getPantauStatus().then((value) {
        state.listStatusKiriman.addAll(value.data ?? []);
        update();
      });
      update();
    } catch (e, i) {
      AppLogger.e('error pantau', e, i);
      AppSnackBar.error('Gagal mengambil data'.tr);
    } finally {
      // state.selectedStatusKiriman = state.listStatusKiriman.first;
    }
    state.isLoading = false;
    update();
  }

  Future<void> getPantauList(int page) async {
    state.isLoading = true;
    try {
      final trans = await pantau.getPantauList(QueryModel(
        search: state.searchField.text,
        between: state.transDate,
        entity: state.statusFilter ?? state.selectedStatusKiriman,
        type: state.selectedTipeKiriman,
        petugasEntry: state.selectedPetugasEntry?.name,
      ));
      final isLastPage =
          (trans.meta?.currentPage ?? 0) == (trans.meta?.lastPage ?? 0);
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e) {
      AppLogger.e('error getPantauList $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  Future<void> resetFilter({bool? isDetail = false}) async {
    state.countList.clear();
    if (state.basic?.userType != "PEMILIK") {
      state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
    } else {
      state.selectedPetugasEntry = null;
    }
    update();

    state.selectedStatusKiriman = "Total Kiriman";
    state.selectedTipeKiriman = "cod";
    state.tipeKiriman.value = 0;
    state.isFiltered = true;
    state.searchField.clear();
    state.dateFilter = "3";
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter(isDetail: isDetail);
  }

  applyFilter({bool? isDetail = false}) async {
    if (state.isLoading) return;
    state.isLoading = true;
    update();
    state.date.value = "${state.startDate}-${state.endDate}";
    state.transDate = [
      {
        "awbDate": [state.startDate, state.endDate],
      }
    ];
    update();

    state.pagingController.refresh();

    update();

    state.isLoading = false;
    update();
  }

  void onSearchChanged(String value) {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // Set a new timer for debounce
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Trigger the search or refresh when the user stops typing
      state.searchField.text = value;
      state.pagingController.refresh();
    });
  }
}
