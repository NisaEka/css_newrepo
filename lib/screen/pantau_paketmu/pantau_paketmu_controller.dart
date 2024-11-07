import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/query_count_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:dio/dio.dart';
import 'package:toastification/toastification.dart';

class PantauPaketmuController extends BaseController {
  final state = PantauPaketmuState();
  static const pageSize = 10;
  final network = Get.find<NetworkCore>();
  final storageSecure = const FlutterSecureStorage();

  @override
  void onInit() {
    super.onInit();
    selectDateFilter(3);
    Future.wait([initData()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    update();
  }

  Future<void> initData() async {
    state.isLoading = true;
    update();
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';

    try {
      await profil
          .getBasicProfil()
          .then((value) async => state.basic = value.data?.user);

      state.listOfficerEntry.add('SEMUA');
      state.listOfficerEntry.add(state.basic?.name ?? '');

      if (state.basic?.userType == "PEMILIK") {
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
      state.selectedStatusKiriman = state.listStatusKiriman.first;
      state.isLoading = false;
      update();
      applyFilter();
    }
  }

  void selectDateFilter(int filter) {
    state.dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      state.startDate = null;
      state.endDate = null;
      state.startDateField.text = '-';
      state.endDateField.text = '-';
    } else if (filter == 1) {
      state.startDate = state.nowDay.subtract(const Duration(days: 30));
      state.endDate = DateTime.now();
      state.startDateField.text =
          state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 2) {
      state.startDate = state.nowDay.subtract(const Duration(days: 7));
      state.endDate = DateTime.now();
      state.startDateField.text =
          state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 3) {
      state.startDate = state.nowDay;
      state.endDate = DateTime.now();
      state.startDateField.text =
          state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    }

    update();
  }

  Future<void> getPantauList(int page) async {
    state.isLoading = true;
    try {
      final trans = await pantau.getPantauList(
        page,
        pageSize,
        state.date ?? '',
        state.searchField.text,
        state.selectedPetugasEntry != "SEMUA"
            ? (state.selectedPetugasEntry ?? '')
            : '',
        state.selectedStatusKiriman ?? '',
        state.selectedTipeKiriman ?? '',
      );

      final isLastPage = (trans.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.payload ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.payload ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e, i) {
      e.printError();
      i.printError();
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  Future<void> resetFilter() async {
    AppLogger.i('Reset Filter');
    state.countList.clear();
    state.selectedPetugasEntry =
        state.basic?.userType == "PEMILIK" ? null : state.basic?.name;
    state.selectedStatusKiriman = "Total Kiriman";
    state.selectedTipeKiriman = "SEMUA";
    state.tipeKiriman = 0;
    state.isFiltered = false;
    state.searchField.clear();
    state.dateFilter = "3";
    selectDateFilter(3);
    state.pagingController.refresh();
    applyFilter();
    update();
  }

  Future<DateTime?> selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: CustomTheme().dateTimePickerTheme(context),
          child: child!,
        );
      },
    ).then((selectedDate) => DateTime(
          selectedDate!.year,
          selectedDate.month,
          selectedDate.day,
          1,
          0,
        ));
  }

  applyFilter() {
    if (state.dateFilter != '3') {
      state.isFiltered = true;
    }

    if (state.startDate != null && state.endDate != null) {
      state.date =
          "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }
    AppLogger.i('Apply Filter');
    state.isLoading = true;
    count();
    state.pagingController.refresh();
    update();
  }

  Future<void> count() async {
    var token = await storageSecure.read(key: 'token');
    network.base.options.headers['Authorization'] = 'Bearer $token';
    AppLogger.i('start date: ${state.startDate}');
    AppLogger.i('end date: ${state.endDate}');
    var param = CountQueryModel(
      between: [
        {
          "awbDate": [
            state.startDate ?? '',
            state.endDate ?? '',
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

      state.countList = responseCount.data['data'];
      AppLogger.d('responseCount.data: ${state.countList}');
      toastification.show(
        title: const Text('Count Success'),
        description: RichText(
            text: const TextSpan(
          text: 'Berhasil mengambil data.',
          style: TextStyle(color: Colors.black),
        )),
        type: ToastificationType.success,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topRight,
        style: ToastificationStyle.flatColored,
      );

      update();
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
      toastification.show(
        title: const Text('Count Error'),
        description: RichText(
            text: const TextSpan(
          text: 'Gagal mengambil data.',
          style: TextStyle(color: Colors.black),
        )),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
        alignment: Alignment.topRight,
        style: ToastificationStyle.flatColored,
      );
    } finally {
      state.isLoadCount = true;
      state.isLoading = false;
      update();
    }
  }
}
