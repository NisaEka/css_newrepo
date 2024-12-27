import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';

class LaporankuController extends BaseController {
  final state = LaporankuState();

  @override
  void onInit() {
    super.onInit();

    Future.wait([initData()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getTicketList(pageKey);
    });
  }

  Future<void> initData() async {
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    update();
    applyFilter();
    countReports();
  }

  Future<void> countReports() async {
    try {
      List<Map<String, dynamic>> where = [];
      List<Map<String, dynamic>> between = [];

      if (state.status != "") {
        where.add({"status": state.status});
      }

      if (state.date.isNotEmpty) {
        between.add({"createdDate": state.date});
      }

      await laporanku
          .getTicketSummary(QueryModel(
        where: where,
        between: between,
        search: state.searchField.text,
      ))
          .then((value) {
        state.total = value.data?.all?.toInt() ?? 0;
        state.onProcess = value.data?.onProcess?.toInt() ?? 0;
        state.closed = value.data?.finished?.toInt() ?? 0;
        state.waiting = value.data?.waiting?.toInt() ?? 0;
        update();
      });
    } catch (e) {
      AppLogger.e('error countReports $e');
    }
  }

  Future<void> getTicketList(int page) async {
    state.isLoading = true;
    try {
      List<Map<String, dynamic>> where = [];
      List<Map<String, dynamic>> between = [];
      List<Map<String, dynamic>> sort = [
        {"createdDate": "desc"}
      ];

      if (state.status != "") {
        where.add({"status": state.status});
      }

      if (state.date.isNotEmpty) {
        between.add({"createdDate": state.date});
      }

      final tickets = await laporanku.getTickets(QueryModel(
        table: true,
        relation: true,
        page: page,
        limit: LaporankuState.pageSize,
        where: where,
        between: between,
        sort: sort,
        search: state.searchField.text,
      ));

      final isLastPage = (tickets.data?.length ?? 0) < LaporankuState.pageSize;
      if (isLastPage) {
        state.pagingController.appendLastPage(tickets.data ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(tickets.data ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e) {
      AppLogger.e('error getTicketList $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  applyFilter() {
    if (state.startDate != null ||
        state.endDate != null ||
        state.status != "") {
      state.isFiltered = true;
      if (state.startDate != null && state.endDate != null) {
        state.date = [
          DateTime(state.startDate!.year, state.startDate!.month,
                  state.startDate!.day)
              .toIso8601String(),
          DateTime(state.endDate!.year, state.endDate!.month,
                  state.endDate!.day, 23, 59, 59, 999)
              .toIso8601String()
        ];
      }
      state.pagingController.refresh();
      countReports();
    } else {
      state.isFiltered = false;
      resetFilter();
    }

    update();
  }

  void resetFilter() {
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    state.startDateField.text =
        state.startDate.toString().toShortDateTimeFormat();
    state.endDateField.text = state.endDate.toString().toShortDateTimeFormat();
    // state.startDateField.clear();
    // state.endDateField.clear();
    state.isFiltered = false;
    state.searchField.clear();
    state.date = [];
    state.dateFilter = '0';
    state.status = "";

    state.pagingController.refresh();
    countReports();
    update();
  }
}
