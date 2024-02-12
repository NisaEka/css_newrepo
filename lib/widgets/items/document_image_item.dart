import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class DocumentImageItem extends StatelessWidget {
  final String img;

  const DocumentImageItem({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      width: 153,
      child: Image.network(
        img,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 62,
          width: 153,
          decoration: BoxDecoration(
            color: greyLightColor3,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
            ),
          );
        },
      ),
    );
  }
}
