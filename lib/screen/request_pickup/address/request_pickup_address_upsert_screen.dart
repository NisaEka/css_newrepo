import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/request_pickup/address/location/request_pickup_location_screen.dart';
import 'package:css_mobile/screen/request_pickup/address/request_pickup_address_upsert_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/dialog/message_info_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
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
        });
  }

  Widget _bodyContent(RequestPickupAddressUpsertController controller) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _bodyForm(controller),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16))
          ],
        ),
        controller.createDataLoading ? const LoadingDialog() : Container(),
        controller.createDataFailed ? MessageInfoDialog(
          message: "Data gagal ditambahkan",
          onClickAction: () => controller.onRefreshCreateState(),
        ) : Container()
      ],
    );
  }

  Widget _bodyForm(RequestPickupAddressUpsertController controller) {
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () async {
            Placemark? selectedPlaceMark = await Get.to(() => const RequestPickupLocationScreen());
            controller.onSelectedPlaceMark(selectedPlaceMark);
          },
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
          controller: controller.address,
          label: "Alamat Penjemputan".tr,
          hintText: "Masukkan alamat penjemputan".tr,
          inputType: TextInputType.streetAddress,
          multiLine: true,
        ),
        // CustomSearchDropdownField<Destination>(
        //   label: "Kota Penjemputan".tr,
        //   asyncItems: (String filter) => controller.getDestinationList(filter),
        //   itemBuilder: (context, e, b) {
        //     return GestureDetector(
        //       onTap: () => controller.update(),
        //       child: Container(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        //         child: Text(e.asFacilityFormFormat()),
        //       ),
        //     );
        //   },
        //   itemAsString: (Destination e) => e.asFacilityFormFormat(),
        //   onChanged: (value) {
        //     controller.selectedDestination = value;
        //     controller.update();
        //   },
        //   value: controller.selectedDestination,
        //   isRequired: controller.selectedDestination == null ? true : false,
        //   readOnly: false,
        //   hintText: controller.isLoadDestination
        //       ? "Loading..."
        //       : "Kota / Kecamatan / Kelurahan / Kode Pos".tr,
        //   textStyle: controller.selectedDestination != null
        //       ? subTitleTextStyle
        //       : hintTextStyle,
        // ),
        const SizedBox(height: 16),
        CustomFilledButton(
          color: redJNE,
          title: 'Simpan Alamat'.tr,
          onPressed: () => controller.onSubmitAction(),
        )
      ],
    );
  }
}
