import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/cupertino.dart';
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
  String? transDate;
  String? status;
  int selectedStatus = 0;
  int total = 0;
  int onProcess = 0;
  int closed = 0;


  Future<DateTime?> selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: AppConst.isLightTheme(context) ? const ColorScheme.light().copyWith(primary: blueJNE) : const ColorScheme.dark().copyWith(primary: redJNE),
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

  applyFilter() {
    if (startDate != null || endDate != null) {
      isFiltered = true;
      if (startDate != null && endDate != null) {
        transDate = "${startDate?.millisecondsSinceEpoch ?? ''}-${endDate?.millisecondsSinceEpoch ?? ''}";
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
    transDate = null;

    pagingController.refresh();
    update();
    Get.back();
  }
}
