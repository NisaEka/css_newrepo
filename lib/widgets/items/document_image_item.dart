import 'dart:async';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DocumentImageItem extends StatefulWidget {
  final String? img;
  final String title;
  final VoidCallback onTap;
  final double? lat;
  final double? lng;
  final bool isLoading;

  const DocumentImageItem({
    super.key,
    this.img,
    required this.onTap,
    required this.title,
    this.lat,
    this.lng,
    this.isLoading = false,
  });

  @override
  State<DocumentImageItem> createState() => _DocumentImageItemState();
}

class _DocumentImageItemState extends State<DocumentImageItem> {
  Completer<GoogleMapController>? googleMapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title.tr,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                SizedBox(
                  height: 62,
                  width: 120,
                  child: widget.img != null
                      ? Image.network(
                          widget.img ?? '',
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 62,
                            width: 150,
                            decoration: BoxDecoration(
                              color: greyLightColor3,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: widget.isLoading
                                  ? const CircularProgressIndicator.adaptive()
                                  : const Icon(
                                      Icons.image_not_supported_outlined),
                            ),
                          ),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },
                        )
                      : widget.isLoading
                          ? const Center(
                              child: CircularProgressIndicator.adaptive(),
                            )
                          : GoogleMap(
                              // onMapCreated: _onMapCreated,
                              onMapCreated: (controller) =>
                                  googleMapController?.complete(controller),
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              mapType: MapType.none,
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
            const SizedBox(height: 8),
            const Divider(
              color: greyColor,
            ),
          ],
        ),
      ),
    );
  }
}
