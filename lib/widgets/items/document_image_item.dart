import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';

class DocumentImageItem extends StatelessWidget {
  final String img;
  final VoidCallback onTap;

  const DocumentImageItem({super.key, required this.img, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
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
            child: const Center(child: Icon(Icons.image_not_supported_outlined)),
          ),
          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value:
                    loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
              ),
            );
          },
        ),
      ),
    );
  }
}
