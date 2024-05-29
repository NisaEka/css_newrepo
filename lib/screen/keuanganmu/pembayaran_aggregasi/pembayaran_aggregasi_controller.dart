import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PembayaranAggergasiController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, AggregationModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  String? transDate;
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
    List<String> accountNumber = [];
    for (var e in selectedAccount) {
      accountNumber.add(e.accountNumber.toString());
    }
    update();
    try {
      final agg = await aggregation.getAggregationReport(
        page,
        pageSize,
        searchField.text,
        transDate ?? '',
        accountNumber,
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
      await transaction.getAccountNumber().then(
            (value) => accountList.addAll(value.payload ?? []),
          );
      update();
      selectedAccount.addAll(accountList);

      await aggregation.getAggregationTotal().then((value) {
        aggTotal = value.payload?.total?.toInt() ?? 0;
      });
      // print("sama ${}");
    } catch (e) {
      e.printError();
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
          data: Theme.of(context).copyWith(
            colorScheme: AppConst.isLightTheme(context) ? const ColorScheme.light() : const ColorScheme.dark(),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    ).then(
      (selectedDate) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: AppConst.isLightTheme(context) ? const ColorScheme.light() : const ColorScheme.dark(),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      ).then((selectedTime) => DateTime(
            selectedDate!.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime!.hour,
            selectedTime.minute,
          )),
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
    if (startDate != null || endDate != null || !accountList.equals(selectedAccount)) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        transDate = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
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
    startDateField.text = value.toString().toDateTimeFormat();
    endDate = value;
    endDateField.text = value.toString().toDateTimeFormat();

    update();
  }

  void onSelectEndDate(DateTime value) {
    endDate = value;
    endDateField.text = value.toString().toDateTimeFormat();
    update();
  }
}
