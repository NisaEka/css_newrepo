import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_state.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKirimanController extends BaseController {
  final state = RiwayatKirimanState();
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getTransaction(pageKey);
    });
    // categoryList();
    selectDateFilter(3);
    applyFilter();
  }

  void cekAllowance() {
    if (state.basic?.userType != "PEMILIK") {
      state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      state.listOfficerEntry.add(PetugasModel(name: state.basic?.name ?? ''));
    }
    update();
    state.pagingController.refresh();
    transactionCount();
  }

  Future<void> transactionCount() async {
    try {
      await transaction
          .getTransactionCount(
        state.transType ?? '',
        state.transDate ?? '[]',
        state.selectedStatusKiriman ?? '',
        state.searchField.text,
        state.selectedPetugasEntry?.name ?? '',
      )
          .then((value) {
        state.total = value.data?.total?.toInt() ?? 0;
        state.cod = value.data?.cod?.toInt() ?? 0;
        state.noncod = value.data?.nonCod?.toInt() ?? 0;
        state.codOngkir = value.data?.codOngkir?.toInt() ?? 0;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error transactionCount $e, $i');
    }
  }

  Future<void> initData() async {
    // transactionList = [];
    state.selectedTransaction = [];
    state.listStatusKiriman = [];
    try {
      await profil
          .getBasicProfil()
          .then((value) async => state.basic = value.data?.user);

      await transaction.getTransactionStatus().then((value) {
        state.listStatusKiriman.addAll(value.data ?? []);
        update();
      });

      if (state.basic?.userType == "PEMILIK") {
        await transaction.getTransOfficer().then((value) {
          state.listOfficerEntry.addAll(value.data ?? []);
          update();
        });
      }

      update();
    } catch (e) {
      AppLogger.e('error initData riwayat kiriman $e');
    }

    cekAllowance();
  }

  Future<void> getTransaction(int page) async {
    state.isLoading = true;
    try {
      final trans = await transaction.getAllTransaction(
        page,
        pageSize,
        state.transType ?? '',
        state.transDate ?? '[]',
        state.selectedStatusKiriman ?? '',
        state.searchField.text,
        state.selectedPetugasEntry?.name ?? '',
      );

      final isLastPage =
          (trans.meta?.currentPage ?? 0) == (trans.meta?.lastPage ?? 0);
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        // transactionList.addAll(state.pagingController.itemList ?? []);
      }
    } catch (e) {
      AppLogger.e('error getTransaction $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  void selectDateFilter(int filter) {
    state.dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      state.startDate = null;
      state.endDate = null;
      state.startDateField.clear();
      state.endDateField.clear();
      state.transDate = '[]';
    } else if (filter == 1) {
      state.startDate = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 30));
      state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          state.startDate.toString().toLongDateTimeFormat();
      state.endDateField.text = state.endDate.toString().toLongDateTimeFormat();
    } else if (filter == 2) {
      state.startDate = DateTime.now()
          .copyWith(hour: 0, minute: 0)
          .subtract(const Duration(days: 7));
      state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          state.startDate.toString().toLongDateTimeFormat();
      state.endDateField.text = state.endDate.toString().toLongDateTimeFormat();
    } else if (filter == 3) {
      state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
      state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
      state.startDateField.text =
          state.startDate.toString().toLongDateTimeFormat();
      state.endDateField.text = state.endDate.toString().toLongDateTimeFormat();
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
    state.startDate = null;
    state.endDate = null;
    state.startDateField.clear();
    state.endDateField.clear();
    state.selectedPetugasEntry = null;
    state.selectedStatusKiriman = null;
    // state.isFiltered = false;
    state.searchField.clear();
    state.transDate = '[]';
    state.dateFilter = '0';
    state.pagingController.refresh();
    update();
    transactionCount();
  }

  void selectAll(bool value) {
    state.isSelectAll = value;
    // state.selectedTransaction = value ? transactionList : [];
    state.selectedTransaction =
        value ? state.pagingController.itemList ?? [] : [];
    update();
    state.selectedTransaction.isEmpty ? state.isSelect = false : null;
    update();
  }

  void select(TransactionModel item) {
    state.selectedTransaction.add(item);
    state.isSelect = true;
    update();
  }

  void unselect(TransactionModel item) {
    if (state.isSelect) {
      if (state.selectedTransaction.where((e) => e == item).isNotEmpty) {
        state.selectedTransaction.removeWhere((e) => e == item);
        update();
        if (state.selectedTransaction.isEmpty) {
          state.isSelect = false;
        }
      } else {
        state.selectedTransaction.add(item);
      }
      update();
      // state.selectedTransaction.length == transactionList.length ? state.isSelectAll = true : state.isSelectAll = false;
      state.selectedTransaction.length ==
              state.pagingController.itemList?.length
          ? state.isSelectAll = true
          : state.isSelectAll = false;
    } else {
      Get.to(const DetailTransactionScreen(), arguments: {
        'awb': item.awb,
        'data': item,
      })?.then((_) => initData());
    }
  }

  Future<void> delete(TransactionModel item) async {
    try {
      await transaction.deleteTransaction(item.awb.toString()).then((value) {
        if (value.code == 400) {
          AppSnackBar.error(value.message!.tr);
        } else {
          state.pagingController.refresh();
          initData();
          update();
        }
      });
    } catch (e) {
      AppLogger.e('error delete transaction $e');
      AppSnackBar.error('Bad Request'.tr);
    }

    update();
  }

  @override
  void dispose() {
    super.dispose();
    state.pagingController.dispose();
  }

  applyFilter() {
    // if (state.startDate != null ||
    //     state.endDate != null ||
    //     state.selectedPetugasEntry != null ||
    //     state.selectedStatusKiriman != null) {
    state.isFiltered = true;
    if (state.startDate != null && state.endDate != null) {
      state.transDate =
          '[{"createdDateSearch":["${state.startDate}","${state.endDate}"]}]';
      // "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
    }
    update();
    transactionCount();
    state.pagingController.refresh();
    update();
    if (state.dateFilter == '0') {
      resetFilter();
    }
    // } else {
    //   resetFilter();
    // }
  }
}
