import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LaporankuState {
  final searchField = TextEditingController();
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final PagingController<int, TicketModel> pagingController = PagingController(firstPageKey: 1);
  static const pageSize = 10;

  bool isFiltered = false;
  bool isLoading = false;
  DateTime? startDate;
  DateTime? endDate;
  String? date;
  String? status = "";
  int selectedStatus = 0;
  int total = 0;
  int onProcess = 0;
  int closed = 0;
  int waiting = 0;
  String dateFilter = '0';

  List<Map<String, String>> statusList = [
    {
      "name": "Semua".tr,
      "value": '',
    },
    {
      "name": "Belum Diproses".tr,
      "value": 'On Process',
    },
    {
      "name": "Masih Diproses".tr,
      "value": 'Reply CS',
    },
    {
      "name": "Selesai".tr,
      "value": 'Closed',
    },
  ];
}
