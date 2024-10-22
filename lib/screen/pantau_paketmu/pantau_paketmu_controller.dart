import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauPaketmuController extends BaseController {
  final state = PantauPaketmuState();
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    selectDateFilter(3);
    Future.wait([initData(), loadPantauCountList()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getPantauList(pageKey);
    });
    update();
  }

  Future<void> loadPantauCountList() async {
    state.pantauCountList.clear();
    try {
      transaction.postTransactionDashboard('1722445200000 - 1725814800000', '').then(
            (value) {
          state.pantauCountList.addAll(value.payload ?? []);
        },
      );
    } catch (e) {
      e.printError();
    }

    update();
  }

  Future<void> initData() async {
    state.isLoading = true;
    update();
    // selectDateFilter(3);
    // state.date = "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
    // update();
    // state.pagingController.refresh();

    try {
      await profil.getBasicProfil().then((value) async => state.basic = value.data?.user);

      if (state.basic?.userType == "PEMILIK") {
        await transaction.getTransOfficer().then((value) {
          state.listOfficerEntry.add('SEMUA');
          state.listOfficerEntry.add(state.basic?.name ?? '');
          state.listOfficerEntry.addAll(value.payload ?? []);
          update();
        });
      }

      await pantau.getPantauStatus().then((value) {
        state.listStatusKiriman.addAll(value.payload ?? []);
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    state.selectedStatusKiriman = state.listStatusKiriman.first;
    state.isLoading = false;
    update();
    applyFilter();
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
      state.startDate = state.nowDay.subtract(const Duration(days: 30));
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 2) {
      state.startDate = state.nowDay.subtract(const Duration(days: 7));
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    } else if (filter == 3) {
      state.startDate = state.nowDay;
      state.endDate = DateTime.now();
      state.startDateField.text = state.startDate.toString().toShortDateFormat();
      state.endDateField.text = state.endDate.toString().toShortDateFormat();
    }

    update();
  }

  Future<void> getPantauList(int page) async {
    state.isLoading = true;
    try {
      final trans = await pantau.getPantauList(
        page,
        pageSize,
        state.date ?? '',
        state.searchField.text,
        state.selectedPetugasEntry != "SEMUA" ? (state.selectedPetugasEntry ?? '') : '',
        state.selectedStatusKiriman ?? '',
        state.selectedTipeKiriman ?? '',
      );

      final isLastPage = (trans.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.payload ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.payload ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e, i) {
      e.printError();
      i.printError();
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  void resetFilter() {
    state.selectedPetugasEntry = state.basic?.userType == "PEMILIK" ? null : state.basic?.name;
    state.selectedStatusKiriman = "Total Kiriman";
    state.selectedTipeKiriman = "SEMUA";
    state.tipeKiriman = 0;
    state.isFiltered = false;
    state.searchField.clear();
    state.dateFilter = "3";
    selectDateFilter(3);
    state.date = "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
    count();
    state.pagingController.refresh();
    update();
    Get.back();
    applyFilter();
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
    ).then((selectedDate) => DateTime(
          selectedDate!.year,
          selectedDate.month,
          selectedDate.day,
          1,
          0,
        ));
  }

  applyFilter() {
    if(state.dateFilter != '3'){
      state.isFiltered = true;
    }

    if (state.startDate != null && state.endDate != null) {
      state.date = "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
      state.date.printInfo(info: "state.date filter");
      state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    }
    count();
    update();
    state.pagingController.refresh();
  }

  Future<void> count() async {
    state.total = 0;
    state.cod = 0;
    state.noncod = 0;
    state.codOngkir = 0;
    state.isLoadCount = true;
    update();
    try {
      await pantau
          .getPantauCount(
        state.date ?? '',
        state.searchField.text,
        state.selectedPetugasEntry != "SEMUA" ? (state.selectedPetugasEntry ?? '') : '',
        state.selectedStatusKiriman ?? '',
      )
          .then((value) {
state.        total = value.payload!.total!.toInt();
        state.cod = value.payload!.cod!.toInt();
        state.noncod = value.payload!.nonCod!.toInt();
        state.codOngkir = value.payload!.codOngkir!.toInt();
        update();
      });
    } catch (e,i) {
      e.printError();
      i.printError();
    }

    state.isLoadCount = false;
    update();
  }


}
