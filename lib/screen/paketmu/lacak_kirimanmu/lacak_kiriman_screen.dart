import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/barcode_scan_screen.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_controller.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_detail.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/phone_number_confirmation_screen.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LacakKirimanScreen extends StatelessWidget {
  const LacakKirimanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LacakKirimanController>(
      init: LacakKirimanController(),
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(title: 'Lacak Kiriman'.tr),
          body: _bodyContent(controller, context),
        );
      },
    );
  }

  Widget _bodyContent(LacakKirimanController c, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Masukan Nomor Resimu'.tr,
            isMultiple: true,
            suffixIcon: GestureDetector(
              onTap: () => Get.to(() => const BarcodeScanScreen(), arguments: {})?.then((result) {
                c.searchField.text = result;
                c.update();
                if (c.isLogin) {
                  c.searchCnotes(result);
                } else {
                  Get.to(
                    () => PhoneNumberConfirmationScreen(
                      awb: result,
                      // cekResi: c.cekResi,
                      isLoading: c.isLoading,
                    ),
                  )?.then(
                    (phoneNumber) {
                      c.phoneNumber = phoneNumber;
                      c.searchCnotes(result ?? '');
                    },
                  );
                }
              }),
              child: Icon(
                Icons.qr_code_rounded,
                color: AppConst.isLightTheme(context) ? whiteColor : whiteColor,
                size: 25,
              ),
            ),
            onSubmit: (value) {
              if (value.isEmpty) {
                Get.showSnackbar(
                  GetSnackBar(
                    icon: const Icon(
                      Icons.warning,
                      color: whiteColor,
                    ),
                    message: 'Nomor resi tidak boleh kosong'.tr,
                    isDismissible: true,
                    duration: const Duration(seconds: 3),
                    backgroundColor: errorColor,
                  ),
                );
                // } else if (value.length > 16) {
                //   Get.showSnackbar(
                //     GetSnackBar(
                //       icon: const Icon(
                //         Icons.warning,
                //         color: whiteColor,
                //       ),
                //       message: 'Nomor resi maksimal 16 karakter'.tr,
                //       isDismissible: true,
                //       duration: const Duration(seconds: 3),
                //       backgroundColor: errorColor,
                //     ),
                //   );
              } else {
                if (c.isLogin) {
                  // c.cekResi(value, '');
                  c.searchCnotes(value);
                } else {
                  Get.to(
                    () => PhoneNumberConfirmationScreen(
                      awb: value,
                      isLoading: c.isLoading,
                    ),
                  )?.then(
                    (phoneNumber) {
                      c.phoneNumber = phoneNumber;
                      c.searchCnotes(value);
                    },
                  );
                }
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: c.cnotes.length + 1,
              itemBuilder: (context, index) {
                if (index < c.cnotes.length) {
                  var e = c.cnotes[index];
                  return ListTile(
                    title: Text(e?.cnote?.cnoteNo ?? ''),
                    trailing: Text(
                      e?.cnote?.podStatus ?? '',
                      style: sublistTitleTextStyle.copyWith(
                        color: e?.cnote?.podStatus == "NOT FOUND" ? errorColor : successColor,
                      ),
                    ),
                    contentPadding: EdgeInsets.zero,
                    onTap: () => e?.cnote?.podStatus == "NOT FOUND"
                        ? null
                        : Get.to(LacakKirimanDetail(
                            data: e ?? PostLacakKirimanModel(),
                            isLogin: c.isLogin,
                          )),
                  );
                } else {
                  return Shimmer(
                    isLoading: true,
                    child: ListTile(tileColor: c.isLoading ? greyLightColor2 : Colors.transparent),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
