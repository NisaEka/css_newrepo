import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AggregasiMinusController extends BaseController {

  final startDateField = TextEditingController();
  final endDateField = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<AggregationMinusModel> aggregations = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    showLoadingIndicator = true;
    update();
    try {
      await aggregation.getAggregationMinus()
          .then((response) async {
            if (response.code == 200) {
              aggregations.addAll(response.payload ?? List.empty());
              showMainContent = true;
              update();
            } else {
              showErrorContent = true;
              update();
            }
          });
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
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