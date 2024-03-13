import 'dart:core';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/material.dart';
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
  List<Origin> originList = [];
  List<Origin> selectedOrigin = [];
  List<String> origins = [];
  List<BranchModel> branchList = [];
  List<BranchModel> selectedBranchList = [];
  List<String> branchs = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    accountList = [];
    originList = [];
    branchList = [];
    update();
    try {
      await transaction.getAccountNumber().then((value) {
        accountList.addAll(value.payload ?? []);
        update();
      });

      // await setting.getBranch().then((value) {
      //   branchList.addAll(value.payload ?? []);
      //   update();
      // });

      if (isEdit) {
        await setting.getOfficerByID(data?.id ?? '').then((value) {
          namaPetugas.text = value.payload?.name ?? '';
          alamatEmail.text = value.payload?.email ?? '';
          nomorTelepon.text = value.payload?.phone ?? '';
          update();
        });
      }
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }

  Future<void> loadOrigin() async {
    originList = [];
    for (var element in selectedBranchList) {
      branchs.add(element.desc ?? '');
      update();
    }
    try {
      await setting.getOriginGroup(branchs).then((value) {
        originList.addAll(value.payload ?? []);
        update();
      });
    } catch (e) {
      e.printError();
    }
  }

  Future<void> saveOfficer() async {
    for (var element in selectedOrigin) {
      origins.add(element.originCode ?? '');
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
              origins: origins,
            ),
          )
          .then((value) => Get.back());
    } catch (e) {
      e.printError();
    }
  }

  Future<void> updateOfficer() async {
    try {
      await setting
          .putOfficer(
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
              origins: origins,
            ),
          )
          .then((value) => Get.back());
    } catch (e) {
      e.printError();
    }
  }
}
