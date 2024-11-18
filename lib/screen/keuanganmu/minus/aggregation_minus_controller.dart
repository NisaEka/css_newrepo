import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:css_mobile/base/theme_controller.dart';

class AggregasiMinusController extends BaseController {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;
  bool isFiltered = false;

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  final PagingController<int, AggregationMinusModel> pagingController =
      PagingController(firstPageKey: 1);
  static const pageSize = 20;

  // List<AggregationMinusModel> aggregations = [];

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getAggregationMinuses(pageKey);
    });
  }

  Future<void> getAggregationMinuses(int page) async {
    showLoadingIndicator = true;
    try {
      final aggregations =
          await aggregation.getAggregationMinus(QueryParamModel(
        page: page,
        limit: pageSize,
        search: searchField.text,
      ));

      final payload = aggregations.data ?? List.empty();
      final isLastPage =
          aggregations.meta!.currentPage == aggregations.meta!.lastPage;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = page + 1;
        pagingController.appendPage(payload, nextPageKey);
      }
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
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
    startDate = null;
    endDate = null;
    startDateField.clear();
    endDateField.clear();
    isFiltered = false;
    update();
    Get.back();
  }
}
