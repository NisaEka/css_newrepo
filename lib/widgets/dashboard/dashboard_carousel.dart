import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardCarousel extends StatelessWidget {
  final List<Widget> bannerList;
  var bannerIndex;

  DashboardCarousel({
    super.key,
    required this.bannerList,
    this.bannerIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15, top: 150),
      height: 100,
      width: Get.size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: greyColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
      ),
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
