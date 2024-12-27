import 'package:css_mobile/data/model/eclaim/eclaim_count_model.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EclaimState {
  final searchField = TextEditingController();
  final PagingController<int, EclaimModel> pagingController =
      PagingController(firstPageKey: 1);

  EclaimCountModel? countModel;
  int total = 0;
  int diterima = 0;
  int ditolak = 0;
  DateTime? startDate;
  DateTime? endDate;
  List<Map<String, dynamic>>? transDate;
  String dateFilter = '0';
  String? selectedStatusClaim;

  bool isFiltered = false;
  bool isLoading = false;
}
