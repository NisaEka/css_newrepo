import 'dart:convert';
import 'dart:core';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/query_count_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class TambahPetugasController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final namaPetugas = TextEditingController();
  final alamatEmail = TextEditingController();
  final nomorTelepon = TextEditingController();
  final password = TextEditingController();
  final passwordConfirm = TextEditingController();
  final alamat = TextEditingController();
  final zipCode = TextEditingController();
  final multiSelectKey = GlobalKey<FormFieldState>();

  bool isEdit = Get.arguments['isEdit'];
  bool isEditPassword = false;
  PetugasModel? data = Get.arguments['data'];
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isCountSelectedAccountNA = false;
  bool isCountAllAccountNA = false;
  bool isObscurePassword = true;
  bool isObscurePasswordConfirm = true;
  UserModel? basic;
  CcrfProfileModel? ccrf;
  Widget showIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );
  Widget showConfirmIcon = const Icon(
    Icons.remove_red_eye,
    color: greyDarkColor1,
  );

  bool profilku = false;
  bool fasilitas = false;
  bool katasandi = false;
  bool beranda = false;
  bool buatPesanan = false;
  bool lacakPesanan = false;
  bool mintaDijemput = false;
  bool serahTerima = false;
  bool saldo = false;
  bool uangCod = false;
  bool tagihan = false;
  bool bonus = false;
  bool pantauPaketmu = false;
  bool laporan = false;
  bool eclaim = false;
  bool tema = false;
  bool label = false;
  bool petugas = false;
  bool riwayatPesanan = false;
  bool cekOngkir = false;
  bool semuaTransaksi = false;
  bool hapusPesanan = false;
  bool semuaHapus = false;
  bool cetakPesanan = false;
  bool monitoringAgg = false;
  bool monitoringAggMinus = false;
  bool laporanReturn = false;
  bool summaryOrigin = false;
  bool summaryDestination = false;

  List<Account> accountList = [];
  List<Account> selectedAccountList = [];
  RxList<OriginModel> originList = <OriginModel>[].obs;
  RxList<OriginModel> selectedOrigin = <OriginModel>[].obs;
  List<String> originCodes = [];
  List<BranchModel> branchList = [];
  List<BranchModel> selectedBranchList = [];
  List<String> branch = [];
  String? status;
  int? countSelectedAccountNA = 0;
  int? countAllAccountNA = 0;
  PetugasModel dataPetugas = PetugasModel();

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  String? locale;

  Future<void> setLocale() async {
    locale = await storage.readString(StorageCore.localeApp);
    update();
    ValidationBuilder.setLocale(locale!);
  }

  Future<void> initData() async {
    isLoading = true;
    accountList = [];
    originList.clear();
    branchList = [];
    update();
    try {
      await master
          .getAccounts(QueryModel(table: true, limit: 0, sort: [
        {"accountNumber": "asc"}
      ]))
          .then((value) {
        accountList.addAll(value.data ?? []);
        update();
      });

      getCountAllAccountNA();

      await master
          .getBranches(QueryParamModel(table: true, limit: 0))
          .then((value) {
        branchList.addAll(value.data ?? []);
        update();
      });

      if (isEdit) {
        var resp = await setting.getOfficerByID(data?.id ?? '');
        dataPetugas = resp.data ?? PetugasModel();
        update();
        loadOrigin(dataPetugas.branches ?? []);
        dataPetugas.accounts?.forEach((account) {
          selectedAccountList.add((accountList
                  .where((e) => e.accountId == account.accountId)
                  .isNotEmpty
              ? (accountList
                  .where((e) => e.accountId == account.accountId)
                  .first)
              : Account()));
        });
        getCountSelectedAccountNA();
        dataPetugas.branches?.forEach((branch) {
          selectedBranchList.add(
            branchList
                    .where((e) => e.branchCode == branch.branchCode)
                    .isNotEmpty
                ? branchList
                    .where((e) => e.branchCode == branch.branchCode)
                    .first
                : BranchModel(),
          );
          update();
        });
        // selectedOrigin = dataPetugas.origins ?? [];

        dataPetugas.origins?.forEach((origin) {
          originCodes.add(origin.originCode ?? '');
          // selectedOrigin.add(originList.where((e) => e.originCode == origin.originCode).first);
          update();
        });

        namaPetugas.text = dataPetugas.name ?? '';
        alamatEmail.text = dataPetugas.email ?? '';
        nomorTelepon.text = dataPetugas.phone ?? '';
        status = dataPetugas.status ?? '';
        alamat.text = dataPetugas.address ?? '';
        zipCode.text = dataPetugas.zipCode ?? '';
        status = dataPetugas.status ?? 'N';

        profilku = dataPetugas.menu?.profil == "Y";
        fasilitas = dataPetugas.menu?.fasilitas == "Y";
        katasandi = dataPetugas.menu?.katasandi == "Y";
        beranda = dataPetugas.menu?.beranda == "Y";
        buatPesanan = dataPetugas.menu?.buatPesanan == "Y" ||
            dataPetugas.menu?.paketmuInput == "Y";
        lacakPesanan = dataPetugas.menu?.lacakPesanan == "Y" ||
            dataPetugas.menu?.paketmuLacak == "Y";
        mintaDijemput = dataPetugas.menu?.mintaDijemput == "Y" ||
            dataPetugas.menu?.paketmuMintadijemput == "Y";
        serahTerima = dataPetugas.menu?.serahTerima == "Y" ||
            dataPetugas.menu?.paketmuSerahterima == "Y";
        saldo = dataPetugas.menu?.saldo == "Y" ||
            dataPetugas.menu?.keuanganJneMoney == "Y";
        uangCod = dataPetugas.menu?.uangCod == "Y" ||
            dataPetugas.menu?.keuanganCod == "Y";
        tagihan = dataPetugas.menu?.tagihan == "Y" ||
            dataPetugas.menu?.keuanganTagihan == "Y";
        bonus = dataPetugas.menu?.bonus == "Y" ||
            dataPetugas.menu?.keuanganBonus == "y";
        pantauPaketmu = dataPetugas.menu?.pantauPaketmu == "Y";
        laporan = dataPetugas.menu?.laporan == "Y";
        eclaim = dataPetugas.menu?.eclaim == "Y";
        tema = dataPetugas.menu?.tema == "Y" ||
            dataPetugas.menu?.pengaturanTema == "Y";
        label = dataPetugas.menu?.label == "Y" ||
            dataPetugas.menu?.pengaturanLabel == "Y";
        petugas = dataPetugas.menu?.petugas == "Y" ||
            dataPetugas.menu?.pengaturanPetugas == "Y";
        riwayatPesanan = dataPetugas.menu?.riwayatPesanan == "Y" ||
            dataPetugas.menu?.paketmuRiwayat == "Y";
        cekOngkir = dataPetugas.menu?.cekOngkir == "Y";
        semuaTransaksi = dataPetugas.menu?.semuaTransaksi == "Y";
        hapusPesanan = dataPetugas.menu?.hapusPesanan == "Y";
        semuaHapus = dataPetugas.menu?.semuaHapus == "Y";
        cetakPesanan = dataPetugas.menu?.cetakPesanan == "Y" ||
            dataPetugas.menu?.paketmuPrint == "Y";
        monitoringAgg = dataPetugas.menu?.monitoringAgg == "Y" ||
            dataPetugas.menu?.keuanganAggregasi == "Y";
        monitoringAggMinus = dataPetugas.menu?.monitoringAggMinus == "Y" ||
            dataPetugas.menu?.keuanganAggregasiMinus == "Y";
        laporanReturn = dataPetugas.menu?.laporanReturn == "Y";
        summaryOrigin = dataPetugas.menu?.summaryOrigin == "Y";
        summaryDestination = dataPetugas.menu?.summaryDestination == "Y";
        update();
      } else {
        basic = UserModel.fromJson(
          await storage.readData(StorageCore.basicProfile),
        );
        ccrf = CcrfProfileModel.fromJson(
          await storage.readData(StorageCore.ccrfProfile),
        );
        alamat.text = basic?.address ?? '';
        zipCode.text = ccrf?.generalInfo?.zipCode ?? '';
        update();
      }
    } catch (e, i) {
      AppLogger.e('error initData tambah petugas $e, $i');
    }

    isLoading = false;
    update();
  }

  Future<void> getCountSelectedAccountNA() async {
    isCountSelectedAccountNA = true;
    update();
    try {
      await master
          .getAccountCount(CountQueryModel(
        where: [
          {"accountCategory": "NA"}
        ],
        inValues: [
          {
            "accountNumber": selectedAccountList.isNotEmpty
                ? selectedAccountList.map((e) => e.accountNumber).toList()
                : [""]
          }
        ],
      ))
          .then((value) {
        AppLogger.i("value getCountSelectedAccountNA ${value.data}");
        countSelectedAccountNA = value.data ?? 0;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error getCountSelectedAccountNA $e, $i');
    }
    isCountSelectedAccountNA = false;
    update();
  }

  Future<void> getCountAllAccountNA() async {
    isCountAllAccountNA = true;
    update();
    try {
      await master
          .getAccountCount(CountQueryModel(
        where: [
          {"accountCategory": "NA"}
        ],
      ))
          .then((value) {
        AppLogger.i("value getCountAllAccountNA ${value.data}");
        countAllAccountNA = value.data ?? 0;
        update();
      });
    } catch (e, i) {
      AppLogger.e('error getCountAllAccountNA $e, $i');
    }
    isCountAllAccountNA = false;
    update();
  }

  Future<void> loadOrigin(List<BranchModel> branches) async {
    originList.clear();
    selectedOrigin.clear();
    branch = [];
    isLoadOrigin = true;
    update();
    for (var element in branches) {
      branch.add(element.branchCode ?? '');
      update();
    }
    try {
      await master
          .getOrigins(QueryParamModel(
        table: true,
        limit: 0,
        where: jsonEncode([
          {"originStatus": "Y"}
        ]),
        sort: jsonEncode([
          {"originCode": "asc"}
        ]),
        isIn: jsonEncode([
          {"branchCode": branch.map((e) => e).toList()}
        ]),
      ))
          .then((value) {
        originList.addAll(value.data ?? []);
        update();
      }).then((value) {
        if (dataPetugas.origins?.isNotEmpty ?? false) {
          dataPetugas.origins?.forEach((origin) {
            selectedOrigin.add(originList
                    .where((e) => e.originCode == origin.originCode)
                    .isNotEmpty
                ? originList
                    .where((e) => e.originCode == origin.originCode)
                    .first
                : OriginModel());
            update();
          });

          update();
        } else {
          selectedOrigin.clear();
        }
      });
      update();
    } catch (e, i) {
      AppLogger.e('error loadOrigin $e, $i');
    }
    // for (var value in originCodes) {
    //   selectedOrigin.add(
    //       originList.where((e) => e.originCode == value).isNotEmpty
    //           ? originList.where((e) => e.originCode == value).first
    //           : OriginModel());
    // }
    isLoadOrigin = false;
    update();
  }

  Future<void> saveOfficer() async {
    isLoading = true;
    update();
    originCodes.clear();
    for (var element in selectedOrigin) {
      originCodes.add(element.originCode ?? '');
      update();
    }
    try {
      await setting
          .postOfficer(
            DataPetugasModel(
              name: namaPetugas.text,
              email: alamatEmail.text,
              phone: nomorTelepon.text,
              password: password.text,
              address: alamat.text,
              zipCode: zipCode.text,
              menu: MenuModel(
                profil: profilku ? "Y" : "N",
                fasilitas: fasilitas ? "Y" : "N",
                katasandi: katasandi ? "Y" : "N",
                beranda: beranda ? "Y" : "N",
                buatPesanan: buatPesanan ? "Y" : "N",
                paketmuInput: buatPesanan ? "Y" : "N",
                riwayatPesanan: riwayatPesanan ? "Y" : "N",
                paketmuRiwayat: riwayatPesanan ? "Y" : "N",
                lacakPesanan: lacakPesanan ? "Y" : "N",
                paketmuLacak: lacakPesanan ? "Y" : "N",
                mintaDijemput: mintaDijemput ? "Y" : "N",
                serahTerima: serahTerima ? "Y" : "N",
                cetakPesanan: cetakPesanan ? "Y" : "N",
                paketmuPrint: cetakPesanan ? "Y" : "N",
                hapusPesanan: hapusPesanan ? "Y" : "N",
                saldo: saldo ? "Y" : "N",
                uangCod: uangCod ? "Y" : "N",
                keuanganCod: uangCod ? "Y" : "N",
                keuanganBonus: saldo ? "Y" : "N",
                keuanganAggregasi: monitoringAgg ? "Y" : "N",
                keuanganAggregasiMinus: monitoringAggMinus ? "Y" : "N",
                monitoringAgg: monitoringAgg ? "Y" : "N",
                monitoringAggMinus: monitoringAggMinus ? "Y" : "N",
                tagihan: tagihan ? "Y" : "N",
                bonus: bonus ? "Y" : "N",
                pantauPaketmu: pantauPaketmu ? "Y" : "N",
                laporan: laporan ? "Y" : "N",
                eclaim: eclaim ? "Y" : "N",
                hubungiEclaim: eclaim ? "Y" : "N",
                cekOngkir: cekOngkir ? "Y" : "N",
                label: label ? "Y" : "N",
                petugas: petugas ? "Y" : "N",
                pengaturanLabel: label ? "Y" : "N",
                pengaturanPetugas: petugas ? "Y" : "N",
                pengaturanTema: tema ? "Y" : "N",
                semuaHapus: semuaHapus ? "Y" : "N",
                semuaTransaksi: semuaTransaksi ? "Y" : "N",
                tema: tema ? "Y" : "N",
                laporanReturn: laporanReturn ? "Y" : "N",
                summaryOrigin: summaryOrigin ? "Y" : "N",
                summaryDestination: summaryDestination ? "Y" : "N",
              ),
              transaction: Transaction(
                show: "RESTRICTED",
                delete: "RESTRICTED",
              ),
              accounts: selectedAccountList,
              origins: originCodes.toSet().toList(),
            ),
          )
          .then((value) => {
                if (value.code == 201)
                  {Get.back()}
                else if (value.code == 409)
                  {
                    AppSnackBar.error(
                        'Alamat email atau nomor telepon sudah digunakan'.tr)
                  }
                else
                  {
                    AppSnackBar.error(
                        value.message ?? value.error ?? 'Bad Request'.tr),
                  }
              });
    } catch (e, i) {
      AppLogger.e('error saveOfficer $e, $i');
      AppSnackBar.error('Bad Request'.tr);
    }

    isLoading = false;
    update();
  }

  Future<void> updateOfficer() async {
    isLoading = true;
    update();
    originCodes.clear();
    for (var element in selectedOrigin) {
      originCodes.add(element.originCode ?? '');
      update();
    }
    try {
      await setting
          .putOfficer(
            DataPetugasModel(
              id: data?.id ?? '',
              name: namaPetugas.text,
              email: alamatEmail.text,
              phone: nomorTelepon.text,
              password: password.text.isNotEmpty ? password.text : null,
              address: alamat.text,
              zipCode: zipCode.text,
              status: status,
              menu: MenuModel(
                profil: profilku ? "Y" : "N",
                fasilitas: fasilitas ? "Y" : "N",
                katasandi: katasandi ? "Y" : "N",
                beranda: beranda ? "Y" : "N",
                buatPesanan: buatPesanan ? "Y" : "N",
                paketmuInput: buatPesanan ? "Y" : "N",
                riwayatPesanan: riwayatPesanan ? "Y" : "N",
                paketmuRiwayat: riwayatPesanan ? "Y" : "N",
                lacakPesanan: lacakPesanan ? "Y" : "N",
                paketmuLacak: lacakPesanan ? "Y" : "N",
                mintaDijemput: mintaDijemput ? "Y" : "N",
                serahTerima: serahTerima ? "Y" : "N",
                cetakPesanan: cetakPesanan ? "Y" : "N",
                paketmuPrint: cetakPesanan ? "Y" : "N",
                hapusPesanan: hapusPesanan ? "Y" : "N",
                saldo: saldo ? "Y" : "N",
                uangCod: uangCod ? "Y" : "N",
                keuanganCod: uangCod ? "Y" : "N",
                keuanganBonus: saldo ? "Y" : "N",
                keuanganAggregasi: monitoringAgg ? "Y" : "N",
                keuanganAggregasiMinus: monitoringAggMinus ? "Y" : "N",
                monitoringAgg: monitoringAgg ? "Y" : "N",
                monitoringAggMinus: monitoringAggMinus ? "Y" : "N",
                tagihan: tagihan ? "Y" : "N",
                bonus: bonus ? "Y" : "N",
                pantauPaketmu: pantauPaketmu ? "Y" : "N",
                laporan: laporan ? "Y" : "N",
                eclaim: eclaim ? "Y" : "N",
                hubungiEclaim: eclaim ? "Y" : "N",
                cekOngkir: cekOngkir ? "Y" : "N",
                label: label ? "Y" : "N",
                petugas: petugas ? "Y" : "N",
                pengaturanLabel: label ? "Y" : "N",
                pengaturanPetugas: petugas ? "Y" : "N",
                pengaturanTema: tema ? "Y" : "N",
                semuaHapus: semuaHapus ? "Y" : "N",
                semuaTransaksi: semuaTransaksi ? "Y" : "N",
                tema: tema ? "Y" : "N",
                laporanReturn: laporanReturn ? "Y" : "N",
                summaryOrigin: summaryOrigin ? "Y" : "N",
                summaryDestination: summaryDestination ? "Y" : "N",
              ),
              transaction: Transaction(
                show: "RESTRICTED",
                delete: "RESTRICTED",
              ),
              accounts: selectedAccountList,
              origins: originCodes.toSet().toList(),
            ),
          )
          .then((value) => {
                if (value.code == 200)
                  {Get.back()}
                else
                  {
                    AppSnackBar.error(
                        value.message ?? value.error ?? 'Bad Request'.tr),
                  }
              });
    } catch (e, i) {
      AppLogger.e('error updateOfficer $e, $i');
      AppSnackBar.error('Bad Request'.tr);
    }
    isLoading = false;
    update();
  }
}
