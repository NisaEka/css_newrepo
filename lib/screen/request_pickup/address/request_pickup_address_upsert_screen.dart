import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/request_pickup/address/location/request_pickup_location_screen.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
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
          body: _bodyContent(controller),
        );
      }
    );
  }

  Widget _bodyContent(RequestPickupAddressUpsertController controller) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: SizedBox(height: 16)
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _bodyForm(controller),
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16)
        )
      ],
    );
  }

  Widget _bodyForm(RequestPickupAddressUpsertController controller) {
    return Column(
      children: [
        GestureDetector(
          onTap: () { Get.to(const RequestPickupLocationScreen()); },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Pilih berdasarkan lokasi"),
              Icon(Icons.keyboard_arrow_right)
            ],
          ),
        ),
        const SizedBox(height: 16),
        CustomTextFormField(
          controller: controller.name,
          label: "Nama Kamu".tr,
          hintText: "Masukkan nama anda".tr,
          inputType: TextInputType.name,
        ),
        CustomTextFormField(
          controller: controller.phone,
          label: "No Handphone".tr,
          hintText: "Masukkan no handphone".tr,
          inputType: TextInputType.phone,
        ),
        CustomTextFormField(
          controller: controller.name,
          label: "Alamat Penjemputan".tr,
          hintText: "Masukkan alamat penjemputan".tr,
          inputType: TextInputType.streetAddress,
        ),
        CustomTextFormField(
          controller: controller.name,
          label: "Kota Penjemputan".tr,
          hintText: "Masukkan kota penjemputan".tr,
          inputType: TextInputType.streetAddress,
        ),
        const SizedBox(height: 16),
        CustomFilledButton(
          color: redJNE,
          title: 'Simpan Alamat'.tr,
          onPressed: () {
            Get.back();
          },
        )
      ],
    );
  }

}