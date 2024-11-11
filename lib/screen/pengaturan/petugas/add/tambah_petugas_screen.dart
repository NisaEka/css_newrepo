import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
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
              children: [_bodyContent(controller, context), controller.isLoading ? const LoadingDialog() : const SizedBox()],
            ),
          );
        });
  }

  Widget _bodyContent(TambahPetugasController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: ListView(
        children: [
          Form(
            key: c.formKey,
            onChanged: () => c.setLocale(),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: c.namaPetugas,
                  hintText: 'Nama Petugas'.tr,
                  isRequired: true,
                  validator: ValidationBuilder().name().build(),
                ),
                CustomTextFormField(
                  controller: c.alamatEmail,
                  hintText: 'Alamat Email'.tr,
                  isRequired: true,
                  validator: ValidationBuilder(localeName: c.locale).email().minLength(10).build(),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(text: newValue.text.toLowerCase());
                    })
                  ],
                ),
                CustomTextFormField(
                  controller: c.nomorTelepon,
                  hintText: 'Nomor Telepon'.tr,
                  isRequired: true,
                  inputType: TextInputType.number,
                  validator: ValidationBuilder().phoneNumber().build(),
                ),
                c.isEdit
                    ? CustomFilledButton(
                        color: warningColor,
                        title: "Ubah Kata Sandi".tr,
                        onPressed: () {
                          c.isEditPassword = c.isEditPassword ? false : true;
                          c.update();
                        },
                      )
                    : const SizedBox(),
                !c.isEdit || c.isEditPassword
                    ? CustomTextFormField(
                        controller: c.password,
                        hintText: 'Kata Sandi'.tr,
                        isRequired: c.isEdit ? false : true,
                        validator: ValidationBuilder().password().build(),
                        isObscure: c.isObscurePassword,
                        multiLine: false,
                        inputFormatters: const [],
                        suffixIcon: IconButton(
                          icon: c.showIcon,
                          onPressed: () {
                            c.isObscurePassword ? c.isObscurePassword = false : c.isObscurePassword = true;
                            c.isObscurePassword != false
                                ? c.showIcon = const Icon(
                                    Icons.visibility,
                                    color: greyDarkColor1,
                                  )
                                : c.showIcon = const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  );
                            c.update();
                          },
                        ),
                      )
                    : const SizedBox(),
                !c.isEdit || c.isEditPassword
                    ? CustomTextFormField(
                        controller: c.passwordConfirm,
                        hintText: 'Konfirmasi Kata Sandi'.tr,
                        isRequired: true,
                        inputFormatters: const [],
                        validator: (value) {
                          if (value != c.password.text) {
                            return "Kata sandi tidak sama".tr;
                          }
                          return null;
                        },
                        isObscure: c.isObscurePasswordConfirm,
                        multiLine: false,
                        suffixIcon: IconButton(
                          icon: c.showConfirmIcon,
                          onPressed: () {
                            c.isObscurePasswordConfirm ? c.isObscurePasswordConfirm = false : c.isObscurePasswordConfirm = true;
                            c.isObscurePasswordConfirm != false
                                ? c.showConfirmIcon = const Icon(
                                    Icons.visibility,
                                    color: greyDarkColor1,
                                  )
                                : c.showConfirmIcon = const Icon(
                                    Icons.visibility_off,
                                    color: Colors.black,
                                  );
                            c.update();
                          },
                        ),
                      )
                    : const SizedBox(),
                c.buatPesanan
                    ? Column(
                        children: [
                          MultiSelectDialogField(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            searchable: true,
                            buttonIcon: const Icon(Icons.keyboard_arrow_down),
                            buttonText: Text('Akun'.tr),
                            itemsTextStyle: TextStyle(color: CustomTheme().textColor(context)),
                            dialogWidth: Get.width,
                            initialValue: c.selectedAccountList,
                            items: c.accountList
                                .map((e) => MultiSelectItem(
                                      e,
                                      '${e.accountNumber}/${e.accountName}/${e.accountType ?? e.accountService}',
                                    ))
                                .toList(),
                            listType: MultiSelectListType.CHIP,
                            backgroundColor: AppConst.isLightTheme(context) ? whiteColor : greyColor,
                            onConfirm: (values) {
                              c.selectedAccountList = values;
                            },
                            onSelectionChanged: (values) {
                              c.selectedAccountList = values;
                              c.update();
                            },
                          ),
                          const SizedBox(height: 10),
                          MultiSelectDialogField(
                            decoration: BoxDecoration(
                              border: Border.all(color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            searchable: true,
                            buttonIcon: const Icon(Icons.keyboard_arrow_down),
                            buttonText: Text('Branch'.tr),
                            initialValue: c.selectedBranchList,
                            items: c.branchList
                                .map((e) => MultiSelectItem(
                                      e,
                                      '${e.code}-${e.desc}',
                                    ))
                                .toList(),
                            itemsTextStyle: TextStyle(color: CustomTheme().textColor(context)),
                            listType: MultiSelectListType.CHIP,
                            backgroundColor: AppConst.isLightTheme(context) ? whiteColor : greyColor,
                            onConfirm: (values) {
                              c.selectedBranchList = values;
                              c.update();
                              c.loadOrigin(values);
                            },
                            onSelectionChanged: (values) {
                              c.selectedBranchList = values;
                              c.update();
                              c.loadOrigin(values);
                            },
                          ),
                          const SizedBox(height: 10),
                          Obx(
                            () => MultiSelectDialogField<Origin>(
                              decoration: BoxDecoration(
                                border: Border.all(color: AppConst.isLightTheme(context) ? greyDarkColor1 : greyLightColor1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              searchable: true,
                              buttonIcon: const Icon(Icons.keyboard_arrow_down),
                              buttonText: Text(c.isLoadOrigin ? 'Loading...' : 'Origin'.tr),
                              initialValue: c.selectedOrigin,
                              items: c.originList
                                  .map((e) => MultiSelectItem(
                                        e,
                                        '${e.originCode}-${e.originName}',
                                      ))
                                  .toList(),
                              listType: MultiSelectListType.CHIP,
                              backgroundColor: AppConst.isLightTheme(context) ? whiteColor : greyColor,
                              itemsTextStyle: TextStyle(color: CustomTheme().textColor(context)),
                              onConfirm: (values) {
                                // controller.selectedOrigin = values;
                                c.selectedOrigin.clear();
                                c.selectedOrigin.addAll(values);
                                c.update();
                              },
                              onSelectionChanged: (values) {
                                // controller.selectedOrigin = values;
                                c.selectedOrigin.clear();
                                c.selectedOrigin.addAll(values);
                                c.update();
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
                            controller: c.alamat,
                            hintText: 'Alamat'.tr,
                            validator: ValidationBuilder().address().build(),
                          ),
                          CustomTextFormField(
                            controller: c.zipCode,
                            hintText: 'Kode Pos'.tr,
                            validator: ValidationBuilder().zipCode().build(),
                            inputType: TextInputType.number,
                          ),
                        ],
                      )
                    : const SizedBox(),
                c.beranda
                    ? CustomDropDownFormField(
                        hintText: 'Tampilkan transaksi'.tr,
                        value: c.semuaTransaksi ? "Y" : "N",
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
                            c.semuaTransaksi = true;
                            c.update();
                          }
                        },
                      )
                    : const SizedBox(),
                c.isEdit
                    ? CustomDropDownFormField(
                        hintText: 'Status'.tr,
                        value: c.status,
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
                          c.status = value;
                          c.update();
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
                          // CustomCheckbox(
                          //   label: 'profilku'.tr,
                          //   value: c.profilku,
                          //   onChanged: (value) {
                          //     c.profilku = value!;
                          //     c.update();
                          //   },
                          // ),
                          // CustomCheckbox(
                          //   label: 'Fasilitasku'.tr,
                          //   value: c.fasilitas,
                          //   onChanged: (value) {
                          //     c.fasilitas = value!;
                          //     c.update();
                          //   },
                          // ),
                          CustomCheckbox(
                            label: 'Ubah Kata Sandi'.tr,
                            value: c.katasandi,
                            onChanged: (value) {
                              c.katasandi = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: 'Beranda'.tr),
                          CustomCheckbox(
                            label: 'Beranda'.tr,
                            value: c.beranda,
                            onChanged: (value) {
                              c.beranda = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: 'Paketmu'.tr),
                          CustomCheckbox(
                            label: 'Input Transaksi'.tr,
                            value: c.buatPesanan,
                            onChanged: (value) {
                              c.buatPesanan = value!;
                              if (value == false) {
                                c.selectedBranchList = [];
                                c.selectedBranchList = [];
                                c.selectedAccountList = [];
                                c.selectedOrigin.clear();
                                c.update();
                              }

                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Riwayat Kiriman'.tr,
                            value: c.riwayatPesanan,
                            onChanged: (value) {
                              c.riwayatPesanan = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Lacak Kiriman'.tr,
                            value: c.lacakPesanan,
                            onChanged: (value) {
                              c.lacakPesanan = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Minta Dijemput'.tr,
                            value: c.mintaDijemput,
                            onChanged: (value) {
                              c.mintaDijemput = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Serah Terima'.tr,
                            value: c.serahTerima,
                            onChanged: (value) {
                              c.serahTerima = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Cetak Pesanan'.tr,
                            value: c.cetakPesanan,
                            onChanged: (value) {
                              c.cetakPesanan = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Hapus Transaksi'.tr,
                            value: c.hapusPesanan,
                            onChanged: (value) {
                              c.hapusPesanan = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: 'Keuanganmu'.tr),
                          CustomCheckbox(
                            label: 'Saldo Kamu'.tr,
                            value: c.saldo,
                            onChanged: (value) {
                              c.saldo = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Uang_COD Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.uangCod,
                            onChanged: (value) {
                              c.uangCod = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Laporan Pembayaran Aggregasi'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.monitoringAgg,
                            onChanged: (value) {
                              c.monitoringAgg = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Aggregasi Minus'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.monitoringAggMinus,
                            onChanged: (value) {
                              c.monitoringAggMinus = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Tagihan Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.tagihan,
                            onChanged: (value) {
                              c.tagihan = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'Bonus Kamu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.bonus,
                            onChanged: (value) {
                              c.bonus = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: "Pantau Paketmu".tr),
                          CustomCheckbox(
                            label: 'Pantau Paketmu'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.pantauPaketmu,
                            onChanged: (value) {
                              c.pantauPaketmu = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: "Hubungi Aku".tr),
                          CustomCheckbox(
                            label: 'Laporanku'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.laporan,
                            onChanged: (value) {
                              c.laporan = value!;
                              c.update();
                            },
                          ),
                          CustomCheckbox(
                            label: 'E-Claim'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.eclaim,
                            onChanged: (value) {
                              c.eclaim = value!;
                              c.update();
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
                            value: c.cekOngkir,
                            onChanged: (value) {
                              c.cekOngkir = value!;
                              c.update();
                            },
                          ),
                          CustomFormLabel(label: "Pengaturan".tr),
                          CustomCheckbox(
                            label: 'Label'.tr.splitMapJoin('_', onMatch: (p0) => ' '),
                            value: c.label,
                            onChanged: (value) {
                              c.label = value!;
                              c.update();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomFilledButton(
                  color: blueJNE,
                  title: c.isEdit ? "Edit Petugas".tr : "Simpan Petugas".tr,
                  onPressed: () => c.formKey.currentState?.validate() == true
                      ? c.isEdit
                          ? c.updateOfficer()
                          : c.saveOfficer()
                      : null,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
