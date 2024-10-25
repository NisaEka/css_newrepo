import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/screen/pengaturan/edit_profil/edit_profil_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class EditProfilScreen extends StatelessWidget {
  const EditProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProfileController>(
        init: EditProfileController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Edit Profil".tr,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                _bodyContent(controller, context),
                controller.isLoading ? const LoadingDialog() : const SizedBox(),
              ],
            ),
          );
        });
  }

  Widget _bodyContent(EditProfileController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: c.formKey,
        child: ListView(
          children: [
            CustomTextFormField(
              controller: c.brand,
              hintText: "Nama Brand / Bisnis".tr,
              validator: ValidationBuilder().name().build(),
            ),
            CustomTextFormField(
              controller: c.name,
              hintText: "Nama Lengkap".tr,
              validator: ValidationBuilder().name().build(),
            ),
            c.isCcrf
                ? CustomTextFormField(
                    controller: c.ktp,
                    hintText: "Nomor Identitas / KTP".tr,
                    readOnly: true,
                  )
                : const SizedBox(),
            CustomTextFormField(
              controller: c.address,
              hintText: "Alamat Lengkap".tr,
              validator: ValidationBuilder().address().build(),
            ),
            !c.isCcrf
                ? CustomSearchDropdownField<Origin>(
                    asyncItems: (String filter) => c.getOriginList(filter),
                    itemBuilder: (context, e, b) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        child: Text(
                          e.originName.toString(),
                        ),
                      );
                    },
                    itemAsString: (Origin e) => e.originName.toString(),
                    onChanged: (value) => c.selectOrigin(value),
                    value: c.selectedOrigin,
                    // selectedItem: c.kotaPengirim.text,
                    hintText:
                        c.isLoadOrigin ? "Loading..." : "Kota Pengiriman".tr,
                    searchHintText: 'Masukan Kota Pengiriman'.tr,
                    textStyle: c.selectedOrigin != null
                        ? subTitleTextStyle
                        : hintTextStyle,
                    isRequired: true,
                    readOnly: false,
                  )
                : const SizedBox(),
            CustomSearchDropdownField<Destination>(
              asyncItems: (String filter) => c.getDestinationList(filter),
              itemBuilder: (context, e, b) {
                return GestureDetector(
                  onTap: () => c.update(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(
                      '${e.zipCode ?? ''}; '
                      '${e.provinceName ?? ''}; '
                      '${e.cityName ?? ''}; '
                      '${e.districtName ?? ''}; '
                      '${e.subdistrictName ?? ''}; '
                      '${e.destinationCode ?? ''}; ',
                    ),
                  ),
                );
              },
              selectedItem: c.ccrfProfil?.generalInfo?.ccrfZipcode,
              itemAsString: (Destination e) => c.isCcrf
                  ? '${e.cityName ?? ''}; '
                      '${e.districtName ?? ''}; '
                      '${e.subdistrictName ?? ''}; '
                      '${e.zipCode ?? ''}'
                  : e.zipCode ?? '',
              onChanged: (value) {
                c.selectedCity = value;
                c.update();
              },
              value: c.selectedCity,
              isRequired: c.selectedCity == null ? true : false,
              readOnly: false,
              hintText: c.isLoading
                  ? "Loading..."
                  : c.isCcrf
                      ? "Kota/Kecamatan/Kelurahan/Kode Pos".tr
                      : "Kode Pos".tr,
              // prefixIcon: const Icon(Icons.location_city),
              textStyle:
                  c.selectedCity != null ? subTitleTextStyle : hintTextStyle,
            ),
            CustomTextFormField(
              controller: c.phone,
              hintText: "Nomor Telepon".tr,
              readOnly: c.isCcrf,
              validator: ValidationBuilder().phoneNumber().build(),
              inputType: TextInputType.number,
            ),
            c.isCcrf
                ? CustomTextFormField(
                    controller: c.whatsapp,
                    hintText: "Nomor Whatsapp".tr,
                    readOnly: true,
                  )
                : const SizedBox(),
            CustomTextFormField(
              controller: c.email,
              hintText: "Email",
              readOnly: true,
            ),
            CustomFilledButton(
              color: blueJNE,
              title: "Edit Profil".tr,
              onPressed: () => c.isCcrf ? c.updateData() : c.updateBasic(),
            )
          ],
        ),
      ),
    );
  }
}
