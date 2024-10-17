import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/informasi_pengirim/dropshipper/add/add_dropshipper_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
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
      shadowColor: greyColor,
      elevation: 1,
      leading: const CustomBackButton(),
      title: Text(
        'Tambah Data Dropshipper'.tr,
        // style: appTitleTextStyle.copyWith(
          // color: AppConst.isLightTheme(context) ? blueJNE : whiteColor,
        // ),
      ),
    );
  }

  Widget _bodyContent(AddDropshipperController c, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: c.formKey,
          onChanged: () {
            c.update();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextFormField(
                controller: c.namaPengirim,
                hintText: "Nama Pengirim".tr,
                isRequired: true,
                prefixIcon: const Icon(Icons.person),
                validator: ValidationBuilder().name().build(),
              ),
              CustomTextFormField(
                controller: c.noHP,
                hintText: "Nomor Telepon".tr,
                inputType: TextInputType.number,
                isRequired: true,
                prefixIcon: const Icon(Icons.phone),
                validator: ValidationBuilder().phoneNumber().build(),
              ),
              CustomSearchDropdownField<Origin>(
                asyncItems: (String filter) => c.getOriginList(filter, c.account.accountId ?? ''),
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
                  c.selectedOrigin = value;
                  c.kotaPengirim.text = c.selectedOrigin?.originName ?? '';
                  // c.kodePos.text = c.selectedOrigin?. ?? '';
                  c.update();
                },
                value: c.selectedOrigin,
                selectedItem: c.kotaPengirim.text,
                hintText: c.isLoadOrigin ? "Loading..." : "Kota Pengirim".tr,
                prefixIcon: const Icon(Icons.location_city),
                textStyle: c.selectedOrigin != null ? subTitleTextStyle : hintTextStyle,
                readOnly: false,
                isRequired: true,
              ),
              CustomTextFormField(
                controller: c.kodePos,
                hintText: "Kode Pos".tr,
                isRequired: true,
                prefixIcon: const Icon(Icons.line_style),
                validator: ValidationBuilder().zipCode().build(),
                inputType: TextInputType.number,
              ),
              CustomTextFormField(
                controller: c.alamatPengirim,
                hintText: "Alamat".tr,
                isRequired: true,
                multiLine: true,
                prefixIcon: const Icon(Icons.location_city),
                validator: ValidationBuilder().address().build(),
              ),
              CustomFilledButton(
                  color: c.formKey.currentState?.validate() ?? false ? blueJNE : greyColor,
                  title: "Simpan Data Dropshipper".tr,
                  // radius: 20,
                  onPressed: () => c.formKey.currentState?.validate() == true ? c.saveDropshipper() : null),
            ],
          ),
        ),
      ),
    );
  }
}
