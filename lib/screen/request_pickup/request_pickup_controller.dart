import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_state.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:css_mobile/util/ext/time_of_day_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:css_mobile/util/ext/string_ext.dart';

class RequestPickupController extends BaseController {
  final state = RequestPickupState();

  void setCheckMode(bool newState) {
    state.checkMode = newState;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    state.queryParam.setSort(jsonEncode([
      {"createdDateSearch": "desc"}
    ]));
    applyFilterDate();
    selectDateFilter(3);
    applyFilter();
    Future.wait([
      getAddresses(1),
      getCities(''),
      getStatuses(),
      getTypes(),
    ]);
    state.pagingController.addPageRequestListener((pageKey) {
      getRequestPickups(pageKey);
    });
    state.pagingControllerPickupDataAddress.addPageRequestListener((pageKey) {
      getAddresses(pageKey);
    });
  }

  void setSelectedFilterDate(RequestPickupDateEnum? date) {
    if (date != null) {
      state.selectedFilterDate = date;
      state.filterDateText = date.asName();
    }
  }

  void applyFilterDate() {
    bool startDateAvailable = state.selectedDateStart != null;
    bool endDateAvailable = state.selectedDateEnd != null;

    List<Map<String, dynamic>> between = [];

    switch (state.selectedFilterDate) {
      case RequestPickupDateEnum.custom:
        if (startDateAvailable && endDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(
                      state.selectedDateStart!.year,
                      state.selectedDateStart!.month,
                      state.selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(
                      state.selectedDateEnd!.year,
                      state.selectedDateEnd!.month,
                      state.selectedDateEnd!.day,
                      23,
                      59,
                      59,
                      999)
                  .toIso8601String()
            ]
          });
          state.filterDateText =
              '${state.selectedDateStartText} - ${state.selectedDateEndText}';
        } else if (startDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(
                      state.selectedDateStart!.year,
                      state.selectedDateStart!.month,
                      state.selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(
                      state.selectedDateStart!.year,
                      state.selectedDateStart!.month,
                      state.selectedDateStart!.day,
                      23,
                      59,
                      59,
                      999)
                  .toIso8601String()
            ]
          });
          state.filterDateText = state.selectedDateStartText;
        } else if (endDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(state.selectedDateEnd!.year,
                      state.selectedDateEnd!.month, state.selectedDateEnd!.day)
                  .toIso8601String(),
              DateTime(
                      state.selectedDateEnd!.year,
                      state.selectedDateEnd!.month,
                      state.selectedDateEnd!.day,
                      23,
                      59,
                      59,
                      999)
                  .toIso8601String()
            ]
          });
          state.filterDateText = state.selectedDateEndText;
        }
        break;
      case RequestPickupDateEnum.all:
        between = [];
        break;
      case RequestPickupDateEnum.oneMonth:
        final currentDateTime = DateTime.now();
        final oneMonthAgo = currentDateTime.subtract(const Duration(days: 30));
        between.add({
          "createdDateSearch": [
            DateTime(oneMonthAgo.year, oneMonthAgo.month, oneMonthAgo.day)
                .toIso8601String(),
            DateTime(currentDateTime.year, currentDateTime.month,
                    currentDateTime.day, 23, 59, 59, 999)
                .toIso8601String()
          ]
        });
        break;
      case RequestPickupDateEnum.oneWeek:
        final currentDateTime = DateTime.now();
        final oneWeekAgo = currentDateTime.subtract(const Duration(days: 7));
        between.add({
          "createdDateSearch": [
            DateTime(oneWeekAgo.year, oneWeekAgo.month, oneWeekAgo.day)
                .toIso8601String(),
            DateTime(currentDateTime.year, currentDateTime.month,
                    currentDateTime.day, 23, 59, 59, 999)
                .toIso8601String()
          ]
        });
        break;
      case RequestPickupDateEnum.today:
        final currentDateTime = DateTime.now();
        final startOfDay = DateTime(
            currentDateTime.year, currentDateTime.month, currentDateTime.day);
        final endOfDay = DateTime(currentDateTime.year, currentDateTime.month,
            currentDateTime.day, 23, 59, 59, 999);
        between.add({
          "createdDateSearch": [
            startOfDay.toIso8601String(),
            endOfDay.toIso8601String()
          ]
        });
        break;
      default:
        between = [];
        break;
    }

    state.queryParam.setBetween(jsonEncode(between));

    refreshPickups();
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

  applyFilter() {
    // if (state.startDate != null ||
    //     state.endDate != null ||
    //     state.selectedPetugasEntry != null ||
    //     state.selectedStatusKiriman != null) {
    state.isFiltered = true;
    if (state.startDate != null && state.endDate != null) {
      state.transDate =
          '[{"createdDateSearch":["${state.startDate}","${state.endDate}"]}]';
      state.queryParam.setBetween(jsonEncode([
        {
          "createdDateSearch": [
            state.startDate?.toIso8601String() ?? '',
            state.endDate?.toIso8601String() ?? ''
          ]
        }
      ]));
      // "${state.startDate?.millisecondsSinceEpoch ?? ''}-${state.endDate?.millisecondsSinceEpoch ?? ''}";
    } else {
      state.transDate = '[]';
      state.queryParam.setBetween(jsonEncode([]));
    }

    // state.pagingController.refresh();
    update();
    // if (state.dateFilter == '0') {
    //   resetFilter(true);
    // }

    // if (state.dateFilter == '0') {
    //   resetFilter(true);
    // } else {
    //   // update();
    refreshPickups();
    //   // state.pagingController.refresh();
    //   // transactionCount();
    // }
    // } else {
    //   resetFilter();
    // }
  }

  void resetQueryParam() {
    state.queryParam.setWhere(jsonEncode([]));
    state.queryParam.setBetween(jsonEncode([]));
    update();
  }

  void resetFilter(bool forceRefresh) {
    state.startDate = null;
    state.endDate = null;
    state.startDateField.clear();
    state.endDateField.clear();
    // state.selectedPetugasEntry = null;
    state.selectedOrigin = null;
    state.selectedStatusKiriman = null;
    // state.isFiltered = false;
    state.searchField.clear();
    state.transDate = '[]';
    state.dateFilter = '0';
    state.filterStatus = Constant.allStatus;
    state.selectedPetugasEntry = Constant.allDeliveryType;
    state.queryParam.setWhere(jsonEncode([]));
    state.queryParam.setBetween(jsonEncode([]));
    update();
    if (forceRefresh) {
      refreshPickups();
    }
    // state.pagingController.refresh();
  }

  void setSelectedFilterStatus(String? status) {
    if (status != null) {
      if (status == Constant.allStatus) {
        state.filterStatus = "";
      } else {
        state.filterStatus = status;
      }
      refreshPickups();
      state.filterStatusText = status;
      update();
    }
  }

  void setSelectedDeliveryTypeTwo(String? deliveryType) {
    if (deliveryType != null) {
      final where =
          (jsonDecode(state.queryParam.where ?? '[]') ?? []) as List<dynamic>;
      where.removeWhere((element) => element["codFlag"] != null);
      if (deliveryType == "COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "YES"});
      } else if (deliveryType == "NON COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "NO"});
      }
      state.queryParam.setWhere(jsonEncode(where));
      state.queryParam.setPage(1);
      // refreshPickups();
      // state.filterDeliveryTypeText = deliveryType;
      // update();
    }
  }

  void setSelectedDeliveryType(String? deliveryType) {
    if (deliveryType != null) {
      final where =
          (jsonDecode(state.queryParam.where ?? '[]') ?? []) as List<dynamic>;
      where.removeWhere((element) => element["codFlag"] != null);
      if (deliveryType == "COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "YES"});
      } else if (deliveryType == "NON COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "NO"});
      }
      state.queryParam.setWhere(jsonEncode(where));
      // refreshPickups();
      state.filterDeliveryTypeText = deliveryType;
      update();
    }
  }

  void setSelectedFilterCityTwo(OriginModel? origin) {
    if (origin != null) {
      final where =
          (jsonDecode(state.queryParam.where ?? '[]') ?? []) as List<dynamic>;
      where.removeWhere((element) => element["originCode"] != null);
      where.add({"originCode": origin.originCode});
      state.queryParam.setWhere(jsonEncode(where));
      // update();
    }
    // refreshPickups();
    // state.filterDeliveryCityText = city['label'];
  }

  void setSelectedFilterCity(Map<String, dynamic> city) {
    final where =
        (jsonDecode(state.queryParam.where ?? '[]') ?? []) as List<dynamic>;
    where.removeWhere((element) => element["originCode"] != null);
    if (city['label'] != Constant.allDeliveryCity) {
      where.add({"originCode": city['value']});
    }
    state.queryParam.setWhere(jsonEncode(where));
    refreshPickups();
    state.filterDeliveryCityText = city['label'];
    update();
  }

  void setSelectedDateStart(DateTime? dateTime) {
    if (dateTime != null) {
      state.selectedDateStart = dateTime;
      state.selectedDateStartText =
          dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  void setSelectedDateEnd(DateTime? dateTime) {
    if (dateTime != null) {
      state.selectedDateEnd = dateTime;
      state.selectedDateEndText =
          dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  Future<void> getRequestPickups(int pageKey) async {
    state.showLoadingIndicator = true;

    try {
      AppLogger.i("pageKey: $pageKey");
      state.queryParam.setPage(pageKey);
      state.queryParam.setSearch(state.searchField.text);
      setSelectedDeliveryTypeTwo(state.selectedPetugasEntry);
      AppLogger.i("selectedorigin: ${state.selectedOrigin}");
      setSelectedFilterCityTwo(state.selectedOrigin);
      final response = await requestPickupRepository.getRequestPickups(
          QueryParamModel(
            limit: state.queryParam.limit,
            page: pageKey,
            sort: state.queryParam.sort,
            where: state.queryParam.where,
            between: state.queryParam.between,
            search: state.queryParam.search,
          ),
          state.filterStatus);
      // setSelectedDeliveryType(state.filterDeliveryTypeText);

      AppLogger.d("getRequestPickups response: ${response.data}");

      final payload = response.data ?? List.empty();
      // final isLastPage = payload.length <= pageSize;
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;

      if (isLastPage) {
        state.pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = pageKey + 1;
        state.pagingController.appendPage(payload, nextPageKey);
      }

      state.showMainContent = true;
      update();
    } catch (e) {
      AppLogger.e("getRequestPickups error: $e");
      state.showErrorContent = true;
      update();
    }

    state.showLoadingIndicator = false;
    update();
  }

  Future<void> getAddresses(int page) async {
    // try {
    //   final response = await requestPickupRepository
    //       .getRequestPickupAddresses(QueryParamModel(
    //           limit: 0,
    //           sort: jsonEncode([
    //             {"createdDate": "desc"}
    //           ])));
    //   final payload = response.data ?? List.empty();
    //   addresses.clear();
    //   addresses.addAll(payload);
    //   AppLogger.i("addresses: $addresses");
    // } catch (e) {
    //   AppLogger.e("getAddresses error: $e");
    //   e.toString();
    //   // Do nothing for now.
    // }

    try {
      final response = await requestPickupRepository
          .getRequestPickupAddresses(QueryParamModel(
              // limit: 0,
              page: page,
              sort: jsonEncode([
                {"createdDate": "desc"}
              ])));
      AppLogger.i("addresses: ${response.data}");
      final payload = response.data ?? List.empty();
      state.addresses.clear();
      state.addresses.addAll(payload);

      AppLogger.i("addresses from controller: ${state.addresses}");
      // return BaseResponse<List<PantauPaketmuModel>>

      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;
      if (isLastPage) {
        state.pagingControllerPickupDataAddress.appendLastPage(payload);
        AppLogger.i(
            "pagingControllerPickupDataAddress, ${state.pagingControllerPickupDataAddress}");
      } else {
        final nextPageKey = page + 1;
        state.pagingControllerPickupDataAddress
            .appendPage(payload, nextPageKey);
        AppLogger.i(
            "pagingControllerPickupDataAddress, ${state.pagingControllerPickupDataAddress}");
      }
    } catch (e) {
      AppLogger.e("getAddresses error: $e");
      state.pagingControllerPickupDataAddress.error = e;
    }
  }

  Future<void> getCities(String keyword) async {
    try {
      // final response = await master.getDestinations(QueryParamModel(
      //   select: jsonEncode(["cityName"]),
      // ));
      // AppLogger.d("getCities response: ${jsonEncode(response.data)}");
      // final payload = response.data ?? List.empty();
      // final city = payload.map((e) => e.cityName).toSet().toList();
      // AppLogger.d("city: $city");
      final response =
          await requestPickupRepository.getRequestPickupOrigins(QueryParamModel(
              like: jsonEncode([
        {"originName": keyword}
      ])));
      final payload = response.data ?? List.empty();
      state.cities.clear();
      state.cities.add({
        "label": Constant.allDeliveryCity,
        "value": "",
      });
      // final test = city.whereType<String>();
      // AppLogger.d("test: $test");
      // cities.addAll(payload.map((e) => e.originName ?? "").toList());
      state.cities.addAll(payload
          .map((e) => {
                "label": e.originName,
                "value": e.originCode,
              })
          .toList());
      // cities.addAll([]);

      update();
    } catch (e) {
      // Do nothing for now.
    }
  }

  Future<void> getStatuses() async {
    try {
      final response = await requestPickupRepository.getRequestPickupStatuses();
      final payload = response.data ?? List.empty();
      state.statuses.add(Constant.allStatus);
      state.statuses.addAll(payload);

      state.listStatusKiriman.add(Constant.allStatus);
      state.listStatusKiriman.addAll(payload);
    } catch (e) {
      AppLogger.e('error getStatuses $e');
    }
  }

  Future<void> getTypes() async {
    try {
      final response = await requestPickupRepository.getRequestPickupTypes();
      final payload = response.data ?? List.empty();
      state.types.add(Constant.allDeliveryType);
      state.types.addAll(payload);

      state.listOfficerEntry.add(Constant.allDeliveryType);
      state.listOfficerEntry.addAll(payload);
    } catch (e) {
      // Do nothing for now.
    }
  }

  void onSelectAddress(String id) {
    state.selectedAddressId = id;
  }

  void selectItem(String awb) {
    if (isItemChecked(awb)) {
      state.selectedAwbs.remove(awb);
    } else {
      state.selectedAwbs.add(awb);
    }

    update();
  }

  bool isItemChecked(String awb) {
    return state.selectedAwbs.contains(awb);
  }

  void onCheckAll() {
    // selectedAwbs.addAll(iterable);
  }

  void onCancel() {
    state.selectedAwbs.clear();
  }

  void onUpdateAddresses() {
    // pagingControllerPickupDataAddress.refresh();
    // getAddresses(1);
  }

  void refreshPickups() {
    state.pagingController.refresh();
    // pagingControllerPickupDataAddress.refresh();
  }

  void refreshState() {
    state.createDataLoading = false;
    state.createDataSuccess = false;
    state.createDataFailed = false;
    state.checkMode = false;
    state.selectedAwbs.clear();
    update();
  }

  void requireRetry() {
    getRequestPickups(Constant.defaultPage);
  }

  void onSetPickupTime(String newTime) {
    state.selectedPickupTime = newTime;
  }

  void onPickupAction() async {
    state.createDataLoading = true;
    update();

    requestPickupRepository
        .createRequestPickup(_prepareCreateData())
        .then((response) {
      state.data = response.data;
      if (response.code == HttpStatus.created &&
          response.data!.errorDetails.isEmpty) {
        state.createDataSuccess = true;
        refreshPickups();
        refreshState();
      } else {
        state.createDataFailed = true;
      }
      update();
    }).catchError((error) {
      state.createDataFailed = true;
      update();
    });

    state.createDataLoading = false;
    update();
  }

  void onCityKeywordChange(String newText) {
    getCities(newText);
  }

  String getSelectedPickupTime() {
    if (state.selectedPickupTime == Constant.defaultPickupTime) {
      return TimeOfDay.now().asPickupTimeFormat();
    }

    return state.selectedPickupTime;
  }

  void onSearchChanged(String value) {
    // Cancel the previous timer if it exists
    if (state.debounceTimer?.isActive ?? false) {
      state.debounceTimer!.cancel();
    }

    // Set a new timer for debounce
    state.debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Trigger the search or refresh when the user stops typing
      state.searchField.text = value;
      state.pagingController.refresh();
    });
  }

  /// Internal methods.

  RequestPickupCreateRequestModel _prepareCreateData() {
    return RequestPickupCreateRequestModel(
      awbs: state.selectedAwbs,
      pickupAddressId: state.selectedAddressId ?? '',
      pickupTime: getSelectedPickupTime(),
    );
  }
}
