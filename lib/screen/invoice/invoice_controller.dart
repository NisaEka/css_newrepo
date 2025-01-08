import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/invoice/invoice_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:get/get.dart';

class InvoiceController extends BaseController {
  final state = InvoiceState();
  num _invoiceCount = 0;

  num get invoiceCount => _invoiceCount;

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
      state.isLoading = true;
      _queryParamModel.setPage(page);
      final response = await invoiceRepository.getInvoices(_queryParamModel);

      final payload = response.data ?? List.empty();
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;

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
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

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
    state.isFiltered = true;
    if (state.startDate != null && state.endDate != null) {
      state.transDate = [
        {
          "invoiceDate": ["${state.startDate}", "${state.endDate}"]
        }
      ];
    }
    if (state.dateFilter == '0') {
      resetFilter();
    }

    _queryParamModel.setBetween(state.transDate);
    requireRetry();
    update();
  }
}
