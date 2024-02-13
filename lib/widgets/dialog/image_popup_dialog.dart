import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImagePopupDialog extends StatelessWidget {
  final String title;
  final String img;

  const ImagePopupDialog({
    super.key,
    required this.title,
    required this.img,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(5),
      backgroundColor: whiteColor,
      title: Text(title.tr),
      content: Image.network(
        img,
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
              value:
                  loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
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
