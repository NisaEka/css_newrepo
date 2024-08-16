import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, PantauPaketmuModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatusKiriman;
  String? selectedPetugasEntry = 'SEMUA';
  String? selectedStatusPrint = "SEMUA";
  String? selectedTipeKiriman = "SEMUA";
  String? date;
  String dateFilter = '3';
  int tipeKiriman = 0;
  int total = 0;
  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;

  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<String> listOfficerEntry = [];
  List<String> listTipeKiriman = ["SEMUA", "COD", "NON COD", "COD ONGKIR"];
  List<String> listStatusPrint = ["SEMUA", "SUDAH DIPRINT", "BELUM DIPRINT"];
  List<PantauPaketmuModel> selectedTransaction = [];

  BasicProfilModel? basic;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    update();
  }

  Future<void> initData() async {
    isLoading = true;
    update();
    selectDateFilter(3);
    date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
    pagingController.refresh();

    try {
      await profil.getBasicProfil().then((value) async => basic = value.payload);

      if (basic?.userType == "PEMILIK") {
        await transaction.getTransOfficer().then((value) {
          listOfficerEntry.add('SEMUA');
          listOfficerEntry.add(basic?.name ?? '');
          listOfficerEntry.addAll(value.payload ?? []);
          update();
        });
      }

      await pantau.getPantauStatus().then((value) {
        listStatusKiriman.addAll(value.payload ?? []);
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    selectedStatusKiriman = listStatusKiriman.first;
    isLoading = false;
    update();
  }

  void selectDateFilter(int filter) {
    dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      startDate = null;
      endDate = null;
      startDateField.text = '-';
      endDateField.text = '-';
    } else if (filter == 1) {
      startDate = DateTime.now().subtract(const Duration(days: 30));
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    } else if (filter == 2) {
      startDate = DateTime.now().subtract(const Duration(days: 7));
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    } else if (filter == 3) {
      startDate = DateTime.now();
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    }

    update();
  }

  Future<void> getPantauList(int page) async {
    isLoading = true;
    try {
      final trans = await pantau.getPantauList(
        page,
        pageSize,
        date ?? '',
        searchField.text,
        selectedPetugasEntry != "SEMUA" ? (selectedPetugasEntry ?? '') : '',
        selectedStatusKiriman ?? '',
        selectedTipeKiriman ?? '',
      );

      final isLastPage = (trans.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(trans.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(trans.payload ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e, i) {
      e.printError();
      i.printError();
      pagingController.error = e;
    }

    isLoading = false;
    update();
  }

  void resetFilter() {
    selectedPetugasEntry = basic?.userType == "PEMILIK" ? null : basic?.name;
    selectedStatusKiriman = "Total Kiriman";
    selectedTipeKiriman = "SEMUA";
    tipeKiriman = 0;
    isFiltered = false;
    searchField.clear();
    dateFilter = "3";
    selectDateFilter(3);
    date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
    count();
    pagingController.refresh();
    update();
    Get.back();
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
    isFiltered = true;
    if (startDate != null && endDate != null) {
      date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
      date.printInfo(info: "date filter");
      date.printInfo(info: "$startDate - $endDate");
    }
    update();
    count();
    pagingController.refresh();

    update();
    Get.back();
  }

  Future<void> count() async {
    total = 0;
    cod = 0;
    noncod = 0;
    codOngkir = 0;
    isLoading = true;
    update();
    try {
      await pantau
          .getPantauCount(
        date ?? '',
        searchField.text,
        selectedPetugasEntry != "SEMUA" ? (selectedPetugasEntry ?? '') : '',
        selectedStatusKiriman ?? '',
      )
          .then((value) {
        total = value.payload!.total!.toInt();
        cod = value.payload!.cod!.toInt();
        noncod = value.payload!.nonCod!.toInt();
        codOngkir = value.payload!.codOngkir!.toInt();
        update();
      });
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }


}
