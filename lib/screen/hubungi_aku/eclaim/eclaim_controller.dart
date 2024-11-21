
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/util/logger.dart';

import 'eclaim_state.dart';
import 'package:get/get.dart';

class EclaimController extends BaseController {
  final state = EclaimState();
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([ initData()]);
    state.pagingController.addPageRequestListener((pageKey) {
      getEclaims(pageKey);
    });
    // categoryList();
    selectDateFilter(3);
    applyFilter();
  }

  void selectStatusClaim(String? status) {
    state.selectedStatusClaim = status;
    applyFilter();
  }

}

Future<void> eclaimCounts() async {
  try {

    await ecla.getEclaimCount(
      sta.transDate ?? '[]',
      state.searchField.text,
    )
        .then((value) {
      state.total = value.data?.total?.toInt() ?? 0;
      state.diterima = value.data?.total?.toInt() ?? 0;
      state.ditolak = value.data?.total?.toInt() ?? 0;
      update();
    });
  } catch (e, i) {
    AppLogger.e('error transactionCount $e, $i');
  }
}

Future<void> initData() async {

}

Future<void> getEclaims(int page) async {
  state.isLoading = true;
  try {
    final eclaim = await eclaims.getEclaim(
        QueryParamModel(
          search: state.searchField.text,
        )
    );

    final isLastPage =
        (eclaim.meta?.currentPage ?? 0) == (eclaim.meta?.lastPage ?? 0);
    if (isLastPage) {
      state.pagingController.appendLastPage(eclaim.data ?? []);
      // transactionList.addAll(state.pagingController.itemList ?? []);
    } else {
      final nextPageKey = page + 1;
      state.pagingController.appendPage(eclaim.data ?? [], nextPageKey);
      // transactionList.addAll(state.pagingController.itemList ?? []);
    }
  } catch (e) {
    AppLogger.e('error getEclaim $e');
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
  // state.isFiltered = false;
  state.searchField.clear();
  state.transDate = '[]';
  state.dateFilter = '0';
  state.pagingController.refresh();
  update();
  transactionCount();
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
    '[{"createDate":["${state.startDate}","${state.endDate}"]}]';
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
}}
