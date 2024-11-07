import 'package:css_mobile/data/model/dashboard/count_card_model.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuState {
  List<CountCardModel> pantauCountList = [];

  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();
  final PagingController<int, PantauPaketmuModel> pagingController =
      PagingController(firstPageKey: 1);

  DateTime? startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? endDate = DateTime.now();
  final DateTime nowDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);
  String? selectedStatusKiriman = 'SEMUA';
  String? selectedPetugasEntry = 'SEMUA';
  String? selectedStatusPrint = "SEMUA";
  String? selectedTipeKiriman = "SEMUA";
  String? date =
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch}-${DateTime.now().millisecondsSinceEpoch}";
  String dateFilter = '3';
  int tipeKiriman = 0;
  int total = 0;
  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;

  bool isFiltered = false;
  bool isLoading = false;
  bool isLoadCount = false;
  bool isSelect = false;
  bool isSelectAll = false;

  List<String> listStatusKiriman = [];
  List<String> listOfficerEntry = [];
  List<String> listTipeKiriman = ["SEMUA", "COD", "NON COD", "COD ONGKIR"];
  List<String> listStatusPrint = ["SEMUA", "SUDAH DIPRINT", "BELUM DIPRINT"];
  List<PantauPaketmuModel> selectedTransaction = [];

  List<dynamic> countList = [];

  UserModel? basic;
}
