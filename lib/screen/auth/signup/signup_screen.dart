import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/reusable/forms/customdropdownformfield.dart';
import 'package:css_mobile/reusable/forms/customfilledbutton.dart';
import 'package:css_mobile/reusable/forms/customformlabel.dart';
import 'package:css_mobile/reusable/forms/customtextformfield.dart';
import 'package:css_mobile/screen/auth/signup/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
        init: SignUpController(),
        builder: (controller) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: Get.height / 4,
                        alignment: Alignment.topLeft,
                        child: SvgPicture.asset(ImageConstant.vector2),
                      ),
                      Positioned(
                        top: 140,
                        left: 0,right: 0,
                        child: Image.asset(ImageConstant.logoCSS_blue, height: 67),
                      ),
                    ],
                  ),
                  Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40, top: 30),
                      child: Column(
                        children: [
                          Center(child: Text('Buat akun anda'.tr, style: listTitleTextStyle)),
                          const SizedBox(height: 25),
                          CustomTextFormField(
                            controller: controller.namaLengkap,
                            prefixIcon: const Icon(Icons.person),
                            hintText: 'Nama Lengkap'.tr,
                          ),
                          CustomTextFormField(
                            controller: controller.namaBrand,
                            prefixIcon: const Icon(Icons.storefront_sharp),
                            hintText: 'Nama Brand / Bisnis'.tr,
                          ),
                          CustomTextFormField(
                            controller: controller.noHp,
                            prefixIcon: const Icon(Icons.phone),
                            hintText: 'No Handphone'.tr,
                          ),
                          CustomTextFormField(
                            controller: controller.email,
                            prefixIcon: const Icon(Icons.mail_outline),
                            hintText: 'Email'.tr,
                          ),
                          CustomTextFormField(
                            controller: controller.kodeReferal,
                            prefixIcon: const Icon(Icons.line_style),
                            hintText: 'Kode Referal'.tr,
                          ),
                          CustomDropDownFormField(
                            items: [],
                            prefixIcon: const Icon(Icons.location_city),
                            hintText: 'Kota Pengiriman'.tr,
                            textStyle: hintTextStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sudah menggunakan JNE'.tr),
                              Switch(
                                value: controller.pakaiJNE,
                                onChanged: (value) {
                                  controller.pakaiJNE = value;
                                  controller.update();
                                },
                              )
                            ],
                          ),
                          controller.pakaiJNE
                              ? CustomDropDownFormField(
                                  items: [],
                                  hintText: 'Agen / Sales Counter'.tr,
                                )
                              : const SizedBox(),
                          CustomFilledButton(
                            color: blueJNE,
                            title: 'Daftar'.tr,
                            radius: 50,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30,bottom: 20),
                            // height: 110,
                            child: Column(
                              children: [
                                Image.asset(
                                  ImageConstant.logoJNE,
                                  height: 56,
                                ),
                                Text('ver ${controller.version}')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
