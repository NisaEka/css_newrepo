import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//ignore: must_be_immutable
class DashboardCarousel extends StatelessWidget {
  var bannerIndex;
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
        return Padding(
          padding: padding ?? const EdgeInsets.only(top: 60),
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: controller.state.isLogin ? 85 : 50),
            height: 100,
            width: Get.size.width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider(
              items: controller.state.bannerList,
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: 100,
                // pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) => bannerIndex,
              ),
              disableGesture: true,
              carouselController: CarouselController(),
            ),
          ),
        );
      }
    );
  }
}
