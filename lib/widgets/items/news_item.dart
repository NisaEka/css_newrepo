import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsItem extends StatelessWidget {
  final NewsModel? news;
  final BannerModel? promo;
  final String lang;
  final bool isLoading;

  const NewsItem({
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
          margin: const EdgeInsets.all(10),
          width: Get.width / 2,
          color: isLoading ? greyColor : Colors.transparent,
          // height: promo != null ? Get.width / 2 : null,
          child: Column(
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
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.broken_image,
                      color: redJNE,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Text(
                lang == "id"
                    ? news?.detail?.where((e) => e.lang == "id").first.title ??
                        promo?.namaBanner ??
                        ''
                    : news?.detail?.where((e) => e.lang == "en").first.title ??
                        promo?.namaBanner ??
                        '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl() async {
    if (await launchUrl(Uri.parse(lang == "id"
        ? news?.detail?.where((e) => e.lang == "id").first.externalLink ?? ''
        : news?.detail?.where((e) => e.lang == "en").first.externalLink ??
            ''))) {
      throw Exception(
          'Could not launch ${lang == "id" ? news?.detail?.where((e) => e.lang == "id").first.externalLink : news?.detail?.where((e) => e.lang == "en").first.externalLink}');
    }
  }

  void _showImagePreview(BuildContext context, String imageUrl) {
    if (imageUrl.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.close, color: whiteColor),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            body: Center(
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(imageUrl),
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3.0,
                initialScale: PhotoViewComputedScale.contained,
              ),
            ),
          ),
        ),
      );
    }
  }
}
