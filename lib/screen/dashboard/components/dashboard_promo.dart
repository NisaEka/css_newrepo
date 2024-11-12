import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/news_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPromo extends StatelessWidget {
  const DashboardPromo({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (c) {
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Promo Terkini'.tr,
                        style: Theme.of(context).textTheme.titleLarge),
                    // const DateDropdownFilterButton(),
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: c.state.bannerList
                        .map(
                          (e) => NewsItem(
                            promo: e,
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
