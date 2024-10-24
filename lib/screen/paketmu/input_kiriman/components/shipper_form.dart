import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/list_dropshipper_button.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/shipper_info/shipper_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customswitch.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/forms/origin_dropdown.dart';
import 'package:css_mobile/widgets/items/account_list_item.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class ShipperForm extends StatelessWidget {
  const ShipperForm({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShipperController>(
        init: ShipperController(),
        builder: (c) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  width: Get.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                        key: c.state.formKey,
                        onChanged: () {
                          c.formValidate();
                          c.connection.isOnline().then((value) => c.state.isOnline = value);
                          c.update();
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomFormLabel(label: 'Nomor Akun'.tr),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: c.state.isLoading
                                  ? Row(
                                      children: List.generate(
                                        3,
                                        (index) => AccountListItem(isLoading: true),
                                      ),
                                    )
                                  : Row(
                                      children: c.state.accountList
                                          .map(
                                            (e) => AccountListItem(
                                              data: e,
                                              isSelected: c.state.selectedAccount == e ? true : false,
                                              onTap: () => c.selectAccount(e),
                                            ),
                                          )
                                          .toList(),
                                    ),
                            ),
                            CustomSwitch(
                              value: c.state.isDropshipper,
                              label: 'Kirim sebagai dropshipper'.tr,
                              onChange: (bool? value) => c.sendAsDropshipper(value),
                            ),
                            c.state.selectedAccount?.accountService == "JLC"
                                ? CustomSwitch(
                                    value: c.state.codOgkir,
                                    label: 'COD Ongkir'.tr,
                                    onChange: (bool? value) {
                                      c.state.codOgkir = value!;
                                      c.update();
                                    },
                                  )
                                : const SizedBox(),
                            const ListDropshipperButton(),
                            CustomTextFormField(
                              controller: c.state.shipperName,
                              hintText: "Nama Pengirim".tr,
                              readOnly: !c.state.isDropshipper,
                              isRequired: true,
                              prefixIcon: const Icon(Icons.person),
                              validator: ValidationBuilder().name().build(),
                            ),
                            CustomTextFormField(
                              controller: c.state.shipperPhone,
                              hintText: "Nomor Telepon".tr,
                              inputType: TextInputType.number,
                              readOnly: !c.state.isDropshipper,
                              isRequired: true,
                              prefixIcon: const Icon(Icons.phone),
                              validator: ValidationBuilder().phoneNumber().build(),
                            ),
                            OriginDropdown(
                              label: "Kota Pengirim".tr,
                              isRequired: c.state.isOnline,
                              selectedItem: c.state.shipperOrigin.text,
                              readOnly: c.state.selectedAccount == null || c.state.isOnline == false ? true : !c.state.isDropshipper,
                              prefixIcon: const Icon(Icons.location_city),
                              onChanged: (value) {
                                c.state.selectedOrigin = value;
                                c.state.shipperOrigin.text = c.state.selectedOrigin?.originName ?? '';
                                // controller.kodePos.text = controller.selectedOrigin?.
                                c.update();
                              },
                            ),
                            //TODO: implement profile ccrf
                            CustomTextFormField(
                              controller: c.state.shipperZipCode,
                              hintText: "Kode Pos".tr,
                              // readOnly: !c.state.isDropshipper,
                              // isRequired: true, implement profile ccrf
                              prefixIcon: const Icon(Icons.line_style),
                              // validator: ValidationBuilder().zipCode().build(),
                              inputType: TextInputType.number,
                            ),
                            CustomTextFormField(
                              controller: c.state.shipperAddress,
                              hintText: "Alamat".tr,
                              readOnly: !c.state.isDropshipper,
                              isRequired: true,
                              multiLine: true,
                              prefixIcon: const Icon(Icons.location_city),
                              validator: ValidationBuilder().address().build(),
                            ),
                            c.state.isDropshipper && c.state.isOnline && c.isSaveDropshipper()
                                ? CustomFilledButton(
                                    color: whiteColor,
                                    borderColor: c.state.isValidate ? blueJNE : greyColor,
                                    title: 'Simpan Data Dropshipper'.tr,
                                    fontColor: c.state.isValidate ? blueJNE : greyColor,
                                    onPressed: () => c.state.isValidate ? c.saveDropshipper() : null,
                                  )
                                : const SizedBox(),
                            CustomFilledButton(
                              color: c.state.isValidate ? blueJNE : greyColor,
                              title: "Selanjutnya".tr,
                              // radius: 20,
                              onPressed: () {
                                c.state.isValidate ? c.nextStep() : null;
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
