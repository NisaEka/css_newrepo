import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/promo_item.dart';
import 'package:css_mobile/widgets/items/title_text_item.dart';
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
                c.state.promoList.isEmpty
                    ? const SizedBox()
                    : TitleTextItem(title: 'Promo Terkini'.tr),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: c.state.isLoading && c.state.promoList.isEmpty
                        ? List.generate(
                            3,
                            (index) =>
                                const PromoItem(isLoading: true, lang: ''))
                        : c.state.promoList
                            .map(
                              (e) => PromoItem(
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
