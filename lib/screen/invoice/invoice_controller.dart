import 'dart:convert';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/advance_filter_model.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends BaseController {
  final AdvanceFilterModel _advanceFilterModel = AdvanceFilterModel();

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
    Future.wait([_getInvoiceCount()]);
    pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });
  }

  void applyFilterDate() {
    bool startDateAvailable = selectedDateStart != null;
    bool endDateAvailable = selectedDateEnd != null;

    switch (selectedFilterDate) {
      case RequestPickupDateEnum.custom:
        if (startDateAvailable && endDateAvailable) {
          _advanceFilterModel.setDate(
              '${selectedDateStart?.millisecondsSinceEpoch}-${selectedDateEnd?.millisecondsSinceEpoch}');
          filterDateText = '$selectedDateStartText - $selectedDateEndText';
        } else if (startDateAvailable) {
          _advanceFilterModel
              .setDate('${selectedDateStart?.millisecondsSinceEpoch}');
          filterDateText = selectedDateStartText;
        } else if (endDateAvailable) {
          _advanceFilterModel
              .setDate('${selectedDateEnd?.millisecondsSinceEpoch}');
          filterDateText = selectedDateEndText;
        }
        break;
      case RequestPickupDateEnum.all:
        _advanceFilterModel.setDate('');
        break;
      case RequestPickupDateEnum.oneMonth:
        final currentDateTime = DateTime.now();
        final oneMonthAgo = currentDateTime.subtract(const Duration(days: 30));
        _advanceFilterModel.setDate(
            '${oneMonthAgo.millisecondsSinceEpoch}-${currentDateTime.millisecondsSinceEpoch}');
        break;
      case RequestPickupDateEnum.oneWeek:
        final currentDateTime = DateTime.now();
        final oneWeekAgo = currentDateTime.subtract(const Duration(days: 7));
        _advanceFilterModel.setDate(
            '${oneWeekAgo.millisecondsSinceEpoch}-${currentDateTime.millisecondsSinceEpoch}');
        break;
      case RequestPickupDateEnum.today:
        final currentDateTime = DateTime.now();
        final startOfDay = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);
        _advanceFilterModel.setDate('${startOfDay.millisecondsSinceEpoch}');
        break;
      default:
        _advanceFilterModel.setDate('');
        break;
    }

    requireRetry();
    update();
  }

  Future<void> _getInvoiceCount() async {
    try {
      final response =
          await invoiceRepository.getInvoiceCount(_advanceFilterModel);
      _invoiceCount = response.payload ?? 0;
      update();
    } catch (error) {
      error.printError();
    }
  }

  void _getInvoices(int page) async {
    try {
      _advanceFilterModel.setPage(page);
      final response = await invoiceRepository.getInvoices(_advanceFilterModel);

      final payload = response.payload ?? List.empty();
      final isLastPage = payload.length < _advanceFilterModel.limit;
      AppLogger.d(jsonEncode(response.toJson()));

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e, i) {
      e.printError();
      i.printError();
    }
  }

  void requireRetry() {
    // _getInvoiceCount();
    // _getInvoices(Constant.defaultPage);
    refreshInvoices();
  }

  void refreshInvoices() {
    pagingController.refresh();
  }

  void onKeywordChange(String newKeyword) {
    _advanceFilterModel.setKeyword(newKeyword);
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
}
