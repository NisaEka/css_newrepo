import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DocumentImageItem extends StatelessWidget {
  final String? img;
  final String title;
  final VoidCallback onTap;
  final String? lat;
  final String? lng;

  const DocumentImageItem({
    super.key,
    this.img,
    required this.onTap,
    required this.title,
    this.lat,
    this.lng,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            Text(title.tr, style: subTitleTextStyle),
            SizedBox(
              height: 62,
              width: 153,
              child: Image.network(
                      img ?? '',
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

            ),
          ],
        ),
      ),
    );
  }
}
