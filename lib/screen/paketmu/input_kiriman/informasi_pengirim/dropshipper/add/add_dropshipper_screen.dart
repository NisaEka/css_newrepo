import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/add/add_dropshipper_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class AddDropshipperScreen extends StatelessWidget {
  const AddDropshipperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDropshipperController>(
        init: AddDropshipperController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              shadowColor: greyColor,
              elevation: 1,
              leading: const CustomBackButton(),
              title: Text('Tambah Data Dropshipper'.tr,
                  style: appTitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? blueJNE : whiteColor)),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Form(
                  key: controller.formKey,
                  onChanged: () {
                    controller.update();
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomTextFormField(
                        controller: controller.namaPengirim,
                        hintText: "Nama Pengirim".tr,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.person),
                      ),
                      CustomTextFormField(
                        controller: controller.noHP,
                        hintText: "Nomor Telepon".tr,
                        inputType: TextInputType.number,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.phone),
                        validator: ValidationBuilder().phone().build(),
                      ),
                      CustomSearchDropdownField<Origin>(
                        asyncItems: (String filter) => controller.getOriginList(filter, controller.account.accountId ?? ''),
                        itemBuilder: (context, e, b) {
                          return Container(
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            child: Text(
                              e.originName.toString(),
                            ),
                          );
                        },
                        itemAsString: (Origin e) => e.originName.toString(),
                        onChanged: (value) {
                          controller.selectedOrigin = value;
                          controller.kotaPengirim.text = controller.selectedOrigin?.originName ?? '';
                          // controller.kodePos.text = controller.selectedOrigin?.
                          controller.update();
                          // print(jsonEncode(value));
                        },
                        value: controller.selectedOrigin,
                        selectedItem: controller.kotaPengirim.text,
                        hintText: controller.isLoadOrigin ? "Loading..." : "Kota Pengirim".tr,
                        prefixIcon: const Icon(Icons.location_city),
                        textStyle: controller.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                        readOnly: false,
                        isRequired: true,
                      ),
                      CustomTextFormField(
                        controller: controller.kodePos,
                        hintText: "Kode Pos".tr,
                        isRequired: true,
                        prefixIcon: const Icon(Icons.line_style),
                        validator: ValidationBuilder().zipCode().build(),
                        inputType: TextInputType.number,

                      ),
                      CustomTextFormField(
                        controller: controller.alamatPengirim,
                        hintText: "Alamat".tr,
                        isRequired: true,
                        multiLine: true,
                        prefixIcon: const Icon(Icons.location_city),
                      ),
                      CustomFilledButton(
                          color: controller.formKey.currentState?.validate() ?? false ? blueJNE : greyColor,
                          title: "Simpan Data Dropshipper".tr,
                          // radius: 20,
                          onPressed: () => controller.formKey.currentState?.validate() == true ? controller.saveDropshipper() : null),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
