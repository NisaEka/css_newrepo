import 'dart:async';

import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/vehicle_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_count_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupState {
  final searchField = TextEditingController();
  static const pageSize = Constant.defaultLimit;
  final PagingController<int, RequestPickupModel> pagingController =
      PagingController(firstPageKey: 1);
  final PagingController<int, RequestPickupAddressModel>
      pagingControllerPickupDataAddress =
      PagingController(firstPageKey: Constant.defaultPage);
  List<RequestPickupCountModel> requestPickupCount = [];

  DateTime? startDate;
  DateTime? endDate;
  String? selectedDeliveryType = Constant.allDeliveryType;
  OriginModel? selectedOrigin;
  String dateFilter = '3';

  bool isFiltered = false;

  List<String> listStatusKiriman = [];
  List<String> listDeliveryType = [];

  bool checkMode = false;
  Timer? debounceTimer;

  bool showLoadingIndicator = false;
  bool showMainContent = true;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupAddressModel> addresses = [];

  QueryModel queryParam = QueryModel();
  String filterStatus = "BELUM MINTA DIJEMPUT";

  List<String> selectedAwbs = [];
  String selectedPickupTime = Constant.defaultPickupTime;
  String? selectedAddressId;
  String? selectedVehicle;

  bool createDataLoading = false;
  bool createDataFailed = false;
  bool createDataSuccess = false;

  RequestPickupCreateResponseModel? data;
}
