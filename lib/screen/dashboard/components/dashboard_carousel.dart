import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
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
          return Shimmer(
            isLoading: controller.state.bannerList.isEmpty,
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                top: !controller.state.isLogin
                    ? 100
                    // : !controller.state.isCcrf
                    //     ? 180
                    : 150,
              ),
              height: 150,
              width: Get.size.width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: CarouselSlider(
                items: controller.state.bannerList
                    .map(
                      (e) => CachedNetworkImage(
                        imageBuilder: (context, imageProvider) => Container(
                          width: Get.width,
                          // height: 80.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        alignment: Alignment.topCenter,
                        imageUrl: e.img ?? '',
                        errorWidget: (context, url, error) => Container(),
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
            ),
          );
        });
  }
}
