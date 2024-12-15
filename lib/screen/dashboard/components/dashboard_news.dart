import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/news_item.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Jnews'.tr,
                        style: Theme.of(context).textTheme.titleLarge),
                    // const DateDropdownFilterButton(),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(height: 10),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: c.state.newsList
                        .map(
                          (e) => NewsItem(
                            news: e,
                            lang: c.state.local,
                            isLoading: c.state.isLoading,
                          ),
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
