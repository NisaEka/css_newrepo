import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/detail/detail_transaction_screen.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:get/get.dart';

class RiwayatKirimanController extends BaseController {
  final state = RiwayatKirimanState();
  static const pageSize = 10;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
    if (state.statusFilter != null) {
      state.selectedStatusKiriman = state.statusFilter;
      state.startDate = state.startDateFilter ??
          DateTime.now()
              .subtract(const Duration(days: 6))
              .copyWith(hour: 0, minute: 0);
      state.endDate = state.endDateFilter ?? DateTime.now();
      state.dateFilter = state.dateF ?? '2';
      if (state.tipeFilter == 'COD ONGKIR') {
        state.selectedKiriman = 3;
        state.transType = 'COD ONGKIR';
      } else if (state.tipeFilter == 'NON COD') {
        state.selectedKiriman = 2;
        state.transType = 'NON COD';
      } else if (state.tipeFilter == 'COD') {
        state.selectedKiriman = 1;
        state.transType = 'COD';
      } else if (state.tipeFilter == 'ALL') {
        state.selectedKiriman = 0;
        state.transType = '';
      }
      update();
    }
    state.transDate = [
      {
        "awbDate": [state.startDate, state.endDate]
      }
    ];
    state.pagingController.addPageRequestListener((pageKey) {
      getTransaction(pageKey);
    });
    // categoryList();
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    applyFilter();
  }

  void cekAllowance() {
    if (state.basic?.userType != "PEMILIK") {
      // final petugasEntry = state.listOfficerEntry.firstWhere((element) => element.id == state.basic?.id);
      state.selectedPetugasEntry = PetugasModel(name: state.basic?.name);
      // state.listOfficerEntry.add(PetugasModel(name: state.basic?.name ?? ''));
    }
    update();
    state.pagingController.refresh();
    transactionCount();
    // state.pagingController.refresh();
    // transactionCount();
  }

  Future<void> transactionCount() async {
    try {
      await transaction
          .getTransactionCount(
        '',
        state.transDate ?? [],
        state.selectedStatusKiriman ?? '',
        state.searchField.text,
        state.selectedPetugasEntry?.name ?? '',
      )
          .then((value) {
        state.total = value.data?.total?.toInt() ?? 0;
        state.cod = value.data?.totalCod?.toInt() ?? 0;
        state.noncod = value.data?.totalNonCod?.toInt() ?? 0;
        state.codOngkir = value.data?.totalCodOngkir?.toInt() ?? 0;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error transactionCount $e, $i');
    }
  }

  Future<void> initData() async {
    // transactionList = [];
    state.selectedTransaction = [];
    state.listStatusKiriman = [];
    state.allow =
        MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
    state.basic =
        UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    update();

    try {
      await transaction.getTransactionStatus().then((value) {
        state.listStatusKiriman.addAll(value.data ?? []);
        update();
      });

      update();
    } catch (e) {
      AppLogger.e('error initData riwayat kiriman $e');
    }

    cekAllowance();
  }

  Future<void> getTransaction(int page) async {
    state.isLoading = true;

    try {
      final trans = await transaction.getAllTransaction(
        page,
        pageSize,
        state.transType ?? '',
        state.transDate ?? [],
        state.selectedStatusKiriman ?? '',
        state.searchField.text,
        state.selectedPetugasEntry?.name ?? '',
      );

      final isLastPage =
          (trans.meta?.currentPage ?? 0) == (trans.meta?.lastPage ?? 0);
      if (isLastPage) {
        state.pagingController.appendLastPage(trans.data ?? []);
        if (state.isSelect) {
          state.selectedTransaction
              .addAll(state.pagingController.itemList ?? []);
        }
      } else {
        final nextPageKey = page + 1;
        state.pagingController.appendPage(trans.data ?? [], nextPageKey);
        if (state.isSelect) {
          state.selectedTransaction
              .addAll(state.pagingController.itemList ?? []);
        }
      }

      // await setting.getSettingLabel().then(
      //   (value) async {
      //     await storage.writeString(
      //       StorageCore.transactionLabel,
      //       value.data?.labels?.where((e) => e.enabled ?? false).first.name,
      //     );
      //     await storage.writeString(StorageCore.shippingCost,
      //         value.data?.priceLabel != '0' ? "PUBLISH" : "HIDE");
      //   },
      // );
    } catch (e) {
      AppLogger.e('error getTransaction $e');
      state.pagingController.error = e;
    }

    state.isLoading = false;
    update();
  }

  void resetFilter() {
    // // if (state.basic?.userType == "PEMILIK") {
    state.startDate = DateTime.now().copyWith(hour: 0, minute: 0);
    state.endDate = DateTime.now().copyWith(hour: 23, minute: 59, second: 59);

    state.selectedPetugasEntry = null;
    state.selectedStatusKiriman = null;
    // state.isFiltered = false;
    state.searchField.clear();
    update();
    applyFilter();
  }

  void selectAll(bool value) {
    state.isSelectAll = value;
    // state.selectedTransaction = value ? transactionList : [];
    state.selectedTransaction =
        value ? state.pagingController.itemList ?? [] : [];
    update();
    state.selectedTransaction.isEmpty ? state.isSelect = false : null;
    update();
  }

  void select(TransactionModel item) {
    state.selectedTransaction.add(item);
    state.isSelect = true;
    update();
  }

  void unselect(TransactionModel item) {
    if (state.isSelect) {
      if (state.selectedTransaction.where((e) => e == item).isNotEmpty) {
        state.selectedTransaction.removeWhere((e) => e == item);
        update();
        if (state.selectedTransaction.isEmpty) {
          state.isSelect = false;
        }
      } else {
        state.selectedTransaction.add(item);
      }
      update();
      // state.selectedTransaction.length == transactionList.length ? state.isSelectAll = true : state.isSelectAll = false;
      state.selectedTransaction.length ==
              state.pagingController.itemList?.length
          ? state.isSelectAll = true
          : state.isSelectAll = false;
    } else {
      Get.to(() => const DetailTransactionScreen(), arguments: {
        'awb': item.awb,
        'data': item,
      })?.then((_) => applyFilter());
    }
  }

  Future<void> delete(TransactionModel item) async {
    try {
      await transaction.deleteTransaction(item.awb.toString()).then((value) {
        if (value.code == 400) {
          AppSnackBar.error(value.message!.tr);
        } else {
          state.pagingController.refresh();
          initData();
          update();
        }
      });
    } catch (e) {
      AppLogger.e('error delete transaction $e');
      AppSnackBar.error('Bad Request'.tr);
    }

    update();
  }

  @override
  void dispose() {
    super.dispose();
    state.pagingController.dispose();
  }

  applyFilter() {
    state.isFiltered = true;
    // state.transType = '';
    // state.selectedKiriman = 0;
    if (state.startDate != null && state.endDate != null) {
      state.transDate = [
        {
          "createdDateSearch": ["${state.startDate}", "${state.endDate}"]
        }
      ];
    }
    update();
    state.pagingController.refresh();
    transactionCount();
    update();
  }
}
