import 'dart:async';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/notification/notification_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notifikasi".tr),
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(NotificationController c, BuildContext context) {
    Completer<GoogleMapController>? googleMapController;

    return Column(
      children: [
        // Text(c.message.notification?.title.toString() ?? ''),
        // Text(c.message.notification?.body.toString() ?? ''),
        // Text(c.message.data.toString() ?? ''),
        Container(
          height: Get.width,
          color: greyColor,
          child: GoogleMap(
            // onMapCreated: _onMapCreated,
            onMapCreated: (controller) => googleMapController?.complete(controller),
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            markers: <Marker>{
              const Marker(
                draggable: false,
                markerId: MarkerId('SomeId'),
                position: LatLng(
                  -7.5606065,
                  112.6470759,
                ),
              )
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                -7.5606065,
                112.6470759,
              ),
              zoom: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
