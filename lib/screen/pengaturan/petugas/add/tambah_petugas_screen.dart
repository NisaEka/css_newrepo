import 'package:css_mobile/base/theme_controller.dart';
import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_branch_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/forms/customdropdownformfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
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
                _bodyContent(controller, context),
                controller.isLoading ? const LoadingDialog() : const SizedBox()
              ],
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
                  readOnly: c.isEdit,
                  validator: ValidationBuilder(localeName: c.locale)
                      .email()
                      .minLength(10)
                      .build(),
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                          text: newValue.text.toLowerCase());
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
                            c.isObscurePassword
                                ? c.isObscurePassword = false
                                : c.isObscurePassword = true;
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
                            c.isObscurePasswordConfirm
                                ? c.isObscurePasswordConfirm = false
                                : c.isObscurePasswordConfirm = true;
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Hak Akses'.tr,
                          style: listTitleTextStyle.copyWith(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? blueJNE
                                    : Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        children: [
                          _buildSectionTitle(
                            context,
                            title: 'Profil'.tr,
                            icon: Icons.person,
                          ),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem('Profilku', c.profilku,
                                  (value) {
                                c.profilku = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Ubah Kata Sandi', c.katasandi,
                                  (value) {
                                c.katasandi = value!;
                                c.update();
                              }),
                            ],
                          ),

                          _buildSectionTitle(
                            context,
                            title: 'Beranda'.tr,
                            icon: Icons.home_outlined,
                          ),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem('Beranda', c.beranda, (value) {
                                c.beranda = value!;
                                if (value == false) {
                                  c.semuaTransaksi = false;
                                }
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Pantau Paketmu', c.pantauPaketmu, (value) {
                                c.pantauPaketmu = value!;
                                if (value == false) {
                                  c.semuaTransaksi = false;
                                }
                                c.update();
                              }),
                            ],
                          ),

                          _buildSectionTitle(
                            context,
                            title: 'Transaksi'.tr,
                            icon: Icons.receipt_outlined,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 32),
                            child: Column(
                              children: [
                                _buildCheckboxItem(
                                    'Input Kirimanmu', c.buatPesanan, (value) {
                                  c.buatPesanan = value!;
                                  if (value == false) {
                                    c.selectedBranchList = [];
                                    c.selectedAccountList = [];
                                    c.selectedOrigin.clear();
                                    c.update();
                                    c.getCountSelectedAccountNA();
                                  }
                                  c.update();
                                }),
                                c.buatPesanan
                                    ? Padding(
                                        padding:
                                            const EdgeInsets.only(left: 32),
                                        child: Column(
                                          children: [
                                            MultiSelectDialogField(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppConst.isLightTheme(
                                                                context)
                                                            ? greyDarkColor1
                                                            : greyLightColor1),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              searchable: true,
                                              buttonIcon: const Icon(
                                                  Icons.keyboard_arrow_down),
                                              buttonText: Text(
                                                c.selectedAccountList.isNotEmpty
                                                    ? '${c.selectedAccountList.length} ${'Akun'.tr} ${'Dipilih'.tr}'
                                                    : 'Akun'.tr,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: CustomTheme()
                                                      .textColor(context),
                                                ),
                                              ),
                                              itemsTextStyle: TextStyle(
                                                  color: CustomTheme()
                                                      .textColor(context)),
                                              dialogWidth: Get.width,
                                              initialValue:
                                                  c.selectedAccountList,
                                              items: c.accountList
                                                  .map((e) => MultiSelectItem(
                                                        e,
                                                        '${e.accountNumber}/${e.accountName}/${e.accountType ?? e.accountService}',
                                                      ))
                                                  .toList(),
                                              listType:
                                                  MultiSelectListType.CHIP,
                                              chipDisplay:
                                                  MultiSelectChipDisplay.none(),
                                              backgroundColor:
                                                  AppConst.isLightTheme(context)
                                                      ? whiteColor
                                                      : greyColor,
                                              onConfirm: (values) {
                                                c.selectedAccountList =
                                                    List<Account>.from(values);
                                                c.getCountSelectedAccountNA();
                                              },
                                              onSelectionChanged: (values) {
                                                c.selectedAccountList =
                                                    List<Account>.from(values);
                                                c.getCountSelectedAccountNA();
                                                c.update();
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                (c.buatPesanan &&
                                            (c.countSelectedAccountNA ?? 0) >
                                                0) ||
                                        (c.buatPesanan &&
                                            (c.countAllAccountNA ?? 0) > 0) ||
                                        (c.serahTerima &&
                                            (c.countAllAccountNA ?? 0) > 0)
                                    ? GridView.builder(
                                        shrinkWrap: true,
                                        padding:
                                            const EdgeInsets.only(left: 32),
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10,
                                          childAspectRatio: 1.9,
                                        ),
                                        itemCount: 2,
                                        itemBuilder: (context, index) {
                                          if (index == 0) {
                                            return Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                MultiSelectDialogField(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          AppConst.isLightTheme(
                                                                  context)
                                                              ? greyDarkColor1
                                                              : greyLightColor1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  searchable: true,
                                                  buttonIcon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  // buttonText: Text('Branch'.tr),
                                                  buttonText: Text(
                                                    c.selectedBranchList.isNotEmpty
                                                        ? '${c.selectedBranchList.length} ${'Branch'.tr}...'
                                                            .tr
                                                        : 'Branch'.tr,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: CustomTheme()
                                                          .textColor(context),
                                                    ),
                                                  ),
                                                  initialValue:
                                                      c.selectedBranchList,
                                                  items: c.branchList
                                                      .map((e) =>
                                                          MultiSelectItem(
                                                            e,
                                                            '${e.branchCode}-${e.branchDesc}',
                                                          ))
                                                      .toList(),
                                                  itemsTextStyle: TextStyle(
                                                      color: CustomTheme()
                                                          .textColor(context)),
                                                  listType:
                                                      MultiSelectListType.CHIP,
                                                  chipDisplay:
                                                      MultiSelectChipDisplay
                                                          .none(),
                                                  backgroundColor:
                                                      AppConst.isLightTheme(
                                                              context)
                                                          ? whiteColor
                                                          : greyColor,
                                                  onConfirm: (values) {
                                                    c.selectedBranchList =
                                                        List<BranchModel>.from(
                                                            values);
                                                    c.update();
                                                    c.loadOrigin(
                                                        c.selectedBranchList);
                                                  },
                                                  onSelectionChanged: (values) {
                                                    c.selectedBranchList =
                                                        List<BranchModel>.from(
                                                            values);
                                                    c.update();
                                                    c.loadOrigin(
                                                        c.selectedBranchList);
                                                  },
                                                ),
                                              ],
                                            );
                                          } else if (index == 1) {
                                            return Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Obx(
                                                  () => MultiSelectDialogField<
                                                      OriginModel>(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color: AppConst
                                                                .isLightTheme(
                                                                    context)
                                                            ? greyDarkColor1
                                                            : greyLightColor1,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    searchable: true,
                                                    buttonIcon: const Icon(Icons
                                                        .keyboard_arrow_down),
                                                    buttonText: c.isLoadOrigin
                                                        ? const Text(
                                                            'Loading...')
                                                        : Text(
                                                            c.selectedOrigin
                                                                    .isNotEmpty
                                                                ? '${c.selectedOrigin.length} ${'Origin'.tr}...'
                                                                    .tr
                                                                : 'Origin'.tr,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              color: CustomTheme()
                                                                  .textColor(
                                                                      context),
                                                            ),
                                                          ),
                                                    initialValue:
                                                        c.selectedOrigin,
                                                    items: c.originList
                                                        .map((e) =>
                                                            MultiSelectItem(
                                                              e,
                                                              '${e.originCode}-${e.originName}',
                                                            ))
                                                        .toList(),
                                                    listType:
                                                        MultiSelectListType
                                                            .CHIP,
                                                    chipDisplay:
                                                        MultiSelectChipDisplay
                                                            .none(),
                                                    backgroundColor:
                                                        AppConst.isLightTheme(
                                                                context)
                                                            ? whiteColor
                                                            : greyColor,
                                                    itemsTextStyle: TextStyle(
                                                        color: CustomTheme()
                                                            .textColor(
                                                                context)),
                                                    onConfirm: (values) {
                                                      c.selectedOrigin.clear();
                                                      c.selectedOrigin
                                                          .addAll(values);
                                                      c.update();
                                                    },
                                                    onSelectionChanged:
                                                        (values) {
                                                      c.selectedOrigin
                                                          .value = List<
                                                              OriginModel>.from(
                                                          values);
                                                      c.update();
                                                    },
                                                  ),
                                                ),
                                              ],
                                            );
                                          }
                                          return const SizedBox();
                                        },
                                      )
                                    : const SizedBox(),
                                c.buatPesanan &&
                                        (c.countSelectedAccountNA ?? 0) > 0
                                    ? Container(
                                        margin: const EdgeInsets.only(left: 32),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomTextFormField(
                                              width: Get.width * 0.39,
                                              multiLine: true,
                                              controller: c.alamat,
                                              hintText: 'Alamat'.tr,
                                              validator: ValidationBuilder()
                                                  .address()
                                                  .build(),
                                            ),
                                            const SizedBox(width: 10),
                                            CustomTextFormField(
                                              width: Get.width * 0.18,
                                              controller: c.zipCode,
                                              hintText: 'Kode Pos'.tr,
                                              validator: ValidationBuilder()
                                                  .zipCode()
                                                  .build(),
                                              inputType: TextInputType.number,
                                            )
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),
                                c.beranda || c.riwayatPesanan || c.pantauPaketmu
                                    ? _buildCheckboxItem(
                                        'Tampilkan Seluruh Transaksi',
                                        c.semuaTransaksi, (value) {
                                        c.semuaTransaksi = value!;
                                        c.update();
                                      })
                                    : const SizedBox(),
                                c.hapusPesanan
                                    ? _buildCheckboxItem(
                                        'Hapus Seluruh Transaksi', c.semuaHapus,
                                        (value) {
                                        c.semuaHapus = value!;
                                        c.update();
                                      })
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem(
                                  'Riwayat Kirimanmu', c.riwayatPesanan,
                                  (value) {
                                c.riwayatPesanan = value!;
                                if (value == false) {
                                  c.semuaTransaksi = false;
                                }
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Lacak Kirimanmu', c.lacakPesanan, (value) {
                                c.lacakPesanan = value!;
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Minta Dijemput', c.mintaDijemput, (value) {
                                c.mintaDijemput = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Serah Terima', c.serahTerima,
                                  (value) {
                                c.serahTerima = value!;
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Print Kirimanmu', c.cetakPesanan, (value) {
                                c.cetakPesanan = value!;
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Hapus Transaksi', c.hapusPesanan, (value) {
                                c.hapusPesanan = value!;
                                if (value == false) {
                                  c.semuaHapus = false;
                                }
                                c.update();
                              }),
                            ],
                          ),

                          // Keuanganmu Section with Icon
                          _buildSectionTitle(
                            context,
                            title: 'Keuanganmu'.tr,
                            icon: Icons.account_balance_wallet_outlined,
                          ),
                          const SizedBox(height: 10),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem('Uang COD Kamu', c.uangCod,
                                  (value) {
                                c.uangCod = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Tagihan Kamu', c.tagihan,
                                  (value) {
                                c.tagihan = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Laporan Pembayaran Aggregasi',
                                  c.monitoringAgg, (value) {
                                c.monitoringAgg = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Bonus Kamu', c.bonus,
                                  (value) {
                                c.bonus = value!;
                                c.update();
                              }),
                            ],
                          ),

                          // Hubungi Aku Section with Icon
                          _buildSectionTitle(
                            context,
                            title: 'Hubungi Aku'.tr,
                            icon: Icons.phone,
                          ),
                          const SizedBox(height: 10),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem('Laporanku', c.laporan,
                                  (value) {
                                c.laporan = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('E-Claim', c.eclaim, (value) {
                                c.eclaim = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Cek Ongkir', c.cekOngkir,
                                  (value) {
                                c.cekOngkir = value!;
                                c.update();
                              }),
                            ],
                          ),

                          // Laporanku Section with Icon
                          _buildSectionTitle(
                            context,
                            title: 'Laporanku'.tr,
                            icon: Icons.library_books_outlined,
                          ),
                          const SizedBox(height: 10),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem(
                                  'Laporan Return', c.laporanReturn, (value) {
                                c.laporanReturn = value!;
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Summary Origin', c.summaryOrigin, (value) {
                                c.summaryOrigin = value!;
                                c.update();
                              }),
                              _buildCheckboxItem(
                                  'Summary Destination', c.summaryDestination,
                                  (value) {
                                c.summaryDestination = value!;
                                c.update();
                              }),
                            ],
                          ),

                          // Pengaturan Section with Icon
                          _buildSectionTitle(
                            context,
                            title: 'Pengaturan'.tr,
                            icon: Icons.settings,
                          ),
                          const SizedBox(height: 10),
                          _buildCheckboxGroup(
                            context,
                            checkboxes: [
                              _buildCheckboxItem('Tema', c.tema, (value) {
                                c.tema = value!;
                                c.update();
                              }),
                              _buildCheckboxItem('Label', c.label, (value) {
                                c.label = value!;
                                c.update();
                              }),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                CustomFilledButton(
                  color: blueJNE,
                  title: c.isEdit ? "Edit Petugas".tr : "Simpan Petugas".tr,
                  suffixIcon: Icons.file_download_outlined,
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

  // Builds section title with icon
  Widget _buildSectionTitle(BuildContext context,
      {required String title, required IconData icon}) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).brightness == Brightness.light
                ? blueJNE
                : Colors.white,
          ),
          const SizedBox(width: 8),
          Text(
            title,
            style: listTitleTextStyle.copyWith(
                color: Theme.of(context).brightness == Brightness.light
                    ? greyDarkColor1
                    : whiteColor),
          ),
        ],
      ),
    );
  }

  // Builds a group of checkboxes in two columns
  Widget _buildCheckboxGroup(BuildContext context,
      {required List<Widget> checkboxes}) {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.only(left: 32, right: 0, top: 0, bottom: 12),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 3),
      itemCount: checkboxes.length,
      itemBuilder: (context, index) {
        return checkboxes[index];
      },
    );
  }

  // Builds individual checkbox with label
  Widget _buildCheckboxItem(
      String label, bool value, ValueChanged<bool?> onChanged) {
    return CustomCheckbox(
      label: label.tr,
      value: value,
      onChanged: onChanged,
    );
  }
}
