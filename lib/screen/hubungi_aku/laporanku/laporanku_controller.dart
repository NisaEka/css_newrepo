import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    // selectDateFilter(3);
    // applyFilter();
    countReports();
  }

  Future<void> countReports() async {
    try {
      await laporanku
          .getTicketSummary(
        state.status ?? '',
        state.date ?? '',
        state.searchField.text,
      )
          .then((value) {
        state.total = value.payload?.all?.toInt() ?? 0;
        state.onProcess = value.payload?.onProcess?.toInt() ?? 0;
        state.closed = value.payload?.finished?.toInt() ?? 0;
        state.waiting = value.payload?.waiting?.toInt() ?? 0;
        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> getTicketList(int page) async {
    state.isLoading = true;
    try {
      final tickets = await laporanku.getTickets(
        page,
        LaporankuState.pageSize,
        state.status ?? '',
        state.date ?? '',
        state.searchField.text,
      );

      final isLastPage = (tickets.payload?.length ?? 0) < LaporankuState.pageSize;
      if (isLastPage) {
        state.pagingController.appendLastPage(tickets.payload ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(tickets.payload ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e) {
      e.printError();
      state.pagingController.error = e;
    }

    state.isLoading = false;
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

  void selectDateFilter(int filter) {
    state.dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      state.startDate = null;
      state.endDate = null;
      state.startDateField.text = '-';
      state.endDateField.text = '-';
    } else if (filter == 1) {
      state.startDate = DateTime.now().subtract(const Duration(days: 30));
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 2) {
      state.startDate = DateTime.now().subtract(const Duration(days: 7));
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 3) {
      state.startDate = DateTime.now();
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    }

    update();
  }

  applyFilter() {
    if (state.startDate != null || state.endDate != null || state.status != "") {
      state.isFiltered = true;
      if (state.startDate != null && state.endDate != null) {
        state.date = "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
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
    state.startDate = null;
    state.endDate = null;
    state.startDateField.clear();
    state.endDateField.clear();
    state.isFiltered = false;
    state.searchField.clear();
    state.date = null;
    state.dateFilter = '0';
    state.status = "";

    state.pagingController.refresh();
    countReports();
    update();
  }
}
