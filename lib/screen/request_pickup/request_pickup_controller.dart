import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_delivery_type_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_status_enum.dart';
import 'package:flutter/cupertino.dart';

class RequestPickupController extends BaseController {

  bool showLoadingIndicator = false;
  bool showMainContent = false;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupModel> requestPickups = [];

  String filterDateText = "Semua Tanggal";
  String filterStatusText = "Semua Status";
  String filterDeliveryTypeText = "Semua Tipe Kiriman";
  String filterDeliveryCityText = "Semua Kota Pengiriman";

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;
  RequestPickupStatus selectedFilterStatus = RequestPickupStatus.semua;
  RequestPickupDeliveryType selectedFilterDeliveryType = RequestPickupDeliveryType.semua_tipe_kiriman;

  setSelectedFilterDate(RequestPickupDateEnum? date) {
    if (date != null) {
      selectedFilterDate = date;
      filterDateText = date.asName();
      update();
    }
  }

  setSelectedFilterStatus(RequestPickupStatus? status) {
    if (status != null) {
      selectedFilterStatus = status;
      filterStatusText = status.asName();
      update();
    }
  }

  setSelectedDeliveryType(RequestPickupDeliveryType? deliveryType) {
    if (deliveryType != null) {
      selectedFilterDeliveryType = deliveryType;
      filterDeliveryTypeText = deliveryType.asName();
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.wait([getRequestPickups()]);
  }

  Future<void> getRequestPickups() async {
    showLoadingIndicator = true;
    update();

    try {
      final response = await requestPickupRepository.getRequestPickups();

      if (response.code == HttpStatus.ok) {
        if (response.payload != null || response.payload!.isNotEmpty) {
          requestPickups.addAll(response.payload!);
          showMainContent = true;
          update();
        } else {
          showEmptyContent = true;
          update();
        }
      } else {
        showErrorContent = true;
        update();
      }
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

  requireRetry() {

  }

}