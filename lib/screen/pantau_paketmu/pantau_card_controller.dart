import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

import 'pantau_pakemu_state.dart';

class PantauCardController extends BaseController {
  final state = PantauPaketmuState();
  int selectedStatus = 0;

  @override
  void onInit() {
    super.onInit();
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);
    state.dateFilter = '3';
    state.selectedStatusKiriman = 'Total Kiriman';
    Future.wait([initData(), getCountList()]);

    applyFilter();
  }

  Future<void> initData() async {
    // if (state.isLoading) return;
    state.listStatusKiriman = [];
    state.isLoading = true;
    update();
    try {
      state.basic =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
      update();

      state.listOfficerEntry.add('SEMUA');
      state.listOfficerEntry.add(state.basic?.name ?? '');

      if (state.basic?.userType != "PEMILIK") {
        state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      }

      await pantau.getPantauStatus().then((value) {
        state.listStatusKiriman.addAll(value.data ?? []);
        update();
      });
      update();
    } catch (e, i) {
      AppLogger.e('error pantau', e, i);
      AppSnackBar.error('Gagal mengambil data'.tr);
    }
    state.isLoading = false;
    update();
  }

  Future<void> getCountList() async {
    state.isLoading = true;
    state.countList = [];
    update();
    var param = QueryModel(
      between: [
        {
          "awbDate": [
            state.startDate,
            state.endDate,
          ]
        }
      ],
      petugasEntry: (state.selectedPetugasEntry?.name == "SEMUA")
          ? ""
          : state.selectedPetugasEntry?.name ?? "",
      status: state.selectedStatusKiriman,
    );

    try {
      var responseCount = await pantau.getPantauCount(param);
      state.countList.addAll(responseCount.data ?? []);
      state.cod = responseCount.data?.first.totalCod?.toInt() ?? 0;
      state.codOngkir = responseCount.data?.first.totalCodOngkir?.toInt() ?? 0;
      state.noncod = responseCount.data?.first.totalNonCod?.toInt() ?? 0;
      update();
    } catch (e, i) {
      AppLogger.e('error pantau count', e, i);
      AppSnackBar.error('Gagal mengambil data pantau'.tr);
    }

    if (state.selectedStatusKiriman != null &&
        state.selectedStatusKiriman != "") {
      state.filteredCountList = state.countList
          .where((e) => e.status == state.selectedStatusKiriman)
          .toList();
      update();
    } else {
      state.filteredCountList = List.from(state.countList);
      update();
    }
    // await Future.delayed(const Duration(seconds: 2));
    state.isLoading = false;
    update();
  }

  applyFilter({bool? isDetail = false}) async {
    state.filteredCountList = [];
    if (state.isLoading) return;
    state.isLoading = true;
    update();
    state.transDate = [
      {
        "awbDate": [state.startDate, state.endDate],
      }
    ];
    state.date.printInfo(info: "state.date filter");
    state.date.printInfo(info: "${state.startDate} - ${state.endDate}");
    update();

    getCountList();

    AppLogger.i("filtered status : ${state.filteredCountList.length}");
    update();

    state.isLoading = false;
    update();
  }

  Future<void> resetFilter({bool? isDetail = false}) async {
    state.countList.clear();
    if (state.basic?.userType != "PEMILIK") {
      // final petugasEntry = state.listOfficerEntry.firstWhere((element) => element.id == state.basic?.id);
      state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      // state.listOfficerEntry.add(PetugasModel(name: state.basic?.name ?? ''));
    } else {
      state.selectedPetugasEntry = null;
    }
    update();

    state.selectedStatusKiriman = "Total Kiriman";
    state.selectedTipeKiriman = "cod";
    state.tipeKiriman.value = 0;
    state.isFiltered = true;
    state.searchField.clear();
    state.dateFilter = "3";
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter(isDetail: isDetail);
  }

  void setSelectedStatus(PantauPaketmuCountModel item) {
    state.selectedStatusKiriman = item.status;
    // applyFilter(isDetail: true);
    update();
  }
}
