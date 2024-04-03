import 'dart:async';

import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DocumentImageItem extends StatefulWidget {
  final String? img;
  final String title;
  final VoidCallback onTap;
  final double? lat;
  final double? lng;

  const DocumentImageItem({
    super.key,
    this.img,
    required this.onTap,
    required this.title,
    this.lat,
    this.lng,
  });

  @override
  State<DocumentImageItem> createState() => _DocumentImageItemState();
}

class _DocumentImageItemState extends State<DocumentImageItem> {
  Completer<GoogleMapController>? googleMapController;

  @override
  void initState() {
    super.initState();
    print('lat: ${widget.lat}');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: whiteColor,
          border: Border.all(color: greyDarkColor1),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: blueJNE,
              spreadRadius: 1,
              offset: Offset(-2, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.title.tr, style: subTitleTextStyle),
            SizedBox(
              height: 62,
              width: 153,
              child: widget.img != null
                  ? Image.network(
                      widget.img ?? '',
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 62,
                        width: 153,
                        decoration: BoxDecoration(
                          color: greyLightColor3,
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
                    )
                  : GoogleMap(
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
