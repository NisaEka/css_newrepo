import 'package:flutter/material.dart';

class DocumentImageItem extends StatelessWidget {
  final String img;

  const DocumentImageItem({super.key, required this.img});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      img,
      height: 62,
      width: 153,
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
    );
  }
}
