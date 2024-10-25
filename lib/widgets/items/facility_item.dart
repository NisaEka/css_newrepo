import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:flutter/material.dart';

class FacilityItem extends StatelessWidget {
  final FacilityModel facility;
  final VoidCallback? onTap;

  const FacilityItem({super.key, required this.facility, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).brightness == Brightness.light
          ? whiteColor
          : greyColor,
      child: InkWell(
          onTap: onTap,
          child: SizedBox(
              width: 112,
              height: 172,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    marker(),
                    Padding(
                      padding: const EdgeInsets.all(4),
                      child: Column(
                        children: [image(), title()],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }

  Widget marker() {
    var imagePath = "";

    if (facility.enabled) {
      imagePath = "assets/icons/checked.png";
    } else if (facility.onProcess) {
      imagePath = 'assets/icons/android-sync.jpg';
    } else {
      imagePath = "assets/icons/cancel.png";
    }

    return Container(
      alignment: Alignment.topRight,
      child: Image(
        image: AssetImage(imagePath),
        width: 24,
        height: 24,
      ),
    );
  }

  Widget image() {
    return AspectRatio(
        aspectRatio: 1 / 1,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Image(image: NetworkImage(facility.icon), fit: BoxFit.cover),
        ));
  }

  Widget title() {
    return Center(
        child: Text(
      facility.name,
      textAlign: TextAlign.center,
      style: sublistTitleTextStyle,
    ));
  }
}
