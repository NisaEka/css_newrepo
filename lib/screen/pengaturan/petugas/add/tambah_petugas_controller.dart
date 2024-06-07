import 'dart:core';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/pengaturan/DataPetugasModel.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
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
  PetugasModel? data = Get.arguments['data'];
  bool isLoading = false;
  bool isLoadOrigin = false;
  bool isObscurePassword = true;
  bool isObscurePasswordConfirm = true;
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
  RxList<Origin> originList = <Origin>[].obs;
  final selectedOrigin = <Origin>[].obs;
  List<String> originCodes = [];
  List<BranchModel> branchList = [];
  List<BranchModel> selectedBranchList = [];
  List<String> branchs = [];
  String? status;
  GetPetugasByidModel dataPetugas = GetPetugasByidModel();

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
      await transaction.getAccountNumber().then((value) {
        accountList.addAll(value.payload ?? []);
        update();
      });

      await setting.getBranch().then((value) {
        branchList.addAll(value.payload ?? []);
        update();
      });

      if (isEdit) {
        dataPetugas = await setting.getOfficerByID(data?.id ?? '');
        update();
        loadOrigin(dataPetugas.payload?.branches ?? []);
        dataPetugas.payload?.accounts?.forEach((account) {
          selectedAccountList.add(accountList.where((e) => e.accountId == account.accountId).first);
        });
        dataPetugas.payload?.branches?.forEach((branch) {
          selectedBranchList.add(branchList.where((e) => e.code == branch.code).first);
          update();
        });
        // selectedOrigin = dataPetugas.payload?.origins ?? [];

        dataPetugas.payload?.origins?.forEach((origin) {
          originCodes.add(origin.originCode ?? '');
          // selectedOrigin.add(originList.where((e) => e.originCode == origin.originCode).first);
          update();
        });

        namaPetugas.text = dataPetugas.payload?.name ?? '';
        alamatEmail.text = dataPetugas.payload?.email ?? '';
        nomorTelepon.text = dataPetugas.payload?.phone ?? '';
        status = dataPetugas.payload?.status ?? '';
        alamat.text = dataPetugas.payload?.branch ?? '';
        zipCode.text = dataPetugas.payload?.zipCode ?? '';
        status = dataPetugas.payload?.status ?? 'N';

        profilku = dataPetugas.payload?.menu?.profil == "Y";
        fasilitas = dataPetugas.payload?.menu?.fasilitas == "Y";
        katasandi = dataPetugas.payload?.menu?.katasandi == "Y";
        beranda = dataPetugas.payload?.menu?.beranda == "Y";
        buatPesanan = dataPetugas.payload?.menu?.buatPesanan == "Y";
        lacakPesanan = dataPetugas.payload?.menu?.lacakPesanan == "Y";
        mintaDijemput = dataPetugas.payload?.menu?.mintaDijemput == "Y";
        serahTerima = dataPetugas.payload?.menu?.serahTerima == "Y";
        saldo = dataPetugas.payload?.menu?.saldo == "Y";
        uangCod = dataPetugas.payload?.menu?.uangCod == "Y";
        tagihan = dataPetugas.payload?.menu?.tagihan == "Y";
        bonus = dataPetugas.payload?.menu?.bonus == "Y";
        pantauPaketmu = dataPetugas.payload?.menu?.pantauPaketmu == "Y";
        laporan = dataPetugas.payload?.menu?.laporan == "Y";
        eclaim = dataPetugas.payload?.menu?.eclaim == "Y";
        tema = dataPetugas.payload?.menu?.tema == "Y";
        label = dataPetugas.payload?.menu?.label == "Y";
        petugas = dataPetugas.payload?.menu?.petugas == "Y";
        riwayatPesanan = dataPetugas.payload?.menu?.riwayatPesanan == "Y";
        cekOngkir = dataPetugas.payload?.menu?.cekOngkir == "Y";
        semuaTransaksi = dataPetugas.payload?.menu?.semuaTransaksi == "Y";
        hapusPesanan = dataPetugas.payload?.menu?.hapusPesanan == "Y";
        semuaHapus = dataPetugas.payload?.menu?.semuaHapus == "Y";
        cetakPesanan = dataPetugas.payload?.menu?.cetakPesanan == "Y";
        monitoringAgg = dataPetugas.payload?.menu?.monitoringAgg == "Y";
        monitoringAggMinus = dataPetugas.payload?.menu?.monitoringAggMinus == "Y";
        update();
      }
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
  }

  Future<void> loadOrigin(List<BranchModel> branches) async {
    originList.clear();
    selectedOrigin.clear();
    branchs = [];
    isLoadOrigin = true;
    update();
    for (var element in branches) {
      branchs.add(element.code ?? '');
      update();
    }
    try {
      await setting.getOriginGroup(branchs).then((value) {
        originList.addAll(value.payload ?? []);
        update();
      }).then((value) {
        if (dataPetugas.payload?.origins?.isNotEmpty ?? false) {
          print("punya origin");
          dataPetugas.payload?.origins?.forEach((origin) {
            selectedOrigin.add(originList.where((e) => e.originCode == origin.originCode).first);
            update();
          });
          print(selectedOrigin.map((e) => e.originCode));
          print(originList.where((element) => element == selectedOrigin.first).isNotEmpty);

          update();
        }
      });
      update();
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    // originCodes.forEach((value) {
    //   selectedOrigin.add(originList.where((e) => e.originCode == value).first);
    // });
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
              menu: Menu(
                profil: profilku ? "Y" : null,
                fasilitas: fasilitas ? "Y" : null,
                katasandi: katasandi ? "Y" : null,
                beranda: beranda ? "Y" : null,
                buatPesanan: buatPesanan ? "Y" : null,
                riwayatPesanan: riwayatPesanan ? "Y" : null,
                lacakPesanan: lacakPesanan ? "Y" : null,
                mintaDijemput: mintaDijemput ? "Y" : null,
                serahTerima: serahTerima ? "Y" : null,
                cetakPesanan: cetakPesanan ? "Y" : null,
                hapusPesanan: hapusPesanan ? "Y" : null,
                saldo: saldo ? "Y" : null,
                uangCod: uangCod ? "Y" : null,
                monitoringAgg: monitoringAgg ? "Y" : null,
                monitoringAggMinus: monitoringAggMinus ? "Y" : null,
                tagihan: tagihan ? "Y" : null,
                bonus: bonus ? "Y" : null,
                pantauPaketmu: pantauPaketmu ? "Y" : null,
                laporan: laporan ? "Y" : null,
                eclaim: eclaim ? "Y" : null,
                cekOngkir: cekOngkir ? "Y" : null,
                label: label ? "Y" : null,
                petugas: petugas ? "Y" : null,
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
            if (value.code == 201) {
              Get.back()
            } else if (value.code == 409) {
              Get.showSnackbar(
                GetSnackBar(
                  icon: const Icon(
                    Icons.warning,
                    color: whiteColor,
                  ),
                  message: 'Alamat email atau nomor telepon sudah digunakan'.tr,
                  isDismissible: true,
                  duration: const Duration(seconds: 3),
                  backgroundColor: errorColor,
                ),
              )
            }
      });
    } catch (e, i) {
      e.printError();
      i.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.warning,
            color: whiteColor,
          ),
          message: 'Bad Request'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
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
              menu: Menu(
                profil: profilku ? "Y" : null,
                fasilitas: fasilitas ? "Y" : null,
                katasandi: katasandi ? "Y" : null,
                beranda: beranda ? "Y" : null,
                buatPesanan: buatPesanan ? "Y" : null,
                riwayatPesanan: riwayatPesanan ? "Y" : null,
                lacakPesanan: lacakPesanan ? "Y" : null,
                mintaDijemput: mintaDijemput ? "Y" : null,
                serahTerima: serahTerima ? "Y" : null,
                cetakPesanan: cetakPesanan ? "Y" : null,
                hapusPesanan: hapusPesanan ? "Y" : null,
                saldo: saldo ? "Y" : null,
                uangCod: uangCod ? "Y" : null,
                monitoringAgg: monitoringAgg ? "Y" : null,
                monitoringAggMinus: monitoringAggMinus ? "Y" : null,
                tagihan: tagihan ? "Y" : null,
                bonus: bonus ? "Y" : null,
                pantauPaketmu: pantauPaketmu ? "Y" : null,
                laporan: laporan ? "Y" : null,
                eclaim: eclaim ? "Y" : null,
                cekOngkir: cekOngkir ? "Y" : null,
                label: label ? "Y" : null,
                petugas: petugas ? "Y" : null,
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
      e.printError();
      Get.showSnackbar(
        GetSnackBar(
          icon: const Icon(
            Icons.warning,
            color: whiteColor,
          ),
          message: 'Bad Request'.tr,
          isDismissible: true,
          duration: const Duration(seconds: 3),
          backgroundColor: errorColor,
        ),
      );
    }
    isLoading = false;
    update();
  }
}
