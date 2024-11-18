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

  List<Account> accountList = [];
  List<Account> selectedAccountList = [];
  RxList<OriginModel> originList = <OriginModel>[].obs;
  final selectedOrigin = <OriginModel>[].obs;
  List<String> originCodes = [];
  List<BranchModel> branchList = [];
  List<BranchModel> selectedBranchList = [];
  List<String> branch = [];
  String? status;
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
      await master.getAccounts().then((value) {
        accountList.addAll(value.data ?? []);
        update();
      });

      await master.getBranches().then((value) {
        branchList.addAll(value.data ?? []);
        update();
      });

      if (isEdit) {
        var resp = await setting.getOfficerByID(data?.id ?? '');
        dataPetugas = resp.data ?? PetugasModel();
        update();
        loadOrigin(dataPetugas.branches ?? []);
        dataPetugas.accounts?.forEach((account) {
          selectedAccountList.add((accountList.where((e) => e.accountId == account.accountId).isNotEmpty
              ? (accountList.where((e) => e.accountId == account.accountId).first)
              : Account()));
        });
        dataPetugas.branches?.forEach((branch) {
          selectedBranchList.add(
            branchList.where((e) => e.branchCode == branch.branchCode).isNotEmpty ? branchList.where((e) => e.branchCode == branch.branchCode).first : BranchModel(),
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
        alamat.text = dataPetugas.branch ?? '';
        zipCode.text = dataPetugas.zipCode ?? '';
        status = dataPetugas.status ?? 'N';

        profilku = dataPetugas.menu?.profil == "Y";
        fasilitas = dataPetugas.menu?.fasilitas == "Y";
        katasandi = dataPetugas.menu?.katasandi == "Y";
        beranda = dataPetugas.menu?.beranda == "Y";
        buatPesanan = dataPetugas.menu?.buatPesanan == "Y" || dataPetugas.menu?.paketmuInput == "Y";
        lacakPesanan = dataPetugas.menu?.lacakPesanan == "Y" || dataPetugas.menu?.paketmuLacak == "Y";
        mintaDijemput = dataPetugas.menu?.mintaDijemput == "Y" || dataPetugas.menu?.paketmuMintaDijemput == "Y";
        serahTerima = dataPetugas.menu?.serahTerima == "Y" || dataPetugas.menu?.paketmuSerahTerima == "Y";
        saldo = dataPetugas.menu?.saldo == "Y" || dataPetugas.menu?.keuanganJneMoney == "Y";
        uangCod = dataPetugas.menu?.uangCod == "Y" || dataPetugas.menu?.keuanganCod == "Y";
        tagihan = dataPetugas.menu?.tagihan == "Y" || dataPetugas.menu?.keuanganTagihan == "Y";
        bonus = dataPetugas.menu?.bonus == "Y" || dataPetugas.menu?.keuanganBonus == "y";
        pantauPaketmu = dataPetugas.menu?.pantauPaketmu == "Y";
        laporan = dataPetugas.menu?.laporan == "Y";
        eclaim = dataPetugas.menu?.eclaim == "Y";
        tema = dataPetugas.menu?.tema == "Y" || dataPetugas.menu?.pengaturanTema == "Y";
        label = dataPetugas.menu?.label == "Y" || dataPetugas.menu?.pengaturanLabel == "Y";
        petugas = dataPetugas.menu?.petugas == "Y" || dataPetugas.menu?.pengaturanPetugas == "Y";
        riwayatPesanan = dataPetugas.menu?.riwayatPesanan == "Y" || dataPetugas.menu?.paketmuRiwayat == "Y";
        cekOngkir = dataPetugas.menu?.cekOngkir == "Y";
        semuaTransaksi = dataPetugas.menu?.semuaTransaksi == "Y";
        hapusPesanan = dataPetugas.menu?.hapusPesanan == "Y";
        semuaHapus = dataPetugas.menu?.semuaHapus == "Y";
        cetakPesanan = dataPetugas.menu?.cetakPesanan == "Y" || dataPetugas.menu?.paketmuPrint == "Y";
        monitoringAgg = dataPetugas.menu?.monitoringAgg == "Y" || dataPetugas.menu?.keuanganAggregasi == "Y";
        monitoringAggMinus = dataPetugas.menu?.monitoringAggMinus == "Y" || dataPetugas.menu?.keuanganAggregasiMinus == "Y";
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
        isIn: '[{"branchCode" : [${branch.map((item) => '"$item"').join(', ')}]}]',
      ))
          .then((value) {
        originList.addAll(value.data ?? []);
        update();
      }).then((value) {
        if (dataPetugas.origins?.isNotEmpty ?? false) {
          dataPetugas.origins?.forEach((origin) {
            selectedOrigin.add(originList.where((e) => e.originCode == origin.originCode).isNotEmpty
                ? originList.where((e) => e.originCode == origin.originCode).first
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
    for (var value in originCodes) {
      selectedOrigin.add(originList.where((e) => e.originCode == value).isNotEmpty ? originList.where((e) => e.originCode == value).first : OriginModel());
    }
    isLoadOrigin = false;
    update();
  }

  Future<void> saveOfficer() async {
    isLoading = true;
    update();
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
                profil: profilku ? "Y" : null,
                fasilitas: fasilitas ? "Y" : null,
                katasandi: katasandi ? "Y" : null,
                beranda: beranda ? "Y" : null,
                buatPesanan: buatPesanan ? "Y" : null,
                paketmuInput: buatPesanan ? "Y" : null,
                riwayatPesanan: riwayatPesanan ? "Y" : null,
                paketmuRiwayat: riwayatPesanan ? "Y" : null,
                lacakPesanan: lacakPesanan ? "Y" : null,
                paketmuLacak: lacakPesanan ? "Y" : null,
                mintaDijemput: mintaDijemput ? "Y" : null,
                serahTerima: serahTerima ? "Y" : null,
                cetakPesanan: cetakPesanan ? "Y" : null,
                paketmuPrint: cetakPesanan ? "Y" : null,
                hapusPesanan: hapusPesanan ? "Y" : null,
                saldo: saldo ? "Y" : null,
                uangCod: uangCod ? "Y" : null,
                keuanganCod: uangCod ? "Y" : null,
                keuanganBonus: saldo ? "Y" : null,
                keuanganAggregasi: monitoringAgg ? "Y" : null,
                keuanganAggregasiMinus: monitoringAggMinus ? "Y" : null,
                monitoringAgg: monitoringAgg ? "Y" : null,
                monitoringAggMinus: monitoringAggMinus ? "Y" : null,
                tagihan: tagihan ? "Y" : null,
                bonus: bonus ? "Y" : null,
                pantauPaketmu: pantauPaketmu ? "Y" : null,
                laporan: laporan ? "Y" : null,
                eclaim: eclaim ? "Y" : null,
                hubungiEclaim: eclaim ? "Y" : null,
                cekOngkir: cekOngkir ? "Y" : null,
                label: label ? "Y" : null,
                petugas: petugas ? "Y" : null,
                pengaturanLabel: label ? "Y" : null,
                pengaturanPetugas: petugas ? "Y" : null,
                pengaturanTema: tema ? "Y" : null,
                semuaHapus: semuaHapus ? "Y" : null,
                semuaTransaksi: semuaTransaksi ? "Y" : null,
                tema: tema ? "Y" : null,
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
                    AppSnackBar.error(value.error[0]),
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
              password: password.text,
              address: alamat.text,
              zipCode: zipCode.text,
              menu: MenuModel(
                profil: profilku ? "Y" : null,
                fasilitas: fasilitas ? "Y" : null,
                katasandi: katasandi ? "Y" : null,
                beranda: beranda ? "Y" : null,
                buatPesanan: buatPesanan ? "Y" : null,
                paketmuInput: buatPesanan ? "Y" : null,
                riwayatPesanan: riwayatPesanan ? "Y" : null,
                paketmuRiwayat: riwayatPesanan ? "Y" : null,
                lacakPesanan: lacakPesanan ? "Y" : null,
                paketmuLacak: lacakPesanan ? "Y" : null,
                mintaDijemput: mintaDijemput ? "Y" : null,
                serahTerima: serahTerima ? "Y" : null,
                cetakPesanan: cetakPesanan ? "Y" : null,
                paketmuPrint: cetakPesanan ? "Y" : null,
                hapusPesanan: hapusPesanan ? "Y" : null,
                saldo: saldo ? "Y" : null,
                uangCod: uangCod ? "Y" : null,
                keuanganCod: uangCod ? "Y" : null,
                keuanganBonus: saldo ? "Y" : null,
                keuanganAggregasi: monitoringAgg ? "Y" : null,
                keuanganAggregasiMinus: monitoringAggMinus ? "Y" : null,
                monitoringAgg: monitoringAgg ? "Y" : null,
                monitoringAggMinus: monitoringAggMinus ? "Y" : null,
                tagihan: tagihan ? "Y" : null,
                bonus: bonus ? "Y" : null,
                pantauPaketmu: pantauPaketmu ? "Y" : null,
                laporan: laporan ? "Y" : null,
                eclaim: eclaim ? "Y" : null,
                hubungiEclaim: eclaim ? "Y" : null,
                cekOngkir: cekOngkir ? "Y" : null,
                label: label ? "Y" : null,
                petugas: petugas ? "Y" : null,
                pengaturanLabel: label ? "Y" : null,
                pengaturanPetugas: petugas ? "Y" : null,
                pengaturanTema: tema ? "Y" : null,
                semuaHapus: semuaHapus ? "Y" : null,
                semuaTransaksi: semuaTransaksi ? "Y" : null,
                tema: tema ? "Y" : null,
              ),
              transaction: Transaction(
                show: "RESTRICTED",
                delete: "RESTRICTED",
              ),
              accounts: selectedAccountList,
              origins: originCodes.toSet().toList(),
            ),
          )
          .then((value) => Get.back());
    } catch (e) {
      AppLogger.e('error updateOfficer', e);
      AppSnackBar.error('Bad Request'.tr);
    }
    isLoading = false;
    update();
  }
}
