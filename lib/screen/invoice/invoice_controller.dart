import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceController extends BaseController {
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
    Future.wait([_getInvoiceCount()]);
    pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });
  }

  void applyFilterDate() {
    bool startDateAvailable = selectedDateStart != null;
    bool endDateAvailable = selectedDateEnd != null;

    List<Map<String, dynamic>> between = [];

    switch (selectedFilterDate) {
      case RequestPickupDateEnum.custom:
        if (startDateAvailable && endDateAvailable) {
          between.add({
            "invoiceDate": [
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = '$selectedDateStartText - $selectedDateEndText';
        } else if (startDateAvailable) {
          between.add({
            "invoiceDate": [
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = selectedDateStartText;
        } else if (endDateAvailable) {
          between.add({
            "invoiceDate": [
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day)
                  .toIso8601String(),
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = selectedDateEndText;
        }
        break;
      case RequestPickupDateEnum.all:
        between = [];
        break;
      case RequestPickupDateEnum.oneMonth:
        final currentDateTime = DateTime.now();
        final oneMonthAgo = currentDateTime.subtract(const Duration(days: 30));
        between.add({
          "invoiceDate": [
            DateTime(oneMonthAgo.year, oneMonthAgo.month, oneMonthAgo.day)
                .toIso8601String(),
            DateTime(currentDateTime.year, currentDateTime.month,
                    currentDateTime.day, 23, 59, 59, 999)
                .toIso8601String()
          ]
        });
        break;
      case RequestPickupDateEnum.oneWeek:
        final currentDateTime = DateTime.now();
        final oneWeekAgo = currentDateTime.subtract(const Duration(days: 7));
        between.add({
          "invoiceDate": [
            DateTime(oneWeekAgo.year, oneWeekAgo.month, oneWeekAgo.day)
                .toIso8601String(),
            DateTime(currentDateTime.year, currentDateTime.month,
                    currentDateTime.day, 23, 59, 59, 999)
                .toIso8601String()
          ]
        });
        break;
      case RequestPickupDateEnum.today:
        final currentDateTime = DateTime.now();
        final startOfDay = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);
        final endOfDay = DateTime(currentDateTime.year, currentDateTime.month,
            currentDateTime.day, 23, 59, 59, 999);
        between.add({
          "invoiceDate": [
            startOfDay.toIso8601String(),
            endOfDay.toIso8601String()
          ]
        });
        break;
      default:
        between = [];
        break;
    }

    _queryParamModel.setBetween(between);

    requireRetry();
    update();
  }

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
}
