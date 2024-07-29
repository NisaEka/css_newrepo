import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
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
  String? selectedPetugasEntry;
  String? transType;
  String? date;
  String dateFilter = '0';

  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<String> listOfficerEntry = [];
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

    try {
      await profil.getBasicProfil().then((value) async => basic = value.payload);

      if (basic?.userType == "PEMILIK") {
        await transaction.getTransOfficer().then((value) {
          listOfficerEntry.addAll(value.payload ?? []);
          update();
        });
      }
    } catch (e) {
      e.printError();
    }

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
        selectedPetugasEntry ?? '',
        'Total Kiriman',
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
    startDate = null;
    endDate = null;
    startDateField.clear();
    endDateField.clear();
    selectedPetugasEntry = basic?.userType == "PEMILIK" ? null : basic?.name;
    selectedStatusKiriman = null;
    isFiltered = false;
    searchField.clear();
    date = null;
    dateFilter = "0";

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
    if (startDate != null || endDate != null || selectedPetugasEntry != null || selectedStatusKiriman != null) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
        date.printInfo(info: "date filter");
        date.printInfo(info: "${startDate} - ${endDate}");
      }
      update();
      pagingController.refresh();
      update();
      Get.back();
    }
  }
}
