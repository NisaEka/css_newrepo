import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading.dart';
import 'package:flutter/material.dart';

class StickerListItem extends StatelessWidget {
  final bool isSelected;
  final String img;
  final VoidCallback? onTap;

  const StickerListItem({
    super.key,
    this.isSelected = false,
    required this.img,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: isSelected ? Border.all(color: redJNE, width: 5) : null,
        ),
        child: CachedNetworkImage(
          imageUrl: img,
          height: 400,
          placeholder: (context, url) => Shimmer(
            child: ShimmerLoading(
              isLoading: true,
              child: Container(
                height: 400,
                width: 300,
                color: Colors.grey,
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.image_not_supported),
        ),
      ),
    );
  }
}
