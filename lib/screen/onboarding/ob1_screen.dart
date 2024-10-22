import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Ob1Screen extends StatefulWidget {
  const Ob1Screen({super.key});

  @override
  State<Ob1Screen> createState() => _Ob1ScreenState();
}

class _Ob1ScreenState extends State<Ob1Screen> {
  CarouselSliderController sliderController = CarouselSliderController();
  int currentIndex = 0;

  List<Map<String, String>> bannerTexts = [
    {
      "title": "Permintaan Pickup",
      "desc": "Kamu dapat melakukan permintaan pickup dan akan kami jemput ke tempat kamu.",
    },
    {
      "title": "Pencairan COD Cepat dan Detail",
      "desc":
          "Kamu dapat memilih skema pencairan otomatis ke rekening setiap hari atau withdraw dengan penarikan dana suka-suka kapanpun dan dimanapun.",
    },
    {
      "title": "Pantau Progres Pengiriman Realtime",
      "desc": "Kapanpun kamu dapat melihat semua status kiriman kamu secara realtime.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 80),
            CarouselSlider(
              carouselController: sliderController,
              items: [
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerRight,
                      child: Image.asset(
                        ImageConstant.sliceU,
                        height: Get.height / 2,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImageConstant.slice1,
                        height: Get.height / 2.5,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      alignment: Alignment.center,
                      child: Image.asset(
                        ImageConstant.sliceU,
                        height: Get.height / 2,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        ImageConstant.slice2,
                        height: Get.height / 2.5,
                        fit: BoxFit.cover,
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    Container(
                      width: Get.width,
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        ImageConstant.sliceU,
                        height: Get.height / 2,
                        fit: BoxFit.cover,
                        alignment: Alignment.centerRight,
                      ),
                    ),
                    Container(
                      width: Get.width,
                      alignment: Alignment.topLeft,
                      child: Image.asset(
                        ImageConstant.slice3,
                        height: Get.height / 2.5,
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                  ],
                ),
              ],
              options: CarouselOptions(
                autoPlay: false,
                viewportFraction: 1,
                enableInfiniteScroll: false,
                height: Get.height / 2,
                // initialPage: 2
                // pauseAutoPlayOnTouch: true,
                onPageChanged: (index, reason) => setState(() {
                  currentIndex = index;
                }),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text(
                    bannerTexts[currentIndex]['title'].toString().tr,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    bannerTexts[currentIndex]['desc'].toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: index == currentIndex ? warningColor : greyColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          CustomFilledButton(
            color: redJNE,
            margin: const EdgeInsets.only(right: 50, left: 50, bottom: 20),
            height: 51,
            title: 'Selanjutnya'.tr,
            // onPressed: () => Get.to(
            //   const Ob2Screen(),
            //   transition: Transition.rightToLeftWithFade,
            // ),
            onPressed: () => currentIndex != 2
                ? sliderController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  )
                : Get.delete<DashboardController>().then((_) => Get.offAll(const DashboardScreen())),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
