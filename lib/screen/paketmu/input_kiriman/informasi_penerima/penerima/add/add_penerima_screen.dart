import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_penerima/penerima/add/add_penerima_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class AddPenerimaScreen extends StatelessWidget {
  const AddPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddPenerimaController>(
        init: AddPenerimaController(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar: _appBarContent(context),
                body: _bodyContent(controller, context),
              ),
              controller.isLoading ? const LoadingDialog() : const SizedBox()
            ],
          );
        });
  }

  AppBar _appBarContent(BuildContext context) {
    return AppBar(
      elevation: 1,
      title: Text(
        'Tambah Data Penerima'.tr,
        style: appTitleTextStyle.copyWith(
          color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
        ),
      ),
      leading: const CustomBackButton(),
    );
  }

  Widget _bodyContent(AddPenerimaController c, BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(30),
        child: Form(
          key: c.formKey,
          onChanged: () {
            c.formKey.currentState?.validate();
            c.update();
          },
          child: Column(
            children: [
              CustomTextFormField(
                controller: c.namaPenerima,
                hintText: "Nama Penerima".tr,
                prefixIcon: const Icon(Icons.person),
                isRequired: true,
                validator: ValidationBuilder().name().build(),
              ),
              CustomTextFormField(
                controller: c.noHP,
                hintText: "Nomor Telepon".tr,
                inputType: TextInputType.number,
                prefixIcon: const Icon(Icons.phone),
                isRequired: true,
                validator: ValidationBuilder().phoneNumber().build(),
              ),
              CustomSearchDropdownField<Destination>(
                asyncItems: (String filter) => c.getDestinationList(filter),
                itemBuilder: (context, e, b) {
                  return GestureDetector(
                    onTap: () => c.update(),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Text(
                        '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subdistrictName}; ${e.destinationCode}',
                      ),
                    ),
                  );
                },
                itemAsString: (Destination e) =>
                    '${e.zipCode}; ${e.provinceName}; ${e.cityName}; ${e.districtName}; ${e.subdistrictName}; ${e.destinationCode}',
                onChanged: (value) {
                  c.selectedDestination = value;
                  c.update();
                },
                value: c.selectedDestination,
                isRequired: c.selectedDestination == null ? true : false,
                readOnly: false,
                hintText: c.isLoadDestination ? "Loading..." : "Kota Tujuan".tr,
                prefixIcon: const Icon(Icons.location_city),
                textStyle: c.selectedDestination != null ? subTitleTextStyle : hintTextStyle,
              ),
              CustomTextFormField(
                controller: c.alamat,
                hintText: "Alamat".tr,
                prefixIcon: const Icon(Icons.location_city),
                multiLine: true,
                isRequired: true,
                validator: ValidationBuilder().address().build(),
              ),
              CustomFilledButton(
                color: c.formKey.currentState?.validate() == true ? blueJNE : greyColor,
                title: 'Simpan Data Penerima'.tr,
                onPressed: () => c.formKey.currentState?.validate() == true ? c.saveReceiver() : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
