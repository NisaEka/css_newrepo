import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/news_item.dart';
import 'package:css_mobile/widgets/items/title_text_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardNews extends StatelessWidget {
  const DashboardNews({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                c.state.newsList.isNotEmpty && c.state.newsList.first.thumbnail != null ? TitleTextItem(title: 'Jnews'.tr) : const SizedBox(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: c.state.isLoading || c.state.newsList.isEmpty
                        ? List.generate(3, (index) => const NewsItem(isLoading: true, lang: ''))
                        : c.state.newsList
                            .map(
                              (e) => e.thumbnail != null
                                  ? NewsItem(
                                      news: e,
                                      lang: c.state.local,
                                      isLoading: c.state.isLoading,
                                    )
                                  : const SizedBox(),
                            )
                            .toList(),
                  ),
                )
              ],
            ),
          );
        });
  }
}
