import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RiwayatKirimanState {
  bool? isLastScreen = Get.arguments?['isLastScreen'] ?? false;
  final searchField = TextEditingController();
  final PagingController<int, TransactionModel> pagingController =
      PagingController(firstPageKey: 1);

  int selectedKiriman = 0;
  int total = 0;
  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;
  DateTime? startDate;
  DateTime? endDate;
  String? selectedStatusKiriman;
  PetugasModel? selectedPetugasEntry;
  String? transType;
  List<Map<String, dynamic>>? transDate;
  String? dateFilter = '3';

  bool isFiltered = false;
  bool isLoading = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<TransactionModel> selectedTransaction = [];

  UserModel? basic;
  MenuModel? allow;
}
