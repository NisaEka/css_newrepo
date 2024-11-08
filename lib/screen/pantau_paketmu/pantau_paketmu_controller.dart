import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/query_count_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';

class PantauPaketmuController extends BaseController {
  final PantauPaketmuState state = PantauPaketmuState();
  static const pageSize = 10;
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    selectDateFilter(3);
    initData();
  }

  // @override
  // void onClose() {
  //   // Dispose of controllers and subscriptions if needed
  //   state.pagingController.dispose();
  //   state.startDateField.dispose();
  //   state.endDateField.dispose();
  //   state.searchField.dispose();
  //   super.onClose();
  // }

  Future<void> initData() async {
    state.isLoading.value = true;
    try {
      var token = await storageSecure.read(key: 'token');
      network.base.options.headers['Authorization'] = 'Bearer $token';

      await profil
          .getBasicProfil()
          .then((value) async => state.basic.value = value.data?.user);

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
    } finally {
      state.selectedStatusKiriman.value = state.listStatusKiriman.first;
      state.isLoading.value = false;
      applyFilter();
    }
  }

  Future<void> getCountList() async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    AppLogger.i('start date: ${state.startDate}');
    AppLogger.i('end date: ${state.endDate}');
    var param = CountQueryModel(
      between: [
        {
          "awbDate": [
            state.startDate.value,
            state.endDate.value,
          ]
        }
      ],
    );
    AppLogger.i('Pantauuuuuu count');
    try {
      Response responseCount = await network.base.get(
        '/transaction/tracks/count',
        queryParameters: param.toJson(),
      );
      AppLogger.d('Pantauuuuuu ${responseCount.data}');

      state.countList.value = responseCount.data['data'];
      AppLogger.d('responseCount.data: ${state.countList}');
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
    } finally {
      AppLogger.i('finally pantau count');
      state.isLoadCount.value = true;
      state.isLoading.value = false;
    }
  }

  Future<void> getPantauList(int page) async {
    state.isLoading.value = true;
    AppLogger.i('Pantauuuuuu list');
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    AppLogger.i('start date: ${state.startDate}');
    AppLogger.i('end date: ${state.endDate}');
    var param = QueryModel(
      table: true,
      page: 1,
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
    );

    try {
      // final trans = await pantau.getPantauList(
      //   page,
      //   pageSize,
      //   state.date ?? '',
      //   state.searchField.text,
      //   state.selectedPetugasEntry != "SEMUA"
      //       ? (state.selectedPetugasEntry ?? '')
      //       : '',
      //   state.selectedStatusKiriman ?? '',
      //   state.selectedTipeKiriman ?? '',
      // );
      Response response = await network.base.get(
        '/transaction/tracks/count/detail',
        queryParameters: param.toJson(),
      );
      AppLogger.d('Pantauuuuuu ${response.data}');
      var trans = GetPantauPaketmuModel.fromJson(response.data);

      final isLastPage = (trans.data?.length ?? 0) < pageSize;
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e, i) {
      AppLogger.e('error pantau list', e, i);
      state.pagingController.error = e;
    }

    state.isLoading.value = false;
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

  Future<void> resetFilter() async {
    AppLogger.i('Reset Filter');
    state.countList.clear();
    state.selectedPetugasEntry.value = state.basic.value?.userType == "PEMILIK"
        ? null
        : state.basic.value?.name;
    // state.selectedStatusKiriman.value = "Total Kiriman";
    // state.selectedTipeKiriman.value = "cod";
    state.tipeKiriman.value = 0;
    state.isFiltered.value = false;
    state.searchField.clear();
    state.dateFilter.value = "3";
    selectDateFilter(3);
    state.pagingController.refresh();
    applyFilter();
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

  applyFilter({bool? isDetail = false}) {
    if (state.dateFilter.value != '3') {
      state.isFiltered.value = true;
    }

    if (state.startDate.value != null && state.endDate.value != null) {
      state.date.value = "${state.startDate}-${state.endDate}";
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }
    AppLogger.i('Apply Filter');
    AppLogger.i('Apply Filter ${state.selectedTipeKiriman.value}');
    state.isLoading.value = true;
    if (isDetail != null && !isDetail) {
      getCountList();
    } else {
      getPantauList(pageSize);
    }
    state.pagingController.refresh();
  }
}
