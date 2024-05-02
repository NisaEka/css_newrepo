import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class TambahPetugasScreen extends StatelessWidget {
  const TambahPetugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TambahPetugasController>(
        init: TambahPetugasController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: controller.isEdit ? 'Edit Petugas' : 'Tambah Petugas'.tr,
            ),
            body: Stack(
              children: [
                Padding(
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
                              isRequired: true,
                            ),
                            CustomTextFormField(
                              controller: controller.alamatEmail,
                              hintText: 'Alamat Email'.tr,
                              isRequired: true,
                              validator: ValidationBuilder().email().minLength(10).build(),
                              inputFormatters: [
                                TextInputFormatter.withFunction((oldValue, newValue) {
                                  return newValue.copyWith(text: newValue.text.toLowerCase());
                                })
                              ],
                            ),
                            CustomTextFormField(
                              controller: controller.nomorTelepon,
                              hintText: 'Nomor Telepon'.tr,
                              isRequired: true,
                              inputType: TextInputType.number,
                              validator: ValidationBuilder().phone().build(),
                            ),
                            !controller.isEdit
                                ? CustomTextFormField(
                                    controller: controller.password,
                                    hintText: 'Kata Sandi'.tr,
                                    isRequired: controller.isEdit ? false : true,
                                    validator: ValidationBuilder().password().build(),
                                    isObscure: controller.isObscurePassword,
                                    multiLine: false,
                                    inputFormatters: const [],
                                    suffixIcon: IconButton(
                                      icon: controller.showIcon,
                                      onPressed: () {
                                        controller.isObscurePassword ? controller.isObscurePassword = false : controller.isObscurePassword = true;
                                        controller.isObscurePassword != false
                                            ? controller.showIcon = const Icon(
                                                Icons.visibility,
                                                color: greyDarkColor1,
                                              )
                                            : controller.showIcon = const Icon(
                                                Icons.visibility_off,
                                                color: Colors.black,
                                              );
                                        controller.update();
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                            !controller.isEdit
                                ? CustomTextFormField(
                                    controller: controller.passwordConfirm,
                                    hintText: 'Konfirmasi Kata Sandi'.tr,
                                    isRequired: true,
                                    inputFormatters: const [],
                                    validator: (value) {
                                      if (value != controller.password.text) {
                                        return "Password tidak sama".tr;
                                      }
                                      return null;
                                    },
                                    isObscure: controller.isObscurePassword,
                                    multiLine: false,
                                    suffixIcon: IconButton(
                                      icon: controller.showConfirmIcon,
                                      onPressed: () {
                                        controller.isObscurePasswordConfirm
                                            ? controller.isObscurePasswordConfirm = false
                                            : controller.isObscurePasswordConfirm = true;
                                        controller.isObscurePasswordConfirm != false
                                            ? controller.showConfirmIcon = const Icon(
                                                Icons.visibility,
                                                color: greyDarkColor1,
                                              )
                                            : controller.showConfirmIcon = const Icon(
                                                Icons.visibility_off,
                                                color: Colors.black,
                                              );
                                        controller.update();
                                      },
                                    ),
                                  )
                                : const SizedBox(),
                            controller.buatPesanan
                                ? Column(
                                    children: [
                                      MultiSelectDialogField(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        searchable: true,
                                        buttonIcon: const Icon(Icons.keyboard_arrow_down),
                                        buttonText: Text('Akun'.tr),
                                        dialogWidth: Get.width,
                                        initialValue: controller.selectedAccountList,
                                        items: controller.accountList
                                            .map((e) => MultiSelectItem(
                                                  e,
                                                  '${e.accountNumber}/${e.accountName}/${e.accountType ?? e.accountService}',
                                                ))
                                            .toList(),
                                        listType: MultiSelectListType.CHIP,
                                        backgroundColor: Theme.of(context).brightness == Brightness.light ? whiteColor : greyColor,
                                        onConfirm: (values) {
                                          controller.selectedAccountList = values;
                                        },
                                        onSelectionChanged: (values) {
                                          controller.selectedAccountList = values;
                                          controller.update();
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      MultiSelectDialogField(
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        searchable: true,
                                        buttonIcon: const Icon(Icons.keyboard_arrow_down),
                                        buttonText: Text('Branch'.tr),
                                        initialValue: controller.selectedBranchList,
                                        items: controller.branchList
                                            .map((e) => MultiSelectItem(
                                                  e,
                                                  '${e.code}-${e.desc}',
                                                ))
                                            .toList(),
                                        listType: MultiSelectListType.CHIP,
                                        backgroundColor: Theme.of(context).brightness == Brightness.light ? whiteColor : greyColor,
                                        onConfirm: (values) {
                                          controller.selectedBranchList = values;
                                          controller.update();
                                          controller.loadOrigin(values);
                                        },
                                        onSelectionChanged: (values) {
                                          controller.selectedBranchList = values;
                                          controller.update();
                                          controller.loadOrigin(values);
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      Obx(
                                        () => MultiSelectDialogField<Origin>(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Theme.of(context).brightness == Brightness.light ? greyDarkColor1 : greyLightColor1),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          searchable: true,
                                          buttonIcon: const Icon(Icons.keyboard_arrow_down),
                                          buttonText: Text(controller.isLoadOrigin ? 'Loading...' : 'Origin'.tr),
                                          initialValue: controller.selectedOrigin,
                                          items: controller.originList
                                              .map((e) => MultiSelectItem(
                                                    e,
                                                    '${e.originCode}-${e.originName}',
                                                  ))
                                              .toList(),
                                          listType: MultiSelectListType.CHIP,
                                          backgroundColor: Theme.of(context).brightness == Brightness.light ? whiteColor : greyColor,
                                          onConfirm: (values) {
                                            // controller.selectedOrigin = values;
                                            controller.selectedOrigin.clear();
                                            controller.selectedOrigin.addAll(values);
                                            controller.update();
                                          },
                                          onSelectionChanged: (values) {
                                            // controller.selectedOrigin = values;
                                            controller.selectedOrigin.clear();
                                            controller.selectedOrigin.addAll(values);
                                            controller.update();
                                          },
                                        ),
                                      ),
                                      // Column(
                                      //   children: controller.selectedOrigin.toSet().toList().map((e) => Text("${e.originCode.toString()}-${e.originName}")).toList(),
                                      // ),
                                      // Column(
                                      //   children: controller.originCodes.map((e) => Text(e.toString())).toList(),
                                      // ),
                                      const SizedBox(height: 5),
                                      CustomTextFormField(
                                        controller: controller.alamat,
                                        hintText: 'Alamat'.tr,
                                      ),
                                      CustomTextFormField(
                                        controller: controller.zipCode,
                                        hintText: 'Kode Pos'.tr,
                                        validator: ValidationBuilder().zipCode().build(),
                                        inputType: TextInputType.number,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            controller.beranda
                                ? CustomDropDownFormField(
                                    hintText: 'Tampilkan transaksi'.tr,
                                    value: controller.semuaTransaksi ? "Y" : "N",
                                    items: [
                                      DropdownMenuItem(
                                        value: "Y",
                                        child: Text('Semua'.tr.toUpperCase()),
                                      ),
                                      DropdownMenuItem(
                                        value: "N",
                                        child: Text('Dibatasi'.tr.toUpperCase()),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      if (value == "Y") {
                                        controller.semuaTransaksi = true;
                                        controller.update();
                                      }
                                    },
                                  )
                                : const SizedBox(),
                            controller.isEdit
                                ? CustomDropDownFormField(
                                    hintText: 'Status'.tr,
                                    value: controller.status,
                                    items: [
                                      DropdownMenuItem(
                                        value: "Y",
                                        child: Text('Aktif'.tr.toUpperCase()),
                                      ),
                                      DropdownMenuItem(
                                        value: "N",
                                        child: Text('Tidak Aktif'.tr.toUpperCase()),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      controller.status = value;
                                      controller.update();
                                    },
                                  )
                                : const SizedBox(),
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
                                          if (value == false) {
                                            controller.selectedBranchList = [];
                                            controller.selectedBranchList = [];
                                            controller.selectedAccountList = [];
                                            controller.selectedOrigin.clear();
                                            controller.update();
                                          }

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
                              onPressed: () => controller.formKey.currentState?.validate() == true
                                  ? controller.isEdit
                                      ? controller.updateOfficer()
                                      : controller.saveOfficer()
                                  : null,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                controller.isLoading ? const LoadingDialog() : const SizedBox()
              ],
            ),
          );
        });
  }
}
