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
  final CarouselSliderController sliderController = CarouselSliderController();
  int currentIndex = 0;

  final List<Map<String, String>> bannerTexts = [
    {
      "title": "Permintaan Pickup",
      "desc":
          "Kamu dapat melakukan permintaan pickup dan akan kami jemput ke tempat kamu.",
    },
    {
      "title": "Pencairan COD Cepat dan Detail",
      "desc":
          "Kamu dapat memilih skema pencairan otomatis ke rekening setiap hari atau withdraw dengan penarikan dana suka-suka kapanpun dan dimanapun.",
    },
    {
      "title": "Pantau Progres Pengiriman Realtime",
      "desc":
          "Kapanpun kamu dapat melihat semua status kiriman kamu secara realtime.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 80),
          CarouselSlider(
            carouselController: sliderController,
            items: [
              _buildCarouselItem(ImageConstant.slice1, Alignment.centerLeft),
              _buildCarouselItem(ImageConstant.slice2, Alignment.bottomCenter),
              _buildCarouselItem(ImageConstant.slice3, Alignment.topCenter),
            ],
            options: CarouselOptions(
              autoPlay: false,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              height: Get.height / 2,
              onPageChanged: (index, reason) => setState(() {
                currentIndex = index;
              }),
            ),
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Text(
                  bannerTexts[currentIndex]['title']!.tr,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 15),
                Text(
                  bannerTexts[currentIndex]['desc']!,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(),
          const SizedBox(height: 20),
          CustomFilledButton(
            color: redJNE,
            margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            height: 51,
            title: 'Selanjutnya'.tr,
            onPressed: () => currentIndex != 2
                ? sliderController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                  )
                : Get.delete<DashboardController>()
                    .then((_) => Get.offAll(const DashboardScreen())),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  /// Helper method to build carousel items.
  Widget _buildCarouselItem(String imagePath, Alignment alignment) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Image.asset(
            ImageConstant.sliceU,
            height: Get.height / 2,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: alignment,
          child: Image.asset(
            imagePath,
            height: Get.height / 2.5,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  /// Helper method to build the indicator dots.
  Widget _buildIndicator() {
    return Row(
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
    );
  }
}
