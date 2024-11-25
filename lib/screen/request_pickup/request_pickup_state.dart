import 'dart:async';

import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_create_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupState {
  bool? isLastScreen = Get.arguments['isLastScreen'];
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, RequestPickupModel> pagingController =
      PagingController(firstPageKey: 1);

  int selectedKiriman = 0;
  int total = 0;
  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatusKiriman;
  String? selectedPetugasEntry;
  OriginModel? selectedOrigin;
  String? transType;
  String? transDate;
  String dateFilter = '0';

  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<String> listOfficerEntry = [];
  List<TransactionModel> selectedTransaction = [];

  UserModel? basic;

  bool checkMode = false;
  Timer? debounceTimer;

  // bool get checkMode => _checkMode;

  TextEditingController cityKeyword = TextEditingController();
  // final searchField = TextEditingController();

  bool showLoadingIndicator = false;
  bool showMainContent = true;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupAddressModel> addresses = [];
  List<Map<String, dynamic>> cities = [];
  List<String> statuses = [];
  List<String> types = [];

  QueryParamModel queryParam = QueryParamModel();
  String filterStatus = Constant.allStatus;
  String filterDateText = RequestPickupDateEnum.today.asName();
  String filterStatusText = Constant.allStatus;
  String filterDeliveryTypeText = Constant.allDeliveryType;
  String filterDeliveryCityText = Constant.allDeliveryCity;

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.today;

  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  String selectedDateStartText = "Pilih Tanggal Awal";
  String selectedDateEndText = "Pilih Tanggal Akhir";

  // final PagingController<int, RequestPickupModel> pagingController =
  //     PagingController(firstPageKey: Constant.defaultPage);
  static const pageSize = Constant.defaultLimit;

  List<String> selectedAwbs = [];
  String selectedPickupTime = Constant.defaultPickupTime;
  String? selectedAddressId;

  final PagingController<int, RequestPickupAddressModel>
      pagingControllerPickupDataAddress =
      PagingController(firstPageKey: Constant.defaultPage);

  bool createDataLoading = false;

  // bool get createDataLoading => _createDataLoading;

  bool createDataFailed = false;

  // bool get createDataFailed => _createDataFailed;

  bool createDataSuccess = false;

  // bool get createDataSuccess => _createDataSuccess;

  RequestPickupCreateResponseModel? data;

  // RequestPickupCreateResponseModel? get data => _data;
}
