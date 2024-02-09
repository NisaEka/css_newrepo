import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RiwayatKirimanController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();

  int selectedKiriman = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatusKiriman;
  String? selectedPetugasEntry;

  bool isFiltered = false;

  List<String> listStatusKiriman = [
    "Masih Di Kamu",
    "Sudah Dijemput",
    "Dalam Perjalanan",
    "Sukses Diterima",
    "Sukses Dikembalikan",
  ];

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
    selectedPetugasEntry = null;
    selectedStatusKiriman = null;
    isFiltered = false;
    update();
    Get.back();
  }
}
