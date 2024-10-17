import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              CachedNetworkImage(
                fit: BoxFit.contain,
                imageUrl: news?.thumbnail ?? promo?.picture ?? '',
                width: Get.width / 2,
                height: promo != null ? Get.width / 2 : null,
              ),
              Text(
                lang == "id"
                    ? news?.detail?.where((e) => e.lang == "id").first.title ?? promo?.namaBanner ?? ''
                    : news?.detail?.where((e) => e.lang == "en").first.title ?? promo?.namaBanner ?? '',
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
        : news?.detail?.where((e) => e.lang == "en").first.externalLink ?? ''))) {
      throw Exception(
          'Could not launch ${lang == "id" ? news?.detail?.where((e) => e.lang == "id").first.externalLink : news?.detail?.where((e) => e.lang == "en").first.externalLink}');
    }
  }
}
