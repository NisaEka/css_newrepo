import 'dart:async';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_count_model.dart';
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

  @override
  void onInit() {
    super.onInit();
    selectDateFilter(3);
    initData();
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
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
    state.isLoading.value = true;
    AppLogger.i('initDataaaa');
    try {
      var token = await storageSecure.read(key: 'token');
      network.base.options.headers['Authorization'] = 'Bearer $token';

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

      Response response = await network.base.get(
        '/transaction/tracks/status',
      );

      List<dynamic> statusList = response.data['data'];
      if (statusList.every((element) => element is String)) {
        state.listStatusKiriman.addAll(statusList.cast<String>());
      } else {
        AppLogger.w('Response contains non-string items.');
      }
    } catch (e, i) {
      AppLogger.e('error pantau', e, i);
      AppSnackBar.error('Gagal mengambil data'.tr);
    } finally {
      state.selectedStatusKiriman.value = state.listStatusKiriman.first;
      applyFilter();
    }
  }

  Future<void> getCountList() async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    var param = CountQueryModel(
      between: [
        {
          "awbDate": [
            state.startDate.value,
            state.endDate.value,
          ]
        }
      ],
      petugasEntry: state.selectedPetugasEntry.value == "SEMUA"
          ? null
          : state.selectedPetugasEntry.value,
    );

    try {
      Response responseCount = await network.base.get(
        '/transaction/tracks/count',
        queryParameters: param.toJson(),
      );
      AppLogger.d('Pantauuuuuu count ${responseCount.data}');

      state.countList.value = responseCount.data['data'];
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
      AppSnackBar.error('Gagal mengambil data pantau');
    } finally {
      state.isLoading.value = false;
    }
  }

  Future<void> getPantauList(int page) async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    var param = QueryModel(
      table: true,
      page: page,
      limit: pageSize,
      between: [
        {
          "awbDate": [
            state.startDate.value,
            state.endDate.value,
          ]
        }
      ],
      entity: state.selectedStatusKiriman.value,
      type: state.selectedTipeKiriman.value,
      search: state.searchField.text,
      petugasEntry: state.selectedPetugasEntry.value == "SEMUA"
          ? null
          : state.selectedPetugasEntry.value,
    );

    try {
      Response response = await network.base.get(
        '/transaction/tracks/count/details',
        queryParameters: param.toJson(),
      );
      AppLogger.d('Pantauuuuuu ${response.data}');

      var trans = BaseResponse<List<PantauPaketmuModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<PantauPaketmuModel>(
                  (i) => PantauPaketmuModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
      // return BaseResponse<List<PantauPaketmuModel>>

      final isLastPage = trans.meta!.currentPage == trans.meta!.lastPage;
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
        return;
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        return;
      }
    } catch (e, i) {
      AppLogger.e('error pantau list', e, i);
      AppSnackBar.error('Gagal mengambil data pantau list');
      state.pagingController.error = e;
    } finally {
      state.isLoading.value = false;
    }
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
    state.selectedPetugasEntry.value = state.basic.value?.userType == "PEMILIK"
        ? null
        : state.basic.value?.name;
    state.selectedStatusKiriman.value = "Total Kiriman";
    state.selectedTipeKiriman.value = "cod";
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
    if (state.dateFilter.value != '3') {
      state.isFiltered.value = true;
    }

    if (state.startDate.value != null && state.endDate.value != null) {
      state.date.value = "${state.startDate}-${state.endDate}";
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }

    state.isLoading.value = true;

    if (isDetail != null && !isDetail) {
      getCountList();
    } else {
      state.pagingController.refresh();
    }
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
