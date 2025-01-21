import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_controller.dart';
import 'package:css_mobile/util/validator/custom_validation_builder.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';

class RequestPickupAddressUpsertScreen extends StatelessWidget {
  const RequestPickupAddressUpsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: RequestPickupAddressUpsertController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: "Tambah Alamat Penjemputan".tr,
            ),
            body: _bodyContent(context, controller),
          );
        });
  }

  Widget _bodyContent(
      BuildContext context, RequestPickupAddressUpsertController controller) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
            child: _bodyForm(context, controller),
          ),
        ),
        controller.createDataLoading ? const LoadingDialog() : Container(),
      ],
    );
  }

  Widget _bodyForm(
      BuildContext context, RequestPickupAddressUpsertController controller) {
    return Form(
      key: controller.formKey,
      // onChanged: () {
      //   controller.update();
      // },
      child: Column(
        children: [
          CustomTextFormField(
            controller: controller.name,
            // label: "Nama Kamu".tr,
            hintText: "Nama Kamu".tr,
            inputType: TextInputType.name,
            isRequired: true,
            prefixIcon: const Icon(Icons.person_2_rounded),
          ),
          CustomTextFormField(
            controller: controller.phone,
            // label: "No Handphone".tr,
            hintText: "No Handphone".tr,
            inputType: TextInputType.phone,
            isRequired: true,
            prefixIcon: const Icon(Icons.phone_rounded),
            validator: ValidationBuilder().phoneNumber().build(),
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: RichText(
          //     text: TextSpan(
          //       // text: "Kota Penjemputan".tr,
          //       style: formLabelTextStyle.copyWith(color: textColor(context)),
          //     ),
          //   ),
          // ),
          CustomSearchDropdownField<DestinationModel>(
            asyncItems: (String filter) =>
                controller.getDestinationList(filter),
            itemBuilder: (context, e, b) {
              return GestureDetector(
                  onTap: () => controller.update(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(e.asFacilityFormFormat()),
                  ));
            },
            itemAsString: (DestinationModel e) => e.asFacilityFormFormat(),
            onChanged: (value) {
              controller.selectedDestination = value;
              controller.update();
            },
            value: controller.selectedDestination,
            isRequired: controller.selectedDestination == null ? true : false,
            prefixIcon: const Icon(Icons.trip_origin_rounded),
            readOnly: false,
            hintText: controller.isLoadDestination
                ? "Loading..."
                : "Kota Penjemputan".tr,
            textStyle: controller.selectedDestination != null
                ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: formTextColor(context),
                    )
                : hintTextStyle,
          ),
          CustomTextFormField(
            controller: controller.address,
            // label: "Alamat Penjemputan".tr,
            hintText: "Alamat Penjemputan".tr,
            inputType: TextInputType.streetAddress,
            multiLine: true,
            prefixIcon: const Icon(Icons.home_work_rounded),
            isRequired: true,
          ),
          CustomFilledButton(
            color: primaryColor(context),
            title: 'Simpan Alamat'.tr,
            onPressed: () => controller.formKey.currentState?.validate() == true
                ? controller.onSubmitAction()
                : null,
          )
        ],
      ),
    );
  }
}
