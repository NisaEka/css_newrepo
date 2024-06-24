import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_delivery_type_enum.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_filter_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_status_enum.dart';
import 'package:css_mobile/util/ext/date_ext.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RequestPickupController extends BaseController {

  bool showLoadingIndicator = false;
  bool showMainContent = true;
  bool showErrorContent = false;
  bool showEmptyContent = false;

  List<RequestPickupModel> requestPickups = [];
  List<String> cities = [
    "Semua Kota Pengiriman",
    "Bandung",
    "Subang",
    "Jakarta",
    "Yogyakarta"
  ];

  String filterDateText = "Semua Tanggal";
  String filterStatusText = "Semua Status";
  String filterDeliveryTypeText = "Semua Tipe Kiriman";
  String filterDeliveryCityText = "Semua Kota Pengiriman";

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;
  RequestPickupStatus selectedFilterStatus = RequestPickupStatus.semua;
  RequestPickupDeliveryType selectedFilterDeliveryType = RequestPickupDeliveryType.semua_tipe_kiriman;

  DateTime? selectedDateStart;
  DateTime? selectedDateEnd;
  String selectedDateStartText = "Pilih Tanggal Awal";
  String selectedDateEndText = "Pilih Tanggal Akhir";

  final PagingController<int, RequestPickupModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener((pageKey) {
      getRequestPickups(pageKey);
    });
  }

  setSelectedFilterDate(RequestPickupDateEnum? date) {
    if (date != null) {
      selectedFilterDate = date;

      if (date == RequestPickupDateEnum.custom) {
        if (selectedDateStart != null && selectedDateEnd != null) {
          filterDateText = "$selectedDateStartText - $selectedDateEndText";
        } else if (selectedDateStart != null) {
          filterDateText = selectedDateStartText;
        } else if (selectedDateEnd != null) {
          filterDateText = selectedDateEndText;
        }
        filterDateText = date.asName();
      } else {
        filterDateText = date.asName();
      }

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

  setSelectedFilterCity(String? city) {
    if (city != null) {
      filterDeliveryCityText = city;
      update();
    }
  }

  setSelectedDateStart(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateStart = dateTime;
      selectedDateStartText = dateTime.toStringWithFormat(format: "dd-MM-yyyy");
      update();
    }
  }

  setSelectedDateEnd(DateTime? dateTime) {
    if (dateTime != null) {
      selectedDateEnd = dateTime;
      selectedDateEndText = dateTime.toStringWithFormat(format: "dd-MM-yyyy");
      update();
    }
  }

  Future<void> getRequestPickups(int pageKey) async {
    showLoadingIndicator = true;

    try {
      final filter = RequestPickupFilterModel(
        page: pageKey,
        limit: pageSize
      );
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

  requireRetry() {
    getRequestPickups(1);
  }

}