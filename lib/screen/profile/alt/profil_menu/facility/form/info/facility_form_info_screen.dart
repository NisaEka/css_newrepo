import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/info/facility_form_info_controller.dart';
import 'package:css_mobile/screen/profile/alt/profil_menu/facility/form/return/facility_form_return_screen.dart';
import 'package:css_mobile/widgets/bar/customstepper.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class FacilityFormInfoScreen extends StatelessWidget {
  const FacilityFormInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: FacilityFormInfoController(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar: _appBarContent(controller),
              body: _bodyContent(controller, context),
              bottomNavigationBar: _nextButton(controller),
            )
          ],
        );
      },
    );
  }

  Widget _nextButton(FacilityFormInfoController c) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: CustomFilledButton(
          color: redJNE,
          title: 'Selanjutnya'.tr,
          onPressed: () {
            Get.to(const FacilityFormReturnScreen(), arguments: {'data': c.submitData(), 'destination': c.selectedDestination});
          },
        ));
  }

  Widget _bodyContent(FacilityFormInfoController c, BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
            child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(controller: c.brand, hintText: 'Nama Toko / Perusahaan', validator: ValidationBuilder().maxLength(32).build()),
              CustomTextFormField(
                  controller: c.idCardNumber,
                  hintText: 'No Identitas / KTP',
                  inputType: TextInputType.number,
                  inputFormatters: const [],
                  validator: ValidationBuilder().maxLength(16).minLength(16).build()),
              Container(
                  width: Get.width,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white,
                      )),
                  child: _imagePickerContent(context, c)),
              CustomTextFormField(
                controller: c.fullName,
                hintText: 'Nama Lengkap',
                inputType: TextInputType.name,
                validator: ValidationBuilder().maxLength(32).build(),
              ),
              CustomTextFormField(
                controller: c.fullAddress,
                hintText: 'Alamat Lengkap',
                inputType: TextInputType.streetAddress,
                validator: ValidationBuilder().maxLength(128).build(),
              ),
              CustomSearchDropdownField<Destination>(
                asyncItems: (String filter) => c.getDestinationList(filter),
                itemBuilder: (context, e, b) {
                  return GestureDetector(
                    onTap: () => c.update(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text(e.asFacilityFormFormat()),
                    ),
                  );
                },
                itemAsString: (Destination e) => e.asFacilityFormFormat(),
                onChanged: (value) {
                  c.selectedDestination = value;
                  c.update();
                },
                value: c.selectedDestination,
                isRequired: c.selectedDestination == null ? true : false,
                readOnly: false,
                hintText: c.isLoadDestination ? "Loading..." : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
                textStyle: c.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
              ),
              CustomTextFormField(
                controller: c.phone,
                hintText: 'No. Telp',
                inputType: TextInputType.phone,
                validator: ValidationBuilder().maxLength(15).phone().build(),
              ),
              CustomTextFormField(
                  controller: c.whatsAppPhone,
                  hintText: 'No. WhatsApp',
                  inputType: TextInputType.phone,
                  validator: ValidationBuilder().maxLength(15).phone().build()),
              CustomTextFormField(
                  controller: c.email,
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                  inputFormatters: const [],
                  validator: ValidationBuilder().maxLength(64).email().build())
            ],
          ),
        ))
      ],
    );
  }

  CustomTopBar _appBarContent(FacilityFormInfoController c) {
    return CustomTopBar(
      title: 'Upgrade Profil Kamu'.tr,
      flexibleSpace: Column(
        children: [
          CustomStepper(
            currentStep: 0,
            totalStep: c.steps.length,
            steps: c.steps,
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }

  Widget _imagePickerContent(BuildContext context, FacilityFormInfoController controller) {
    if (controller.pickedImage != null) {
      return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
        child: Image(image: FileImage(controller.pickedImage!), fit: BoxFit.fitWidth),
      );
    } else {
      return TextButton(
        onPressed: () {
          controller.pickImage();
        },
        child: Text(
          'Pilih Gambar Identitas / KTP',
          style: sublistTitleTextStyle.copyWith(color: Theme.of(context).brightness == Brightness.light ? Colors.black : Colors.white),
        ),
      );
    }
  }
}
