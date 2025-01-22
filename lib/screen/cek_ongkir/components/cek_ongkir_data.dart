import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/cek_ongkir/congkir_controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/ongkir_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/const/app_const.dart';

class CekOngkirData extends StatelessWidget {
  const CekOngkirData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CekOngkirController>(
        init: CekOngkirController(),
        builder: (c) {
          return Column(
            children: [
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Berat Express'.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        c.state.weightExpress.tr,
                        style: sublistTitleTextStyle.copyWith(
                          fontWeight: bold,
                          color: AppConst.isLightTheme(context)
                              ? greyColor
                              : whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: Text(
                      'Berat JTR'.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  Flexible(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        c.state.weightJtr.tr,
                        style: sublistTitleTextStyle.copyWith(
                          fontWeight: bold,
                          color: AppConst.isLightTheme(context)
                              ? greyColor
                              : whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFormLabel(label: 'Layanan'.tr),
                  CustomFormLabel(label: 'Biaya & Durasi'.tr),
                ],
              ),
              const Divider(),
              Column(
                children: c.state.ongkirList
                    .map(
                      (e) => OngkirListItem(
                        serviceTitle: e.serviceDisplay.toString(),
                        serviceSubtitle: e.goodsType.toString(),
                        servicePrice: (e.insuranceAmount ?? 0)
                            .toInt()
                            .toCurrency()
                            .toString(),
                        serviceDuration:
                            '${e.etdFrom ?? ''} - ${e.etdThru ?? ''} ${e.times ?? ''}',
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        });
  }
}
