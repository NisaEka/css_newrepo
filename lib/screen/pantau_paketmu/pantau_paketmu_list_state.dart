import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuListState extends GetxController {
  final PagingController<int, PantauPaketmuListModel> pagingController =
      PagingController(firstPageKey: 1);

  var isLoadingPantauItems = false.obs; // Loading state
  final searchField = TextEditingController();

  final selectedStatusKiriman = Rx<String>('Total Kiriman');
  final selectedPetugasEntry = Rxn<String>('SEMUA');

  List<PantauPaketmuListModel> selectedTransaction = [];

  // Method reset
  void resetState() {
    selectedStatusKiriman.value = 'Total Kiriman';
    selectedPetugasEntry.value = 'SEMUA';
    pagingController.refresh();
  }
}
