import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:css_mobile/util/ext/time_of_day_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupController extends BaseController {
  bool _checkMode = false;
  Timer? _debounceTimer;

  bool get checkMode => _checkMode;

  void setCheckMode(bool newState) {
    _checkMode = newState;
    update();
  }

  TextEditingController cityKeyword = TextEditingController();
  final searchField = TextEditingController();

  bool showLoadingIndicator = false;
  bool showMainContent = true;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupAddressModel> addresses = [];
  List<Map<String, dynamic>> cities = [];
  List<String> statuses = [];
  List<String> types = [];

  QueryParamModel queryParam = QueryParamModel();
  String filterStatus = "";
  String filterDateText = Constant.allDate;
  String filterStatusText = Constant.allStatus;
  String filterDeliveryTypeText = Constant.allDeliveryType;
  String filterDeliveryCityText = Constant.allDeliveryCity;

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;

  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  String selectedDateStartText = "Pilih Tanggal Awal";
  String selectedDateEndText = "Pilih Tanggal Akhir";

  final PagingController<int, RequestPickupModel> pagingController =
      PagingController(firstPageKey: Constant.defaultPage);
  static const pageSize = Constant.defaultLimit;

  List<String> selectedAwbs = [];
  String selectedPickupTime = Constant.defaultPickupTime;
  String? selectedAddressId;

  bool _createDataLoading = false;

  bool get createDataLoading => _createDataLoading;

  bool _createDataFailed = false;

  bool get createDataFailed => _createDataFailed;

  bool _createDataSuccess = false;

  bool get createDataSuccess => _createDataSuccess;

  RequestPickupCreateResponseModel? _data;

  RequestPickupCreateResponseModel? get data => _data;

  @override
  void onInit() {
    super.onInit();
    queryParam.setSort(jsonEncode([
      {"createdDateSearch": "desc"}
    ]));
    Future.wait([
      getAddresses(),
      getCities(''),
      getStatuses(),
      getTypes(),
    ]);
    pagingController.addPageRequestListener((pageKey) {
      getRequestPickups(pageKey);
    });
  }

  void setSelectedFilterDate(RequestPickupDateEnum? date) {
    if (date != null) {
      selectedFilterDate = date;
      filterDateText = date.asName();
    }
  }

  void applyFilterDate() {
    bool startDateAvailable = selectedDateStart != null;
    bool endDateAvailable = selectedDateEnd != null;

    List<Map<String, dynamic>> between = [];

    switch (selectedFilterDate) {
      case RequestPickupDateEnum.custom:
        if (startDateAvailable && endDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = '$selectedDateStartText - $selectedDateEndText';
        } else if (startDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day)
                  .toIso8601String(),
              DateTime(selectedDateStart!.year, selectedDateStart!.month,
                      selectedDateStart!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = selectedDateStartText;
        } else if (endDateAvailable) {
          between.add({
            "createdDateSearch": [
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day)
                  .toIso8601String(),
              DateTime(selectedDateEnd!.year, selectedDateEnd!.month,
                      selectedDateEnd!.day, 23, 59, 59, 999)
                  .toIso8601String()
            ]
          });
          filterDateText = selectedDateEndText;
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

    queryParam.setBetween(jsonEncode(between));

    refreshPickups();
    update();
  }

  void setSelectedFilterStatus(String? status) {
    if (status != null) {
      if (status == Constant.allStatus) {
        filterStatus = "";
      } else {
        filterStatus = status;
      }
      refreshPickups();
      filterStatusText = status;
      update();
    }
  }

  void setSelectedDeliveryType(String? deliveryType) {
    if (deliveryType != null) {
      final where =
          (jsonDecode(queryParam.where ?? '[]') ?? []) as List<dynamic>;
      where.removeWhere((element) => element["codFlag"] != null);
      if (deliveryType == "COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "YES"});
      } else if (deliveryType == "NON COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "NO"});
      }
      queryParam.setWhere(jsonEncode(where));
      refreshPickups();
      filterDeliveryTypeText = deliveryType;
      update();
    }
  }

  void setSelectedFilterCity(Map<String, dynamic> city) {
    final where = (jsonDecode(queryParam.where ?? '[]') ?? []) as List<dynamic>;
    where.removeWhere((element) => element["originCode"] != null);
    if (city['label'] != Constant.allDeliveryCity) {
      where.add({"originCode": city['value']});
    }
    queryParam.setWhere(jsonEncode(where));
    refreshPickups();
    filterDeliveryCityText = city['label'];
    update();
  }

  void setSelectedDateStart(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateStart = dateTime;
      selectedDateStartText =
          dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  void setSelectedDateEnd(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateEnd = dateTime;
      selectedDateEndText = dateTime.toStringWithFormat(format: "dd MMM yyyy");
    }
  }

  Future<void> getRequestPickups(int pageKey) async {
    showLoadingIndicator = true;

    try {
      queryParam.setPage(pageKey);
      queryParam.setSearch(searchField.text);
      AppLogger.d("queryParam: ${queryParam.toJson()}");
      final response = await requestPickupRepository.getRequestPickups(
          queryParam, filterStatus);

      AppLogger.d("getRequestPickups response: ${response.data}");

      final payload = response.data ?? List.empty();
      // final isLastPage = payload.length <= pageSize;
      final isLastPage = response.meta!.currentPage == response.meta!.lastPage;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(payload, nextPageKey);
      }

      showMainContent = true;
      update();
    } catch (e) {
      AppLogger.e("getRequestPickups error: $e");
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

  Future<void> getAddresses() async {
    try {
      final response = await requestPickupRepository
          .getRequestPickupAddresses(QueryParamModel(
              limit: 0,
              sort: jsonEncode([
                {"createdDate": "desc"}
              ])));
      final payload = response.data ?? List.empty();
      addresses.clear();
      addresses.addAll(payload);
      AppLogger.i("addresses: $addresses");
    } catch (e) {
      AppLogger.e("getAddresses error: $e");
      e.toString();
      // Do nothing for now.
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
      cities.clear();
      cities.add({
        "label": Constant.allDeliveryCity,
        "value": "",
      });
      // final test = city.whereType<String>();
      // AppLogger.d("test: $test");
      // cities.addAll(payload.map((e) => e.originName ?? "").toList());
      cities.addAll(payload
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
      statuses.add(Constant.allStatus);
      statuses.addAll(payload);
    } catch (e) {
      AppLogger.e('error getStatuses $e');
    }
  }

  Future<void> getTypes() async {
    try {
      final response = await requestPickupRepository.getRequestPickupTypes();
      final payload = response.data ?? List.empty();
      types.add(Constant.allDeliveryType);
      types.addAll(payload);
    } catch (e) {
      // Do nothing for now.
    }
  }

  void onSelectAddress(String id) {
    selectedAddressId = id;
  }

  void selectItem(String awb) {
    if (isItemChecked(awb)) {
      selectedAwbs.remove(awb);
    } else {
      selectedAwbs.add(awb);
    }

    update();
  }

  bool isItemChecked(String awb) {
    return selectedAwbs.contains(awb);
  }

  void onCheckAll() {
    // selectedAwbs.addAll(iterable);
  }

  void onCancel() {
    selectedAwbs.clear();
  }

  void onUpdateAddresses() {
    getAddresses();
  }

  void refreshPickups() {
    pagingController.refresh();
  }

  void refreshState() {
    _createDataLoading = false;
    _createDataSuccess = false;
    _createDataFailed = false;
    _checkMode = false;
    selectedAwbs.clear();
    update();
  }

  void requireRetry() {
    getRequestPickups(Constant.defaultPage);
  }

  void onSetPickupTime(String newTime) {
    selectedPickupTime = newTime;
  }

  void onPickupAction() async {
    _createDataLoading = true;
    update();

    requestPickupRepository
        .createRequestPickup(_prepareCreateData())
        .then((response) {
      _data = response.data;
      if (response.code == HttpStatus.created &&
          response.data!.errorDetails.isEmpty) {
        _createDataSuccess = true;
        refreshPickups();
        refreshState();
      } else {
        _createDataFailed = true;
      }
      update();
    }).catchError((error) {
      _createDataFailed = true;
      update();
    });

    _createDataLoading = false;
    update();
  }

  void onCityKeywordChange(String newText) {
    getCities(newText);
  }

  String getSelectedPickupTime() {
    if (selectedPickupTime == Constant.defaultPickupTime) {
      return TimeOfDay.now().asPickupTimeFormat();
    }

    return selectedPickupTime;
  }

  void onSearchChanged(String value) {
    // Cancel the previous timer if it exists
    if (_debounceTimer?.isActive ?? false) {
      _debounceTimer!.cancel();
    }

    // Set a new timer for debounce
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      // Trigger the search or refresh when the user stops typing
      searchField.text = value;
      pagingController.refresh();
    });
  }

  /// Internal methods.

  RequestPickupCreateRequestModel _prepareCreateData() {
    return RequestPickupCreateRequestModel(
      awbs: selectedAwbs,
      pickupAddressId: addresses.first.pickupDataId,
      pickupTime: getSelectedPickupTime(),
    );
  }
}
