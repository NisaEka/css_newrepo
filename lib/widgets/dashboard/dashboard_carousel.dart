import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCarousel extends StatelessWidget {
  final List<Widget> bannerList;
  final int bannerIndex;

  const DashboardCarousel({
    super.key,
    required this.bannerList,
    required this.bannerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 150),
      height: 100,
      width: Get.width - 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: infoLightColor1.withOpacity(0.8)),
      child: CarouselSlider(
        items: bannerList,
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
    );
  }
}
