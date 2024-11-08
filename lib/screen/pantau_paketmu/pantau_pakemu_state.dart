import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuState extends GetxController {
  // Reactive List for countList
  final countList = RxList<dynamic>([]);

  // Reactive TextEditingControllers
  final startDateField = TextEditingController();
  final endDateField = TextEditingController();
  final searchField = TextEditingController();

  // Paging Controller
  final PagingController<int, PantauPaketmuModel> pagingController =
      PagingController(firstPageKey: 1);

  // Reactive DateTime variables
  final startDate = Rxn<DateTime>(
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day));
  final endDate = Rxn<DateTime>(DateTime.now());

  // Constant for current day (not reactive)
  final DateTime nowDay = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0);

  // Reactive String variables
  final selectedStatusKiriman = Rx<String>('Total Kiriman');
  final selectedPetugasEntry = Rxn<String>('SEMUA');
  final selectedStatusPrint = Rx<String>('SEMUA');
  final selectedTipeKiriman = Rx<String>('cod');

  // Reactive DateFilter
  final date = Rxn<String>(
      "${DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).millisecondsSinceEpoch}-${DateTime.now().millisecondsSinceEpoch}");

  // Reactive Integer variables
  var dateFilter = Rx<String>('3');
  var tipeKiriman = Rx<int>(0);
  var total = Rx<int>(0);
  var cod = Rx<int>(0);
  var noncod = Rx<int>(0);
  var codOngkir = Rx<int>(0);

  // Reactive Booleans
  var isFiltered = Rx<bool>(false);
  var isLoading = Rx<bool>(false);
  var isLoadCount = Rx<bool>(false);
  var isSelect = Rx<bool>(false);
  var isSelectAll = Rx<bool>(false);

  // Reactive Lists for Status and Officer
  var listStatusKiriman = RxList<String>([]);
  var listOfficerEntry = RxList<String>([]);
  var listTipeKiriman = RxList<String>(["cod", "non cod", "cod ongkir"]);
  var listStatusPrint =
      RxList<String>(["SEMUA", "SUDAH DIPRINT", "BELUM DIPRINT"]);

  // Reactive list for selected transactions
  var selectedTransaction = RxList<PantauPaketmuModel>([]);

  // Reactive user profile
  final basic = Rx<UserModel?>(null); // Using Rx for UserModel

  // Example function to reset filters
  void resetFilters() {
    AppLogger.i('Reset Filter');
    selectedStatusKiriman.value = 'Total Kiriman';
    selectedTipeKiriman.value = 'cod';
    startDate.value =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    endDate.value = DateTime.now();
  }
}
