import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/dialog/image_popup_dialog.dart';
import 'package:css_mobile/widgets/items/document_image_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class KirimanStepper extends StatelessWidget {
  final HistoryKiriman? history;
  final Cnote? cnote;
  final int currentStep;
  final int? length;
  final bool isLogin;
  final bool isLoading;

  const KirimanStepper({
    super.key,
    required this.currentStep,
    this.history,
    this.length,
    this.cnote,
    this.isLogin = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 8, right: 5),
              height: 26,
              width: 26,
              // decoration: BoxDecoration(
              //   color: blueJNE,
              // ),
              child: SvgPicture.asset(
                IconsConstant.box,
                // height: 100,
                color: currentStep == 0 ? (AppConst.isLightTheme(context) ? blueJNE : redJNE) : null,
              ),
            ),
            Container(
              height: ((currentStep == 0 && cnote?.photo != null)) && isLogin ? 110 : 60,
              margin: const EdgeInsets.only(left: 21),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    color: (currentStep + 1) != length ? greyDarkColor1 : Colors.transparent,
                  ),
                ),
              ),
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history?.date ?? '',
              style: sublistTitleTextStyle.copyWith(color: redJNE),
            ),
            SizedBox(
              width: Get.width / 1.5,
              child: Text(
                history?.desc ?? '',
                style: sublistTitleTextStyle.copyWith(
                  color: redJNE,
                  fontWeight: bold,
                ),
              ),
            ),
            ((cnote?.photo != null || cnote?.signature != null || cnote?.lat != null) && (currentStep == 0)) && isLogin
                ? GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        enableDrag: true,
                        isDismissible: true,
                        // isScrollControlled: true,
                        StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                          return Column(
                            children: [
                              DocumentImageItem(
                                title: 'Foto Pengiriman'.tr,
                                img: cnote?.photo ?? '',
                                isLoading: isLoading,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => ImagePopupDialog(
                                    title: 'Foto Pengiriman'.tr,
                                    img: cnote?.photo ?? '',
                                  ),
                                ),
                              ),
                              DocumentImageItem(
                                title: 'Tanda Tangan'.tr,
                                img: cnote?.signature ?? '',
                                isLoading: isLoading,
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => ImagePopupDialog(
                                    title: 'Tanda Tangan'.tr,
                                    img: cnote?.signature ?? '',
                                  ),
                                ),
                              ),
                              DocumentImageItem(
                                title: 'Lokasi Penerima'.tr,
                                lat: cnote?.lat?.toDouble(),
                                lng: cnote?.long?.toDouble(),
                                isLoading: isLoading || (cnote?.lat?.isEmpty ?? false),
                                onTap: () => showDialog(
                                  context: context,
                                  builder: (context) => ImagePopupDialog(
                                    title: 'Lokasi Penerima'.tr,
                                    // img: cnote?.signature ?? '',
                                    lat: cnote?.lat?.toDouble(),
                                    lng: cnote?.long?.toDouble(),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        backgroundColor: AppConst.isLightTheme(context) ? Colors.white : Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(color: AppConst.isLightTheme(context) ? Colors.transparent : whiteColor)),
                      );
                    },
                    child: Container(
                      width: 75,
                      height: 60,
                      margin: const EdgeInsets.only(top: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: greyColor),
                      ),
                      child: Image.network(
                        cnote?.photo ?? '',
                        fit: BoxFit.fill,
                      ),
                      // child: Image.asset(
                      //   ImageConstant.pantauPaketmuIcon,
                      //   height: 50,
                      // ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ],
    );
  }
}
