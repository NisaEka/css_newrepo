import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PembayaranAggergasiController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, AggregationModel> pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 10;

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  String? transDate;
  String dateFilter = '0';
  int? aggTotal;

  List<Account> accountList = [];
  List<Account> selectedAccount = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getAggregation(pageKey);
    });
    update();
  }

  Future<void> getAggregation(int page) async {
    isLoading = true;

    try {
      final agg = await aggregation.getAggregationReport(
        page,
        pageSize,
        searchField.text,
        transDate ?? '',
        selectedAccount,
      );

      final isLastPage = (agg.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(agg.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(agg.payload ?? [], nextPageKey);
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

  Future<void> initData() async {
    accountList = [];
    selectedAccount = [];
    try {
      await master.getAccounts().then(
            (value) => accountList.addAll(value.data ?? []),
          );
      update();
      selectedAccount.addAll(accountList);

      await aggregation.getAggregationTotal().then((value) {
        aggTotal = value.payload?.total?.toInt() ?? 0;
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }

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
    );
  }

  void onSearch(String value) {
    searchField.text = value;
    update();
    pagingController.refresh();
  }

  void onSearchClear() {
    searchField.clear();
    pagingController.refresh();
  }

  void applyFilter() {
    if (startDate != null ||
        endDate != null ||
        !accountList.equals(selectedAccount)) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        transDate =
            "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
      }
      update();
      pagingController.refresh();
      Get.back();
    }
  }

  void resetFilter() {
    // if (!isFiltered) {
    startDate = null;
    endDate = null;
    startDateField.clear();
    endDateField.clear();
    isFiltered = false;
    selectedAccount = [];
    selectedAccount.addAll(accountList);
    transDate = '';
    dateFilter = '0';

    update();

    pagingController.refresh();
    Get.back();
    // }
  }

  void onSelectAccount(Account e) {
    if (selectedAccount.where((accounts) => accounts == e).isNotEmpty) {
      selectedAccount.removeWhere((accounts) => accounts == e);
    } else {
      selectedAccount.add(e);
    }
    update();
  }

  void onSelectStartDate(DateTime value) {
    startDate = value;
    startDateField.text = value.toString().toShortDateFormat();
    endDate = DateTime.now();
    endDateField.text = endDate.toString().toShortDateFormat();

    update();
  }

  void onSelectEndDate(DateTime value) {
    endDate = value;
    endDateField.text = value.toString().toShortDateFormat();
    update();
  }
}
