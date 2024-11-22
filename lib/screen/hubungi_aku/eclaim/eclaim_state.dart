import 'package:css_mobile/data/model/eclaim/eclaim_count_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EclaimState {
  bool? isLastScreen = Get.arguments['isLastScreen'];
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, EclaimModel> pagingController =
      PagingController(firstPageKey: 1);

  EclaimCountModel? countModel;
  int total = 0;
  int diterima = 0;
  int ditolak = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? transDate;
  String dateFilter = '0';
  String? selectedStatusClaim = "Total";

  bool isFiltered = false;
  bool isLoading = false;

}
