import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/screen/invoice/invoice_state.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends BaseController {
  final state = InvoiceState();

  // final AdvanceFilterModel _advanceFilterModel = AdvanceFilterModel();
  final QueryModel _queryParamModel = QueryModel();

  final PagingController<int, InvoiceModel> pagingController =
      PagingController(firstPageKey: Constant.defaultPage);

  final searchTextController = TextEditingController();

  num _invoiceCount = 0;

  num get invoiceCount => _invoiceCount;

  String filterDateText = Constant.allDate;

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;

  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  String selectedDateStartText = "Pilih Tanggal Awal";
  String selectedDateEndText = "Pilih Tanggal Akhir";
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });

    selectDateFilter(3);
    applyFilter();
    requireRetry();
    // applyFilter();
  }

  // void applyFilterDate() {
  //   bool startDateAvailable = selectedDateStart != null;
  //   bool endDateAvailable = selectedDateEnd != null;
  //
  //   List<Map<String, dynamic>> between = [];
  //
  //   switch (selectedFilterDate) {
  //     case RequestPickupDateEnum.custom:
  //       if (startDateAvailable && endDateAvailable) {
  //         between.add({
  //           "invoiceDate": [
  //             DateTime(selectedDateStart!.year, selectedDateStart!.month,
  //                     selectedDateStart!.day)
  //                 .toIso8601String(),
  //             DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
  //                     selectedDateEnd!.day, 23, 59, 59, 999)
  //                 .toIso8601String()
  //           ]
  //         });
  //         filterDateText = '$selectedDateStartText - $selectedDateEndText';
  //       } else if (startDateAvailable) {
  //         between.add({
  //           "invoiceDate": [
  //             DateTime(selectedDateStart!.year, selectedDateStart!.month,
  //                     selectedDateStart!.day)
  //                 .toIso8601String(),
  //             DateTime(selectedDateStart!.year, selectedDateStart!.month,
  //                     selectedDateStart!.day, 23, 59, 59, 999)
  //                 .toIso8601String()
  //           ]
  //         });
  //         filterDateText = selectedDateStartText;
  //       } else if (endDateAvailable) {
  //         between.add({
  //           "invoiceDate": [
  //             DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
  //                     selectedDateEnd!.day)
  //                 .toIso8601String(),
  //             DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
  //                     selectedDateEnd!.day, 23, 59, 59, 999)
  //                 .toIso8601String()
  //           ]
  //         });
  //         filterDateText = selectedDateEndText;
  //       }
  //       break;
  //     case RequestPickupDateEnum.all:
  //       between = [];
  //       break;
  //     case RequestPickupDateEnum.oneMonth:
  //       final currentDateTime = DateTime.now();
  //       final oneMonthAgo = currentDateTime.subtract(const Duration(days: 30));
  //       between.add({
  //         "invoiceDate": [
  //           DateTime(oneMonthAgo.year, oneMonthAgo.month, oneMonthAgo.day)
  //               .toIso8601String(),
  //           DateTime(currentDateTime.year, currentDateTime.month,
  //                   currentDateTime.day, 23, 59, 59, 999)
  //               .toIso8601String()
  //         ]
  //       });
  //       break;
  //     case RequestPickupDateEnum.oneWeek:
  //       final currentDateTime = DateTime.now();
  //       final oneWeekAgo = currentDateTime.subtract(const Duration(days: 7));
  //       between.add({
  //         "invoiceDate": [
  //           DateTime(oneWeekAgo.year, oneWeekAgo.month, oneWeekAgo.day)
  //               .toIso8601String(),
  //           DateTime(currentDateTime.year, currentDateTime.month,
  //                   currentDateTime.day, 23, 59, 59, 999)
  //               .toIso8601String()
  //         ]
  //       });
  //       break;
  //     case RequestPickupDateEnum.today:
  //       final currentDateTime = DateTime.now();
  //       final startOfDay = DateTime(
  //           currentDateTime.year, currentDateTime.month, currentDateTime.day);
  //       final endOfDay = DateTime(currentDateTime.year, currentDateTime.month,
  //           currentDateTime.day, 23, 59, 59, 999);
  //       between.add({
  //         "invoiceDate": [
  //           startOfDay.toIso8601String(),
  //           endOfDay.toIso8601String()
  //         ]
  //       });
  //       break;
  //     default:
  //       between = [];
  //       break;
  //   }
  //
  //   _queryParamModel.setBetween(between);
  //
  //   requireRetry();
  //   update();
  // }

  Future<void> _getInvoiceCount() async {
    try {
      final response =
          await invoiceRepository.getInvoiceCount(_queryParamModel);
      _invoiceCount = response.data ?? 0;
      update();
    } catch (error) {
      error.printError();
    }
  }

  void _getInvoices(int page) async {
    try {
      state.isLoading = true;
      _queryParamModel.setPage(page);
      final response = await invoiceRepository.getInvoices(_queryParamModel);

      final payload = response.data ?? List.empty();
      // final isLastPage = payload.length < (_queryParamModel.limit ?? 0);
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;
      // AppLogger.d(jsonEncode(response.toJson()));

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e, i) {
      AppLogger.e('error getInvoices $e, $i');
    } finally {
      state.isLoading = false;
      update();
    }
  }

  void requireRetry() {
    _getInvoiceCount();
    // _getInvoices(Constant.defaultPage);
    refreshInvoices();
  }

  void refreshInvoices() {
    pagingController.refresh();
  }

  void onKeywordChange(String newKeyword) {
    _queryParamModel.setSearch(newKeyword);
    requireRetry();

    if (newKeyword.isEmpty) {
      searchTextController.clear();
    }
  }

  void setSelectedFilterDate(RequestPickupDateEnum? date) {
    if (date != null) {
      selectedFilterDate = date;
      filterDateText = date.asName();
    }
  }

  void setSelectedDateStart(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateStart = dateTime;
      selectedDateStartText =
          dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  void setSelectedDateEnd(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateEnd = dateTime;
      selectedDateEndText = dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  void selectDateFilter(int filter) {
    state.dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      selectedDateStart = null;
      selectedDateEnd = null;
      state.startDateField.clear();
      state.endDateField.clear();
      // state.transDate = [];
    } else if (filter == 1) {
      selectedDateStart = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 30));
      selectedDateEnd =
          DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          selectedDateStart.toString().toLongDateTimeFormat();
      state.endDateField.text =
          selectedDateEnd.toString().toLongDateTimeFormat();
    } else if (filter == 2) {
      selectedDateStart = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 7));
      selectedDateEnd =
          DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          selectedDateStart.toString().toLongDateTimeFormat();
      state.endDateField.text =
          selectedDateEnd.toString().toLongDateTimeFormat();
    } else if (filter == 3) {
      selectedDateStart = DateTime.now().copyWith(hour: 0, minute: 0);
      selectedDateEnd =
          DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          selectedDateStart.toString().toLongDateTimeFormat();
      state.endDateField.text =
          selectedDateEnd.toString().toLongDateTimeFormat();
    }
    update();
  }

  Future<DateTime?> selectDate(BuildContext context) async {
    // Show date picker
    final DateTime? selectedDate = await showDatePicker(
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

    if (selectedDate == null || !context.mounted) return null;

    // Show time picker
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: CustomTheme().dateTimePickerTheme(context),
          child: child!,
        );
      },
    );

    if (selectedTime == null || !context.mounted) return null;

    // Combine date and time
    return DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );
  }

  void resetFilter() {
    selectedDateStart = null;
    selectedDateEnd = null;
    state.startDateField.clear();
    state.endDateField.clear();
    // state.isFiltered = false;
    state.searchField.clear();
    state.transDate = [];
    state.dateFilter = '0';
    state.pagingController.refresh();
    update();
  }

  @override
  void dispose() {
    super.dispose();
    state.pagingController.dispose();
  }

  applyFilter() {
    // if (selectedDateStart != null ||
    //     selectedDateEnd != null ||
    //     state.selectedPetugasEntry != null ||
    //     state.selectedStatusKiriman != null) {
    state.isFiltered = true;
    if (selectedDateStart != null && selectedDateEnd != null) {
      state.transDate = [
        {
          "invoiceDate": ["$selectedDateStart", "$selectedDateEnd"]
        }
      ];
      // "${selectedDateStart?.millisecondsSinceEpoch ?? ''}-${selectedDateEnd?.millisecondsSinceEpoch ?? ''}";
    }
    if (state.dateFilter == '0') {
      resetFilter();
    }

    _queryParamModel.setBetween(state.transDate);
    requireRetry();
    update();
  }
}
