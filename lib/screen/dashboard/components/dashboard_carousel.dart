import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class DashboardCarousel extends StatelessWidget {
  int? bannerIndex;
  final EdgeInsets? padding;

  DashboardCarousel({
    super.key,
    this.bannerIndex,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
        init: DashboardController(),
        builder: (controller) {
          return Container(
            margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: !controller.state.isLogin
                    ? 100
                    : !controller.state.isCcrf
                        ? 180
                        : 150),
            height: 200,
            width: Get.size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.8),
              // borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider(
              items: controller.state.bannerList
                  .map(
                    (e) => Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CachedNetworkImage(
                        fit: BoxFit.fitWidth,
                        // height: 200,
                        // width: Get.width,
                        alignment: Alignment.topCenter,
                        imageUrl: e.picture ?? '',
                        errorWidget: (context, url, error) => Container(),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: 190,
                // pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) => bannerIndex,
              ),
              disableGesture: true,
              carouselController: CarouselSliderController(),
            ),
          );
        });
  }
}
