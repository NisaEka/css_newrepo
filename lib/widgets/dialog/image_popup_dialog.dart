import 'dart:async';

import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ImagePopupDialog extends StatefulWidget {
  final String title;
  final String? img;
  final double? lat;
  final double? lng;

  const ImagePopupDialog({
    super.key,
    required this.title,
    this.img,
    this.lat,
    this.lng,
  });

  @override
  State<ImagePopupDialog> createState() => _ImagePopupDialogState();
}

class _ImagePopupDialogState extends State<ImagePopupDialog> {
  late GoogleMapController mapController;
  Completer<GoogleMapController>? googleMapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5),
      backgroundColor: AppConst.isLightTheme(context) ? whiteColor : greyColor,
      title: Text(widget.title.tr),
      content: widget.lat != null
          ? GoogleMap(
              // onMapCreated: _onMapCreated,
              onMapCreated: (controller) => googleMapController?.complete(controller),
              zoomControlsEnabled: false,
              myLocationButtonEnabled: false,
              markers: <Marker>{
                Marker(
                  draggable: false,
                  markerId: const MarkerId('SomeId'),
                  position: LatLng(
                    widget.lat!,
                    widget.lng!,
                  ),
                )
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  widget.lat!,
                  widget.lng!,
                ),
                zoom: 16.0,
              ),
            )
          : Image.network(
              widget.img ?? '',
              fit: BoxFit.fill,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 62,
                width: 153,
                decoration: BoxDecoration(
                  // color: greyLightColor3,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Center(child: Icon(Icons.image_not_supported_outlined)),
              ),
              loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text('Tutup'.tr),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }
}
