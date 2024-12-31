import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/items/show_image_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PromoItem extends StatelessWidget {
  final NewsModel? news;
  final BannerModel? promo;
  final String lang;
  final bool isLoading;

  const PromoItem({
    super.key,
    this.news,
    required this.lang,
    this.promo,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchUrl(),
      child: Shimmer(
        isLoading: isLoading,
        child: Container(
          decoration: BoxDecoration(
            color: isLoading ? greyColor : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.all(10),
          width: Get.width / 2.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              children: [
                GestureDetector(
                  onTap: () => _showImagePreview(
                    context,
                    news?.thumbnail ?? promo?.picture ?? '',
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.contain,
                    imageUrl: news?.thumbnail ?? promo?.picture ?? '',
                    width: Get.width / 2,
                    height: promo != null ? Get.width / 2 : null,
                    placeholder: (context, url) => Center(
                      child: Shimmer(
                        isLoading: true,
                        child: Container(
                          height: Get.width / 2,
                          width: Get.width / 2,
                          color: greyColor,
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: redJNE,
                        size: 50,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    color:
                        Colors.black.withOpacity(0.6), // Background transparan
                    child: Text(
                      lang == "id"
                          ? news?.detail
                                  ?.where((e) => e.lang == "id")
                                  .first
                                  .title ??
                              promo?.namaBanner ??
                              ''
                          : news?.detail
                                  ?.where((e) => e.lang == "en")
                                  .first
                                  .title ??
                              promo?.namaBanner ??
                              '',
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    final url = lang == "id"
        ? news?.detail?.where((e) => e.lang == "id").first.externalLink ?? ''
        : news?.detail?.where((e) => e.lang == "en").first.externalLink ?? '';

    if (url.isNotEmpty) {
      try {
        if (await canLaunchUrl(Uri.parse(url))) {
          await launchUrl(Uri.parse(url));
        } else {
          AppSnackBar.error('Failed to launch news link');
        }
      } catch (e) {
        AppSnackBar.error('Failed to launch news link');
      }
    }
  }

  void _showImagePreview(BuildContext context, String imageUrl) {
    if (imageUrl.isNotEmpty) {
      showImagePreview(context, imageUrl);
    } else {
      AppSnackBar.error('Image not available');
    }
  }
}
