import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_riwayat_kiriman_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RiwayatKirimanController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, TransactionModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  int selectedKiriman = 0;
  int total = 0;
  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatusKiriman;
  String? selectedPetugasEntry;
  String? transType;
  String? transDate;

  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<String> listOfficerEntry = [];
  List<TransactionModel> selectedTransaction = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([transactionCount(), initData()]);
    pagingController.addPageRequestListener((pageKey) {
      getTransaction(pageKey);
    });
    // categoryList();
    update();
  }

  Future<void> transactionCount() async {
    try {
      await transaction
          .getTransactionCount(
        transType ?? '',
        transDate ?? '',
        selectedStatusKiriman ?? '',
        searchField.text,
        selectedPetugasEntry ?? '',
      )
          .then((value) {
        total = value.payload?.total?.toInt() ?? 0;
        cod = value.payload?.cod?.toInt() ?? 0;
        noncod = value.payload?.nonCod?.toInt() ?? 0;
        codOngkir = value.payload?.codOngkir?.toInt() ?? 0;
        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> initData() async {
    // transactionList = [];
    selectedTransaction = [];
    listStatusKiriman = [];
    try {
      await transaction.getTransactionStatus().then((value) {
        listStatusKiriman.addAll(value.payload ?? []);
        update();
      });

      await transaction.getTransOfficer().then((value) {
        listOfficerEntry.addAll(value.payload ?? []);
        update();
      });

      update();
    } catch (e) {
      e.printError();
    }
  }

  Future<void> getTransaction(int page) async {
    isLoading = true;
    try {
      final trans = await transaction.getTransaction(
        page,
        pageSize,
        transType ?? '',
        transDate ?? '',
        selectedStatusKiriman ?? '',
        searchField.text,
        selectedPetugasEntry ?? '',
      );

      final isLastPage = (trans.payload?.length ?? 0) < pageSize;
      if (isLastPage) {
        pagingController.appendLastPage(trans.payload ?? []);
        // transactionList.addAll(pagingController.itemList ?? []);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(trans.payload ?? [], nextPageKey);
        // transactionList.addAll(pagingController.itemList ?? []);
      }
    } catch (e) {
      e.printError();
      pagingController.error = e;
    }

    isLoading = false;
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

  void resetFilter() {
    startDate = null;
    endDate = null;
    startDateField.clear();
    endDateField.clear();
    selectedPetugasEntry = null;
    selectedStatusKiriman = null;
    isFiltered = false;
    searchField.clear();
    transDate = null;

    pagingController.refresh();
    update();
    Get.back();
  }

  void selectAll(bool value) {
    isSelectAll = value;
    // selectedTransaction = value ? transactionList : [];
    selectedTransaction = value ? pagingController.itemList ?? [] : [];
    update();
    selectedTransaction.isEmpty ? isSelect = false : null;
    update();
  }

  void select(TransactionModel item) {
    selectedTransaction.add(item);
    isSelect = true;
    update();
  }

  void unselect(TransactionModel item) {
    if (isSelect) {
      if (selectedTransaction.where((e) => e == item).isNotEmpty) {
        selectedTransaction.removeWhere((e) => e == item);
        update();
        if (selectedTransaction.isEmpty) {
          isSelect = false;
        }
      } else {
        selectedTransaction.add(item);
      }
      update();
      // selectedTransaction.length == transactionList.length ? isSelectAll = true : isSelectAll = false;
      selectedTransaction.length == pagingController.itemList?.length ? isSelectAll = true : isSelectAll = false;
    } else {
      Get.to(const DetailRiwayatKirimanScreen(), arguments: {
        'awb': item.awb,
      });
    }
  }

  Future<void> delete(TransactionModel item) async {
    try {
      await transaction.deleteTransaction(item.awb.toString()).then((value) {
        if (value.code == 400) {
          Get.showSnackbar(
            GetSnackBar(
              icon: const Icon(
                Icons.warning,
                color: whiteColor,
              ),
              message: value.message?.tr,
              isDismissible: true,
              duration: const Duration(seconds: 3),
              backgroundColor: errorColor,
            ),
          );
        } else {
          pagingController.refresh();
          initData();
          update();
        }
      });
    } catch (e) {
      e.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.warning,
            color: whiteColor,
          ),
          message: 'Bad Request'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
    }

    update();
  }

  @override
  void dispose() {
    super.dispose();
    pagingController.dispose();
  }
}
