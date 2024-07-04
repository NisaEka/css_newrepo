import 'dart:async';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/request_pickup/address/location/request_pickup_location_controller.dart';
import 'package:css_mobile/util/ext/placement_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RequestPickupLocationScreen extends StatelessWidget {
  const RequestPickupLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: RequestPickupLocationController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: "Pilih Lokasi".tr),
          body: _bodyContent(context, controller),
          bottomNavigationBar: _bottomNavBar(controller),
        );
      },
    );
  }

  Widget? _bottomNavBar(RequestPickupLocationController controller) {
    if (controller.selectedPlaceMark != null) {
      return CustomFilledButton(
        margin: const EdgeInsets.all(16),
        color: redJNE,
        title: 'Pilih Lokasi Ini'.tr,
        onPressed: () {
          Get.back(result: controller.selectedPlaceMark);
        },
      );
    }

    return null;
  }

  Widget _bodyContent(
      BuildContext context, RequestPickupLocationController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _mapsView(controller),
          const SizedBox(height: 24),
          _searchBar(context, controller),
          const SizedBox(height: 16),
          _locationList(controller)
        ],
      ),
    );
  }

  Widget _mapsView(RequestPickupLocationController controller) {
    final Completer<GoogleMapController> googleMapController =
        Completer<GoogleMapController>();

    const CameraPosition kGooglePlex =
        CameraPosition(target: LatLng(-6.9506528, 107.6234307), zoom: 16.0);

    return Container(
      width: Get.width,
      height: Get.width / 2,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            zoomControlsEnabled: false,
            myLocationButtonEnabled: true,
            initialCameraPosition: kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              googleMapController.complete(controller);
            },
            onCameraMove: (CameraPosition position) =>
                controller.onCameraMove(position.target),
            onCameraIdle: () => controller.onCameraIdle(),
          ),
          const Icon(
            Icons.location_on,
            size: 24,
            color: blueJNE,
          ),
        ],
      ),
    );
  }

  Widget _searchBar(
      BuildContext context, RequestPickupLocationController controller) {
    return TextField(
      controller: controller.addressText,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.outline, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(16))),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(16))),
        hintText: "Cari alamat".tr,
      ),
      onChanged: (String newText) => controller.onAddressTextChanged(newText),
    );
  }

  Widget _locationList(RequestPickupLocationController controller) {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          Placemark placeMark = controller.placeMarks[index];
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () => controller.onSetSelectedPlaceMark(placeMark),
            child: Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(placeMark.toReadableAddress()),
                )
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index < controller.placeMarks.length) {
            return const Divider(
              thickness: 1,
              color: greyLightColor3,
            );
          } else {
            return Container();
          }
        },
        itemCount: controller.placeMarks.length,
      ),
    );
  }
}
