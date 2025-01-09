import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PembayaranAggergasiController extends BaseController {
  final searchField = TextEditingController();
  final PagingController<int, AggregationModel> pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 10;

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = true;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> transDate = [];
  String dateFilter = '3';
  int? aggTotal;

  List<Account> accountList = [];
  List<Account> selectedAccount = [];

  @override
  void onInit() {
    super.onInit();

    startDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);
    endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter();

    Future.wait([initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getAggregation(pageKey);
    });
    fetchAggregationTotal();
    update();
  }

  Future<void> getAggregation(int page) async {
    isLoading = true;

    try {
      List<Map<String, dynamic>> isIn = [];
      List<Map<String, dynamic>> between = [];

      if (selectedAccount.isNotEmpty) {
        isIn.add({
          "mpayWdrGrpPayCode":
              selectedAccount.map((e) => e.accountNumber).toList()
        });
      }

      if (transDate.isNotEmpty) {
        between.add({"mpayWdrGrpPayDatePaid": transDate});
      }

      final agg = await aggregation.getAggregationReport(QueryModel(
        page: page,
        limit: pageSize,
        search: searchField.text,
        inValues: isIn,
        between: between,
      ));

      final isLastPage = agg.meta!.currentPage == agg.meta!.lastPage;
      if (isLastPage) {
        pagingController.appendLastPage(agg.data ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(agg.data ?? [], nextPageKey);
      }
    } catch (e, i) {
      AppLogger.e('error getAggregation $e, $i');
      pagingController.error = e;
    }

    isLoading = false;
    update();
  }

  Future<void> fetchAggregationTotal() async {
    try {
      List<Map<String, dynamic>> isIn = [];
      List<Map<String, dynamic>> between = [];

      if (selectedAccount.isNotEmpty) {
        isIn.add({
          "mpayWdrGrpPayCode":
              selectedAccount.map((e) => e.accountNumber).toList()
        });
      }

      if (transDate.isNotEmpty) {
        between.add({"mpayWdrGrpPayDatePaid": transDate});
      }

      final total = await aggregation.getAggregationTotal(QueryModel(
        search: searchField.text,
        between: between,
        inValues: isIn,
      ));

      aggTotal = total.data?.total?.toInt() ?? 0;
      update();
    } catch (e, i) {
      AppLogger.e('error fetchAggregationTotal $e, $i');
    }
  }

  Future<void> initData() async {
    accountList = [];
    selectedAccount = [];
    try {
      await master
          .getAccounts(QueryModel(limit: 0, sort: [
            {"accountNumber": "asc"}
          ]))
          .then(
            (value) => accountList.addAll(value.data ?? []),
          );
      update();
      selectedAccount.addAll(accountList);
    } catch (e, i) {
      AppLogger.e('error initData pembayaran aggregasi $e, $i');
    }

    update();
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
        transDate = [
          DateTime(startDate!.year, startDate!.month, startDate!.day)
              .toIso8601String(),
          DateTime(endDate!.year, endDate!.month, endDate!.day, 23, 59, 59, 999)
              .toIso8601String()
        ];
      }
      update();
      pagingController.refresh();
      fetchAggregationTotal();
    }
  }

  void resetFilter() {
    startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    isFiltered = false;
    selectedAccount = [];
    selectedAccount.addAll(accountList);
    transDate = [
      DateTime(startDate!.year, startDate!.month, startDate!.day)
          .toIso8601String(),
      DateTime(endDate!.year, endDate!.month, endDate!.day, 23, 59, 59, 999)
          .toIso8601String()
    ];
    dateFilter = '3';

    update();

    pagingController.refresh();
    fetchAggregationTotal();
  }

  void onSelectAccount(Account e) {
    if (selectedAccount.where((accounts) => accounts == e).isNotEmpty) {
      selectedAccount.removeWhere((accounts) => accounts == e);
    } else {
      selectedAccount.add(e);
    }
    update();
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}
