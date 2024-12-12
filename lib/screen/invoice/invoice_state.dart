import 'package:css_mobile/data/model/invoice/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InvoiceState {
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, InvoiceModel> pagingController =
      PagingController(firstPageKey: 1);

  List<Map<String, dynamic>>? transDate;
  String dateFilter = '0';

  bool isFiltered = false;
  bool isLoading = false;
}
