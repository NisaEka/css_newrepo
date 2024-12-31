import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/invoice/invoice_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:get/get.dart';

class InvoiceController extends BaseController {
  final state = InvoiceState();
  num _invoiceCount = 0;

  num get invoiceCount => _invoiceCount;

  // final AdvanceFilterModel _advanceFilterModel = AdvanceFilterModel();
  final QueryModel _queryParamModel = QueryModel();

  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    state.pagingController.addPageRequestListener((pageKey) {
      _getInvoices(pageKey);
    });

    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

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
        state.pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(payload, nextPageKey);
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
    state.pagingController.refresh();
  }

  void onKeywordChange(String newKeyword) {
    _queryParamModel.setSearch(newKeyword);
    requireRetry();

    if (newKeyword.isEmpty) {
      state.searchTextController.clear();
    }
  }

  void resetFilter() {
    // selectedDateStart = null;
    // selectedDateEnd = null;
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    // state.isFiltered = false;
    state.searchField.clear();
    state.transDate = [];
    state.dateFilter = '3';
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
    if (state.startDate != null && state.endDate != null) {
      state.transDate = [
        {
          "invoiceDate": ["${state.startDate}", "${state.endDate}"]
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
