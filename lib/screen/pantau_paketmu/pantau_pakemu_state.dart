import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuState {
  String? statusFilter = Get.arguments?['status'];
  DateTime? startDateFilter = Get.arguments?['startDate'];
  DateTime? endDateFilter = Get.arguments?['endDate'];
  String? dateF = Get.arguments?['dateFilter'];
  String? tipeFilter = Get.arguments?['tipe'];

  List<PantauPaketmuCountModel> countList = [];
  List<PantauPaketmuCountModel> filteredCountList = [];

  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();

  final PagingController<int, PantauPaketmuListModel> pagingController =
      PagingController(firstPageKey: 1);

  DateTime? startDate;
  DateTime? endDate;
  String? dateFilter = '3';

  String? selectedStatusKiriman;
  PetugasModel? selectedPetugasEntry;
  UserModel? basic;

  String? selectedStatusPrint;
  String? selectedTipeKiriman = 'cod';

  final date = Rxn<String>(
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch}-${DateTime.now().millisecondsSinceEpoch}");

  final tipeKiriman = Rx<int>(0);
  final ongkir = Rx<int>(0);
  final isLoadCount = Rx<bool>(false);
  final isSelect = Rx<bool>(false);
  final isSelectAll = Rx<bool>(false);

  final listOfficerEntry = RxList<String>([]);
  final listTipeKiriman = RxList<String>(["cod", "cod ongkir", "non cod"]);
  final listStatusPrint =
      RxList<String>(["SEMUA", "SUDAH DIPRINT", "BELUM DIPRINT"]);

  int selectedKiriman = 0;
  String transType = '';

  int cod = 0;
  int noncod = 0;
  int codOngkir = 0;
  bool isLoading = false;
  bool isFiltered = true;
  List<Map<String, dynamic>>? transDate;
  List<PantauPaketmuCountModel> selectedPantauPaketmu = [];
  List<PantauPaketmuListModel> selectedTransaction = [];
  List<String> listStatusKiriman = [];
}
