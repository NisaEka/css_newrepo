import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TambahPetugasScreen extends StatelessWidget {
  const TambahPetugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahPetugasController>(
        init: TambahPetugasController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              backgroundColor: whiteColor,
              title: 'Tambah Petugas'.tr,
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ListView(
                children: [
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                          controller: controller.namaPetugas,
                          hintText: 'Nama Petugas'.tr,
                        ),
                        CustomTextFormField(
                          controller: controller.alamatEmail,
                          hintText: 'Alamat Email'.tr,
                        ),
                        CustomTextFormField(
                          controller: controller.nomorTelepon,
                          hintText: 'Nomor Telepon'.tr,
                        ),
                        CustomTextFormField(
                          controller: controller.password,
                          hintText: 'Kata Sandi'.tr,
                          suffixIcon: const Icon(Icons.visibility),
                        ),
                        CustomTextFormField(
                          controller: controller.passwordConfirm,
                          hintText: 'Konfirmasi Kata Sandi'.tr,
                          suffixIcon: const Icon(Icons.visibility),
                        ),
                        const SizedBox(height: 35),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: greyColor),
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Center(
                                child: Text('Tentukan Hak Akses'.tr, style: listTitleTextStyle),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomFormLabel(label: 'Profil'.tr),
                                  CustomCheckbox(
                                    label: 'profilku'.tr,
                                    value: controller.profilku,
                                    onChanged: (value) {
                                      controller.profilku = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Fasilitasku'.tr,
                                    value: controller.fasilitas,
                                    onChanged: (value) {
                                      controller.fasilitas = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Ubah Kata Sandi'.tr,
                                    value: controller.katasandi,
                                    onChanged: (value) {
                                      controller.katasandi = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: 'Beranda'.tr),
                                  CustomCheckbox(
                                    label: 'Beranda'.tr,
                                    value: controller.beranda,
                                    onChanged: (value) {
                                      controller.beranda = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: 'Paketmu'.tr),
                                  CustomCheckbox(
                                    label: 'Input Transaksi'.tr,
                                    value: controller.buatPesanan,
                                    onChanged: (value) {
                                      controller.buatPesanan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Riwayat Kiriman'.tr,
                                    value: controller.riwayatPesanan,
                                    onChanged: (value) {
                                      controller.riwayatPesanan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Lacak Kiriman'.tr,
                                    value: controller.lacakPesanan,
                                    onChanged: (value) {
                                      controller.lacakPesanan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Minta Dijemput'.tr,
                                    value: controller.mintaDijemput,
                                    onChanged: (value) {
                                      controller.mintaDijemput = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Serah Terima'.tr,
                                    value: controller.serahTerima,
                                    onChanged: (value) {
                                      controller.serahTerima = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Cetak Pesanan'.tr,
                                    value: controller.cetakPesanan,
                                    onChanged: (value) {
                                      controller.cetakPesanan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Hapus Transaksi'.tr,
                                    value: controller.hapusPesanan,
                                    onChanged: (value) {
                                      controller.hapusPesanan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: 'Keuanganmu'.tr),
                                  CustomCheckbox(
                                    label: 'Saldo Kamu'.tr,
                                    value: controller.saldo,
                                    onChanged: (value) {
                                      controller.saldo = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Uang_COD Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.uangCod,
                                    onChanged: (value) {
                                      controller.uangCod = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Laporan Pembayaran Aggregasi'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.monitoringAgg,
                                    onChanged: (value) {
                                      controller.monitoringAgg = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Aggregasi Minus'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.monitoringAggMinus,
                                    onChanged: (value) {
                                      controller.monitoringAggMinus = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Tagihan Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.tagihan,
                                    onChanged: (value) {
                                      controller.tagihan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'Bonus Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.bonus,
                                    onChanged: (value) {
                                      controller.bonus = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: "Pantau Paketmu".tr),
                                  CustomCheckbox(
                                    label: 'Pantau Paketmu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.pantauPaketmu,
                                    onChanged: (value) {
                                      controller.pantauPaketmu = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: "Hubungi Aku".tr),
                                  CustomCheckbox(
                                    label: 'Laporanku'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.laporan,
                                    onChanged: (value) {
                                      controller.laporan = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomCheckbox(
                                    label: 'E-Claim'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.eclaim,
                                    onChanged: (value) {
                                      controller.eclaim = value!;
                                      controller.update();
                                    },
                                  ),
                                  // CustomFormLabel(label: "Laporanku".tr),
                                  // CustomCheckbox(
                                  //   label: 'Laporan Return'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                  //   value: controller.beranda,
                                  //   onChanged: (value) {
                                  //     controller.beranda = value!;
                                  //     controller.update();
                                  //   },
                                  // ),
                                  // CustomCheckbox(
                                  //   label: 'Summary Origin'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                  //   value: controller.beranda,
                                  //   onChanged: (value) {
                                  //     controller.beranda = value!;
                                  //     controller.update();
                                  //   },
                                  // ),
                                  // CustomCheckbox(
                                  //   label: 'Summary Destination'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                  //   value: controller.beranda,
                                  //   onChanged: (value) {
                                  //     controller.beranda = value!;
                                  //     controller.update();
                                  //   },
                                  // ),
                                  CustomFormLabel(label: "Cek Ongkir".tr),
                                  CustomCheckbox(
                                    label: 'Cek Ongkir'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.cekOngkir,
                                    onChanged: (value) {
                                      controller.cekOngkir = value!;
                                      controller.update();
                                    },
                                  ),
                                  CustomFormLabel(label: "Pengaturan".tr),
                                  CustomCheckbox(
                                    label: 'Label'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                                    value: controller.label,
                                    onChanged: (value) {
                                      controller.label = value!;
                                      controller.update();
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomFilledButton(
                          color: blueJNE,
                          title: controller.isEdit ? "Edit Petugas".tr : "Simpan Petugas".tr,
                          onPressed: () => controller.isEdit ? controller.updateOfficer : controller.saveOfficer(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
