import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
// import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
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
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _bodyForm(context, controller),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16))
          ],
        ),
        controller.createDataLoading ? const LoadingDialog() : Container(),
      ],
    );
  }

  Widget _bodyForm(
      BuildContext context, RequestPickupAddressUpsertController controller) {
    return Form(
      key: controller.formKey,
      child: Column(
        children: [
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: controller.name,
            label: "Nama Kamu".tr,
            hintText: "Masukkan nama anda".tr,
            inputType: TextInputType.name,
            isRequired: true,
          ),
          CustomTextFormField(
            controller: controller.phone,
            label: "No Handphone".tr,
            hintText: "Masukkan no handphone".tr,
            inputType: TextInputType.phone,
            isRequired: true,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                text: "Kota Penjemputan".tr,
                style: formLabelTextStyle.copyWith(color: textColor(context)),
              ),
            ),
          ),
          CustomSearchDropdownField<Destination>(
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
            itemAsString: (Destination e) => e.asFacilityFormFormat(),
            onChanged: (value) {
              controller.selectedDestination = value;
              controller.update();
            },
            value: controller.selectedDestination,
            isRequired: controller.selectedDestination == null ? true : false,
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
            label: "Alamat Penjemputan".tr,
            hintText: "Masukkan alamat penjemputan".tr,
            inputType: TextInputType.streetAddress,
            multiLine: true,
            isRequired: true,
          ),
          const SizedBox(height: 16),
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
