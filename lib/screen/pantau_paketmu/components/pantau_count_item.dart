import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/dashboard/count_card_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_screen.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauCountItem extends StatelessWidget {
  final CountCardModel data;
  final bool isLoading;
  final String type;

  const PantauCountItem({
    super.key,
    required this.data,
    this.isLoading = false,
    this.type = 'COD',
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () => Get.to(const PantauPaketmuScreen()),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.all(10),
            child: Container(
              // padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: greyColor),
                  color: whiteColor),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.network(
                          data.img ?? '',
                          height: 25,
                        ),
                        const SizedBox(height: 28),
                        Text(data.title.toString(),
                            style: Theme.of(context).textTheme.titleMedium),
                        const SizedBox(height: 18),
                        Text(data.count.toString().tr,
                            style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                  ),
                  CustomLabelText(
                    title: 'COD',
                    value: data.cod.toString(),
                    isHorizontal: true,
                    isHasSpace: true,
                    fontColor: whiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: successColor.withOpacity(0.6),
                  ),
                  CustomLabelText(
                    title: 'NON COD',
                    value: data.nonCod.toString(),
                    isHorizontal: true,
                    isHasSpace: true,
                    fontColor: whiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: warningColor.withOpacity(0.8),
                  ),
                  CustomLabelText(
                    title: 'COD ONGKIR',
                    value: data.codOngkir.toString(),
                    isHorizontal: true,
                    isHasSpace: true,
                    fontColor: whiteColor,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    color: infoColor.withOpacity(0.6),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
