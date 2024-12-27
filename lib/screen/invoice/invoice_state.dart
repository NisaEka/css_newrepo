import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_date_enum.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceState {
  final searchField = TextEditingController();

  List<Map<String, dynamic>>? transDate;
  String dateFilter = '0';

  bool isFiltered = false;
  bool isLoading = false;

  final PagingController<int, InvoiceModel> pagingController =
      PagingController(firstPageKey: Constant.defaultPage);

  final searchTextController = TextEditingController();

  String filterDateText = Constant.allDate;

  RequestPickupDateEnum selectedFilterDate = RequestPickupDateEnum.all;

  DateTime? startDate;
  DateTime? endDate;
}
