import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/default_page_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_address_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupController extends BaseController {

  bool showLoadingIndicator = false;
  bool showMainContent = true;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupAddressModel> addresses = [];
  List<String> cities = [];
  List<String> statuses = [];
  List<String> types = [];

  RequestPickupFilterModel filter = RequestPickupFilterModel() ;
  String filterDateText = Constant.allDate;
  String filterStatusText = Constant.allStatus;
  String filterDeliveryTypeText = Constant.allDeliveryType;
  String filterDeliveryCityText = Constant.allDeliveryCity;

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;

  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  String selectedDateStartText = "Pilih Tanggal Awal";
  String selectedDateEndText = "Pilih Tanggal Akhir";

  final PagingController<int, RequestPickupModel> pagingController = PagingController(firstPageKey: Constant.defaultPage);
  static const pageSize = Constant.defaultLimit;

  List<String> selectedAwbs = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([
      getAddresses(),
      getCities(),
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

    if (selectedFilterDate == RequestPickupDateEnum.custom) {
      if (startDateAvailable && endDateAvailable) {
        filter.setDate('${selectedDateStart?.millisecondsSinceEpoch}-${selectedDateEnd?.millisecondsSinceEpoch}');
        filterDateText = '$selectedDateStartText - $selectedDateEndText';
      } else if (startDateAvailable) {
        filter.setDate('${selectedDateStart?.millisecondsSinceEpoch}');
        filterDateText = selectedDateStartText;
      } else if (endDateAvailable) {
        filter.setDate('${selectedDateEnd?.millisecondsSinceEpoch}');
        filterDateText = selectedDateEndText;
      }
    } else if (selectedFilterDate == RequestPickupDateEnum.all) {
      filter.setDate('');
    }

    refreshPickups();
    update();
  }

  void setSelectedFilterStatus(String? status) {
    if (status != null) {
      filter.setPickupStatus(status);
      refreshPickups();
      filterStatusText = status;
      update();
    }
  }

  void setSelectedDeliveryType(String? deliveryType) {
    if (deliveryType != null) {
      filter.setTransactionType(deliveryType);
      refreshPickups();
      filterDeliveryTypeText = deliveryType;
      update();
    }
  }

  void setSelectedFilterCity(String? city) {
    if (city != null) {
      filter.setTransactionCity(city);
      refreshPickups();
      filterDeliveryCityText = city;
      update();
    }
  }

  void setSelectedDateStart(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateStart = dateTime;
      selectedDateStartText = dateTime.toStringWithFormat(format: "dd MMM yyyy");
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
      final response = await requestPickupRepository.getRequestPickups(filter);

      final payload = response.payload ?? List.empty();
      final isLastPage = payload.length < pageSize;

      if (isLastPage) {
        pagingController.appendLastPage(payload);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(payload, nextPageKey);
      }

      showMainContent = true;
      update();
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

  Future<void> getAddresses() async {
    try {
      final response = await requestPickupRepository.getRequestPickupAddresses();
      final payload = response.payload ?? List.empty();
      addresses.clear();
      addresses.addAll(payload);
      update();
    } catch (e) {
      e.toString();
      print("payload error");
      // Do nothing for now.
    }
  }

  Future<void> getCities() async {
    try {
      final response = await requestPickupRepository.getRequestPickupCities(DefaultPageFilterModel());
      final payload = response.payload ?? List.empty();
      cities.add(Constant.allDeliveryCity);
      cities.addAll(payload);
    } catch (e) {
      // Do nothing for now.
    }
  }

  Future<void> getStatuses() async {
    try {
      final response = await requestPickupRepository.getRequestPickupStatuses();
      final payload = response.payload ?? List.empty();
      statuses.add(Constant.allStatus);
      statuses.addAll(payload);
    } catch (e) {
      e.printError();
      // Do nothing for now.
    }
  }

  Future<void> getTypes() async {
    try {
      final response = await requestPickupRepository.getRequestPickupTypes();
      final payload = response.payload ?? List.empty();
      types.add(Constant.allDeliveryType);
      types.addAll(payload);
    } catch (e) {
      // Do nothing for now.
    }
  }

  void selectItem(String awb) {
    if (isItemChecked(awb)) {
      selectedAwbs.remove(awb);
    } else {
      selectedAwbs.add(awb);
    }
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

  void requireRetry() {
    getRequestPickups(Constant.defaultPage);
  }

}