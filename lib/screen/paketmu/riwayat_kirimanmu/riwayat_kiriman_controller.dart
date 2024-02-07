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
    startDateField.text = DateTime.now().toString().toDateTimeFormat();
  }

  Future<void> selectDate(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
      ),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    ).then((selectedTime) {
      // Handle the selected date and time here.
      if (selectedTime != null) {
        // DateTime selectedDateTime = DateTime(
        //   startDate.year,
        //   startDate.month,
        //   startDate.day,
        //   selectedTime.hour,
        //   selectedTime.minute,
        // );
        // print(selectedDateTime); // You can use the selectedDateTime as needed.
      }
    });
    if (picked != null) print({picked.start.toString() + ' - ' + picked.end.toString()});
  }
}
