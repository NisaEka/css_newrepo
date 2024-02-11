import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LaporanAgregasiMinusController extends BaseController{
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;

  @override
  void onInit() {
    super.onInit();
  }

  Future<DateTime?> selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    ).then(
          (selectedDate) => showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
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
    isFiltered = false;
    update();
    Get.back();
  }

}