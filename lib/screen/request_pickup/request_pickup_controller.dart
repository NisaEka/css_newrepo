import 'dart:async';
import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_request_model.dart';
import 'package:css_mobile/screen/request_pickup/request_pickup_state.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/time_of_day_ext.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';

class RequestPickupController extends BaseController {
  final state = RequestPickupState();

  void setCheckMode(bool newState) {
    state.checkMode = newState;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    state.queryParam.setSort([
      {"createdDateSearch": "desc"}
    ]);
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter();
    Future.wait([
      getAddresses(1),
      getStatuses(),
      getTypes(),
    ]);
    state.pagingController.addPageRequestListener((pageKey) {
      getRequestPickups(pageKey);
    });
    Future.wait([getRequestPickupCount()]);
    state.pagingControllerPickupDataAddress.addPageRequestListener((pageKey) {
      getAddresses(pageKey);
    });
  }

  applyFilter() {
    state.isFiltered = true;
    if (state.startDate != null && state.endDate != null) {
      state.queryParam.setBetween([
        {
          "createdDateSearch": [
            state.startDate?.toIso8601String() ?? '',
            state.endDate?.toIso8601String() ?? ''
          ]
        }
      ]);
    } else {
      state.queryParam.setBetween([]);
    }

    update();
    refreshPickups();
  }

  void resetQueryParam() {
    state.queryParam.setWhere([]);
    state.queryParam.setBetween([]);
    update();
  }

  void resetFilter(bool forceRefresh) {
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    state.selectedOrigin = null;
    state.searchField.clear();
    state.dateFilter = '3';
    state.filterStatus = Constant.allStatus;
    state.selectedDeliveryType = Constant.allDeliveryType;
    state.queryParam.setWhere([]);
    state.queryParam.setBetween([]);
    update();
    if (forceRefresh) {
      refreshPickups();
    }
  }

  void setSelectedDeliveryTypeTwo(String? deliveryType) {
    if (deliveryType != null) {
      List<Map<String, dynamic>> where = (state.queryParam.where ?? []);
      where.removeWhere((element) => element["codFlag"] != null);
      if (deliveryType == "COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "YES"});
      } else if (deliveryType == "NON COD") {
        where.removeWhere((element) => element["codFlag"] != null);
        where.add({"codFlag": "NO"});
      }
      state.queryParam.setWhere(where);
      state.queryParam.setPage(1);
    }
  }

  void setSelectedFilterCityTwo(OriginModel? origin) {
    if (origin != null) {
      List<Map<String, dynamic>> where = state.queryParam.where ?? [];
      where.removeWhere((element) => element["originCode"] != null);
      where.add({"originCode": origin.originCode});
      state.queryParam.setWhere(where);
    }
  }

  Future<void> getRequestPickupCount() async {
    try {
      final response =
          await requestPickupRepository.getRequestPickupCount(QueryModel(
        where: state.queryParam.where,
        between: state.queryParam.between,
        search: state.queryParam.search,
      ));

      AppLogger.d("getRequestPickupCount response: ${response.data}");

      state.requestPickupCount = response.data ?? List.empty();
    } catch (e) {
      AppLogger.e("getRequestPickupCount error: $e");
    }
    update();
  }

  Future<void> getRequestPickups(int pageKey) async {
    state.showLoadingIndicator = true;

    try {
      AppLogger.i("pageKey: $pageKey");
      state.queryParam.setPage(pageKey);
      state.queryParam.setSearch(state.searchField.text);
      setSelectedDeliveryTypeTwo(state.selectedDeliveryType);
      AppLogger.i("selectedorigin: ${state.selectedOrigin}");
      setSelectedFilterCityTwo(state.selectedOrigin);
      final response = await requestPickupRepository.getRequestPickups(
          QueryModel(
            limit: state.queryParam.limit,
            page: pageKey,
            sort: state.queryParam.sort,
            where: state.queryParam.where,
            between: state.queryParam.between,
            search: state.queryParam.search,
          ),
          state.filterStatus);

      AppLogger.d("getRequestPickups response: ${response.data}");

      final payload = response.data ?? List.empty();
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
    try {
      final response = await requestPickupRepository
          .getRequestPickupAddresses(QueryModel(page: page, sort: [
        {"createdDate": "desc"}
      ]));
      AppLogger.i("addresses: ${response.data}");
      final payload = response.data ?? List.empty();
      state.addresses.clear();
      state.addresses.addAll(payload);

      AppLogger.i("addresses from controller: ${state.addresses}");

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

  Future<void> getStatuses() async {
    try {
      final response = await requestPickupRepository.getRequestPickupStatuses();
      final payload = response.data ?? List.empty();

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

      state.listDeliveryType.add(Constant.allDeliveryType);
      state.listDeliveryType.addAll(payload);
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

  void onCancel() {
    state.selectedAwbs.clear();
  }

  void refreshPickups() {
    state.pagingController.refresh();
    getRequestPickupCount();
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
      if (response.code == HttpStatus.created &&
          response.data!.errorDetails.isEmpty) {
        state.createDataSuccess = true;
        // todo : kalo berhasil dialog nya taro sini pakke Get.dialog
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
      getRequestPickupCount();
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
