import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LaporankuController extends BaseController {
  final searchField = TextEditingController();
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final PagingController<int, dynamic> pagingController = PagingController(firstPageKey: 1);

  bool isFiltered = false;
  DateTime? startDate;
  DateTime? endDate;
  String? date;
  String? status;
  int selectedStatus = 0;
  int total = 0;
  int onProcess = 0;
  int closed = 0;
  String dateFilter = '0';

  Future<DateTime?> selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: AppConst.isLightTheme(context)
                ? const ColorScheme.light().copyWith(primary: blueJNE)
                : const ColorScheme.dark().copyWith(primary: redJNE),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: redJNE, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
  }

  void selectDateFilter(int filter) {
    dateFilter = filter.toString();
    update();
    if (filter == 0 || filter == 4) {
      startDate = null;
      endDate = null;
      startDateField.text = '-';
      endDateField.text = '-';
    } else if (filter == 1) {
      startDate = DateTime.now().subtract(const Duration(days: 30));
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    } else if (filter == 2) {
      startDate = DateTime.now().subtract(const Duration(days: 7));
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    } else if (filter == 3) {
      startDate = DateTime.now();
      endDate = DateTime.now();
      startDateField.text = startDate.toString().toShortDateFormat();
      endDateField.text = endDate.toString().toShortDateFormat();
    }

    update();
  }

  applyFilter() {
    if (startDate != null || endDate != null) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        date = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
      }
      update();
      pagingController.refresh();
      update();
      Get.back();
    }
  }

  void resetFilter() {
    startDate = null;
    endDate = null;
    startDateField.clear();
    endDateField.clear();
    isFiltered = false;
    searchField.clear();
    date = null;

    pagingController.refresh();
    update();
    Get.back();
  }
}
