import 'dart:async';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';

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
    initData();
    getCountList();
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    resetFilter();
    selectDateFilter(3);
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
    state.isLoading = true;
    update();
    AppLogger.i('initDataaaa');
    try {
      BaseResponse<BasicProfileModel> profile = await profil.getBasicProfil();
      state.basic.value = profile.data?.user;
      state.listOfficerEntry.add('SEMUA');
      state.listOfficerEntry.add(state.basic.value?.name ?? '');

      if (state.basic.value?.userType == "PEMILIK") {
        Response officers = await network.base.get(
          '/officers?select=["name"]',
        );

        officers.data['data'].map((e) => e['name']).forEach((element) {
          state.listOfficerEntry.add(element);
        });
      }

      // Response response = await network.base.get(
      //   '/transaction/tracks/status',
      // );

      // List<dynamic> statusList = response.data['data'];
      // if (statusList.every((element) => element is String)) {
      //   state.listStatusKiriman.addAll(statusList.cast<String>());
      // } else {
      //   AppLogger.w('Response contains non-string items.');
      // }

      await pantau.getPantauStatus().then((value) {
        state.listStatusKiriman.addAll(value.data ?? []);
        update();
      });
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
              state.startDate.value,
              state.endDate.value,
            ]
          }
        ],
        petugasEntry: state.selectedPetugasEntry == "SEMUA"
            ? null
            : state.selectedPetugasEntry,
        status: state.selectedStatusKiriman);

    try {
      var responseCount = await pantau.getPantauCount(param);
      state.countList.addAll(responseCount.data ?? []);
      state.cod = responseCount.data?.first.totalCod?.toInt() ?? 0;
      state.codOngkir = responseCount.data?.first.totalCodOngkir?.toInt() ?? 0;
      state.noncod = responseCount.data?.first.totalNonCod?.toInt() ?? 0;
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
      AppSnackBar.error('Gagal mengambil data pantau');
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
          petugasEntry: state.selectedPetugasEntry));
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
    } catch (e) {
      AppLogger.e('error getPantauList $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  void selectDateFilter(int filter) {
    final today = DateTime.now();
    state.dateFilter.value = filter.toString();

    switch (filter) {
      case 1:
        _setDateRange(today.subtract(const Duration(days: 30)), today);
        break;
      case 2:
        _setDateRange(today.subtract(const Duration(days: 7)), today);
        break;
      case 3:
        _setDateRange(today, today);
        break;
      case 4:
        _clearDateRange();
        break;
      default:
        _clearDateRange();
    }
  }

  void _setDateRange(DateTime start, DateTime end) {
    // Set start date time to 00:00:00
    final startOfDay = DateTime(start.year, start.month, start.day);

    state.startDate.value = startOfDay;
    state.endDate.value = end;
    state.startDateField.text = startOfDay.toString().toShortDateFormat();
    state.endDateField.text = end.toString().toShortDateFormat();
  }

  void _clearDateRange() {
    state.startDate.value = null;
    state.endDate.value = null;
    state.startDateField.text = '-';
    state.endDateField.text = '-';
  }

  Future<void> resetFilter({bool? isDetail = false}) async {
    state.countList.clear();
    state.selectedPetugasEntry = state.basic.value?.userType == "PEMILIK"
        ? null
        : state.basic.value?.name;
    state.selectedStatusKiriman = "Total Kiriman";
    state.selectedTipeKiriman = "cod";
    state.tipeKiriman.value = 0;
    state.isFiltered.value = false;
    state.searchField.clear();
    state.dateFilter.value = "3";
    selectDateFilter(3);
    applyFilter(isDetail: isDetail);
  }

  Future<DateTime?> selectDate() async {
    final selectedDate = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: CustomTheme().dateTimePickerTheme(context),
          child: child!,
        );
      },
    );

    // Check if selectedDate is null before creating a new DateTime instance
    if (selectedDate != null) {
      return DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
        1,
        0,
      );
    }
    return null;
  }

  applyFilter({bool? isDetail = false}) async {
    state.filteredCountList = [];
    if (state.isLoading) return;
    state.isLoading = true;
    update();
    if (state.dateFilter.value != '3') {
      state.isFiltered.value = true;
    }

    if (state.startDate.value != null && state.endDate.value != null) {
      state.date.value = "${state.startDate}-${state.endDate}";
      state.transDate = [
        {
          "awbDate": [state.startDate.value, state.endDate.value],
        }
      ];
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }
    state.filteredCountList.add(state.countList
        .where(
          (e) => e.status == state.selectedStatusKiriman,
        )
        .first);
    update();

    AppLogger.i("filtered status : ${state.filteredCountList.length}");

    state.isLoading = true;
    // state.pagingController.refresh();
    update();

    if (isDetail != null && !isDetail) {
      getCountList();
    } else {
      state.pagingController.refresh();
    }

    await Future.delayed(const Duration(seconds: 20));
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
    // selectedStatus = statusIndex;
    state.selectedStatusKiriman = state.listStatusKiriman
        .where(
          (status) => status == item.status,
        )
        .first;
    applyFilter(isDetail: true);
    update();
  }
}
