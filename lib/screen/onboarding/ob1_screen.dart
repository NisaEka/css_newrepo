import 'package:carousel_slider/carousel_slider.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/storage_core.dart';
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
  String lang = 'id';

  final List<Map<String, String>> bannerTexts = [
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
  void initState() {
    super.initState();
    setState(() {
      Get.updateLocale(const Locale("id", "ID"));
      lang = "id";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 80),
              CarouselSlider(
                carouselController: sliderController,
                items: [
                  _buildCarouselItem(ImageConstant.slice1, Alignment.centerLeft, 1),
                  _buildCarouselItem(ImageConstant.slice2, Alignment.bottomCenter, 2),
                  _buildCarouselItem(ImageConstant.slice3, Alignment.centerRight, 3),
                ],
                options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1,
                  enableInfiniteScroll: false,
                  height: Get.height - 120,
                  onPageChanged: (index, reason) => setState(() {
                    currentIndex = index;
                  }),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomFilledButton(
              //   color: redJNE,
              //   margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
              //   height: 51,
              //   width: 20,
              //   isTransparent: true,
              //   title: 'Lewati'.tr,
              //   onPressed: () => Get.delete<DashboardController>().then((_) => Get.offAll(const DashboardScreen())),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: GestureDetector(
                  child: Text(
                    'Lewati'.tr,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(color: redJNE),
                  ),
                  onTap: () => Get.delete<DashboardController>().then((_) => Get.offAll(const DashboardScreen())),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomFilledButton(
                      color: lang == "id" ? redJNE : whiteColor,
                      fontColor: lang == "id" ? whiteColor : greyColor,
                      borderColor: lang == "id" ? Colors.transparent : greyColor,
                      title: 'ID',
                      width: 40,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      onPressed: () => changeLanguage("ID"),
                    ),
                    const SizedBox(width: 10),
                    CustomFilledButton(
                      color: lang == "en" ? redJNE : whiteColor,
                      fontColor: lang == "en" ? whiteColor : greyColor,
                      borderColor: lang == "en" ? Colors.transparent : greyColor,
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      title: 'EN',
                      width: 40,
                      onPressed: () => changeLanguage("EN"),
                    ),
                  ],
                ),
              ),
            ],
          ),

        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          CustomFilledButton(
            color: redJNE,
            margin: const EdgeInsets.symmetric(horizontal: 50),
            height: 51,
            title: 'Selanjutnya'.tr,
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

  void changeLanguage(String language) async {
    final storage = Get.find<StorageCore>();
    if (language == "ID") {
      await storage.writeString(StorageCore.localeApp, "id");
      setState(() {
        Get.updateLocale(const Locale("id", "ID"));
        lang = "id";
      });
    } else {
      await storage.writeString(StorageCore.localeApp, "en");
      setState(() {
        Get.updateLocale(const Locale("en", "US"));
        lang = "en";
      });
    }
  }

  /// Helper method to build carousel items.
  Widget _buildCarouselItem(String imagePath, Alignment alignment, int index) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: Get.height / 2,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  ImageConstant.sliceU,
                  height: Get.height / 2,
                  fit: BoxFit.cover,
                  alignment: alignment,
                ),
              ),
              Align(
                alignment: index == 2 ? Alignment.bottomCenter : Alignment.center,
                child: Image.asset(
                  imagePath,
                  height: Get.height / 2.5,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        _buildIndicator(),
        // const SizedBox(height: 40),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                bannerTexts[currentIndex]['title']!.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 15),
              Text(
                bannerTexts[currentIndex]['desc']!.tr,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        )
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
