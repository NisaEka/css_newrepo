import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
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
  int selectedStatus = 0;

  @override
  void onInit() {
    super.onInit();
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    initData();
    getCountList();
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    resetFilter();
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter();
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
    // if (state.isLoading) return;
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
      state.selectedStatusKiriman = state.listStatusKiriman.first;
      applyFilter();
    }
    state.isLoading = false;
    update();
  }

  Future<void> getCountList() async {
    state.isLoading = true;
    state.countList = [];
    update();
    var param = QueryModel(
        between: [
          {
            "awbDate": [
              state.startDate,
              state.endDate,
            ]
          }
        ],
        petugasEntry: (state.selectedPetugasEntry?.name == "SEMUA")
            ? ""
            : state.selectedPetugasEntry?.name ?? "",
        status: state.selectedStatusKiriman);

    try {
      var responseCount = await pantau.getPantauCount(param);
      state.countList.addAll(responseCount.data ?? []);
      state.cod = responseCount.data?.first.totalCod?.toInt() ?? 0;
      state.codOngkir = responseCount.data?.first.totalCodOngkir?.toInt() ?? 0;
      state.noncod = responseCount.data?.first.totalNonCod?.toInt() ?? 0;
      update();
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
      AppSnackBar.error('Gagal mengambil data pantau'.tr);
    }

    if (state.selectedStatusKiriman != null &&
        state.selectedStatusKiriman != "") {
      state.filteredCountList = state.countList
          .where((e) => e.status == state.selectedStatusKiriman)
          .toList();
      update();
    } else {
      state.filteredCountList = List.from(state.countList);
      update();
    }
    // await Future.delayed(const Duration(seconds: 2));
    state.isLoading = false;
    update();
  }

  Future<void> getPantauList(int page) async {
    state.isLoading = true;
    try {
      final trans = await pantau.getPantauList(QueryModel(
        search: state.searchField.text,
        between: state.transDate,
        entity: state.selectedStatusKiriman,
        type: state.selectedTipeKiriman,
        petugasEntry: state.selectedPetugasEntry?.name,
      ));
      final isLastPage =
          (trans.meta?.currentPage ?? 0) == (trans.meta?.lastPage ?? 0);
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }

      await setting.getSettingLabel().then(
        (value) async {
          await storage.writeString(
            StorageCore.transactionLabel,
            value.data?.labels?.where((e) => e.enabled ?? false).first.name,
          );
          await storage.writeString(StorageCore.shippingCost,
              value.data?.priceLabel != '0' ? "PUBLISH" : "HIDE");
        },
      );
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
      // final petugasEntry = state.listOfficerEntry.firstWhere((element) => element.id == state.basic?.id);
      state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      // state.listOfficerEntry.add(PetugasModel(name: state.basic?.name ?? ''));
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
    state.filteredCountList = [];
    if (state.isLoading) return;
    state.isLoading = true;
    update();
    if (state.dateFilter != '3') {
      state.isFiltered = true;
    }

    if (state.startDate != null && state.endDate != null) {
      state.date.value = "${state.startDate}-${state.endDate}";
      state.transDate = [
        {
          "awbDate": [state.startDate, state.endDate],
        }
      ];
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }
    update();

    if (isDetail != null && !isDetail) {
      getCountList();
    } else {
      state.pagingController.refresh();
    }

    AppLogger.i("filtered status : ${state.filteredCountList.length}");
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

  void setSelectedStatus(PantauPaketmuCountModel item) {
    state.selectedStatusKiriman = item.status;
    applyFilter(isDetail: true);
    update();
  }
}
