import 'dart:async';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/request_pickup/address/location/request_pickup_location_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:flutter/material.dart';
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
          appBar: CustomTopBar(
            title: "Pilih Lokasi".tr
          ),
          body: _bodyContent(controller),
        );
      },
    );
  }

  Widget _bodyContent(RequestPickupLocationController controller) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _mapsView(),
          const SizedBox(height: 24),
          _searchBar(),
          const SizedBox(height: 16),
          _locationList()
        ],
      ),
    );
  }

  Widget _mapsView() {
    final Completer<GoogleMapController> googleMapController =
      Completer<GoogleMapController>();

    const CameraPosition kGooglePlex = CameraPosition(
      target: LatLng(-6.9506528, 107.6234307),
      zoom: 16.0
    );

    return Container(
      width: Get.width,
      height: Get.width / 2,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16)
      ),
      child: GoogleMap(
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        initialCameraPosition: kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          googleMapController.complete(controller);
        }
      ),
    );
  }

  Widget _searchBar() {
    return const TextField(
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        hintText: "Cari alamat",
      ),
    );
  }

  Widget _locationList() {
    return Expanded(
      child: ListView.separated(
        itemBuilder: (BuildContext context, int index) {
          return const Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 16),
              Text("Bandung")
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          if (index < 2) {
            return const Divider(
              thickness: 1,
              color: greyLightColor3,
            );
          } else {
            return Container();
          }
        },
        itemCount: 3,
      ),
    );
  }

}