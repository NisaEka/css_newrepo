import 'package:cached_network_image/cached_network_image.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_banner_model.dart';
import 'package:css_mobile/data/model/dashboard/dashboard_news_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/util/snackbar.dart';
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
        child: Card(
          elevation: 5,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: greyLightColor1,
          child: Container(
            decoration: BoxDecoration(
                color: isLoading ? greyColor : Colors.transparent,
                borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.all(10),
            width: Get.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: CachedNetworkImage(
                    imageUrl: news?.thumbnail ?? promo?.picture ?? '',
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: Shimmer(
                        isLoading: true,
                        child: Container(
                          height: 150,
                          width: double.infinity,
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
                const SizedBox(height: 10),
                Text(
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
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: greyDarkColor1),
                ),
                Text(
                  news?.date?.toString().toLongDateFormat() ?? '',
                  textAlign: TextAlign.left,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: greyColor),
                )
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

    try {
      await launchUrl(Uri.parse(url));
    } catch (e) {
      AppSnackBar.error('Failed to launch news link');
      throw Exception('Could not launch $url');
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {}
  }
}
