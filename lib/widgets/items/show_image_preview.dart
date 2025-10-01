import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:cached_network_image/cached_network_image.dart';

void showImagePreview(BuildContext context, String imageUrl, {Color? background}) {
  if (imageUrl.isNotEmpty) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: background ?? Colors.black,
          appBar: AppBar(
            backgroundColor: background ?? Colors.black,
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
                  imageProvider: CachedNetworkImageProvider(imageUrl),
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered * 3.0,
                  initialScale: PhotoViewComputedScale.contained,
                );
              },
              scrollPhysics: const BouncingScrollPhysics(),
              backgroundDecoration: BoxDecoration(color: background ?? Colors.black),
              pageController: PageController(),
            ),
          ),
        ),
      ),
    );
  }
}
