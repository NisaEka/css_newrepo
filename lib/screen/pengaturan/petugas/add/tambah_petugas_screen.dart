import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
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
                          controller: controller.kataSandi,
                          hintText: 'Kata Sandi'.tr,
                          suffixIcon: const Icon(Icons.visibility),
                        ),
                        CustomTextFormField(
                          controller: controller.kataSandiConfirm,
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
                              Column(children: [
                                CustomCheckbox(
                                  label: 'Profilku'.tr,
                                  value: controller.profil,
                                  onChanged: (value) {
                                    controller.profil = value!;
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
                                  value: controller.ubahPassword,
                                  onChanged: (value) {
                                    controller.ubahPassword = value!;
                                    controller.update();
                                  },
                                ),
                                CustomCheckbox(
                                  label: 'Beranda'.tr,
                                  value: controller.beranda,
                                  onChanged: (value) {
                                    controller.beranda = value!;
                                    controller.update();
                                  },
                                ),
                              ])
                            ],
                          ),
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
