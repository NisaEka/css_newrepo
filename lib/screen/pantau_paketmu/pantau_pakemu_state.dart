import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuState extends GetxController {
  // Reactive List for countList
  // final countList = RxList<dynamic>([]);
  List<PantauPaketmuCountModel> countList = [];
  List<PantauPaketmuCountModel> filteredCountList = [];

  // Reactive TextEditingControllers
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();

  final PagingController<int, PantauPaketmuListModel> pagingController =
      PagingController(firstPageKey: 1);

  // Paging Controller
  // final PagingController<int, PantauPaketmuModel> pagingController =
  //     PagingController(firstPageKey: 1);

  // Reactive DateTime variables
  DateTime? startDate;
  DateTime? endDate;
  String? dateFilter = '3';

  // Reactive String variables
  // final selectedStatusKiriman = Rx<String>('Total Kiriman');
  // final selectedPetugasEntry = Rxn<String>('SEMUA');
  // final selectedStatusPrint = Rx<String>('SEMUA');
  // final selectedTipeKiriman = Rx<String>('cod');

  String? selectedStatusKiriman;
  PetugasModel? selectedPetugasEntry;
  UserModel? basic;

  String? selectedStatusPrint;
  String? selectedTipeKiriman;

  // Reactive DateFilter
  final date = Rxn<String>(
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch}-${DateTime.now().millisecondsSinceEpoch}");

  // Reactive Integer variables
  final tipeKiriman = Rx<int>(0);

  // final total = Rx<int>(0);
  // final cod = Rx<int>(0);
  final ongkir = Rx<int>(0);

  // final codOngkir = Rx<int>(0);

  // Reactive Booleans
  // final isFiltered = Rx<bool>(false);

  // final issLoading = Rx<bool>(false);
  final isLoadCount = Rx<bool>(false);
  final isSelect = Rx<bool>(false);
  final isSelectAll = Rx<bool>(false);

  // Reactive Lists for Status and Officer
  // final listStatusKiriman = RxList<String>([]);
  final listOfficerEntry = RxList<String>([]);
  final listTipeKiriman = RxList<String>(["cod", "cod ongkir", "non cod"]);
  final listStatusPrint =
      RxList<String>(["SEMUA", "SUDAH DIPRINT", "BELUM DIPRINT"]);

  // Reactive list for selected transactions
  // final selectedTransaction = RxList<PantauPaketmuModel>([]);

  int selectedKiriman = 0;
  String transType = '';

  // String? noncod;
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
