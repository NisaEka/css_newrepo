import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImagePreviewScreen extends StatelessWidget {
  final File image;

  const ImagePreviewScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: Center(
        child: PhotoViewGallery.builder(
          itemCount: 1,
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider:
                  FileImage(image), // Use the FileImage for local image
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 3.0,
              initialScale: PhotoViewComputedScale.contained,
            );
          },
          scrollPhysics: const BouncingScrollPhysics(),
          backgroundDecoration: const BoxDecoration(color: Colors.black),
          pageController: PageController(),
        ),
      ),
    );
  }
}
