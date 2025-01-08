import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PantauStatusButton extends StatelessWidget {
  const PantauStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauCardController>(
      init: PantauCardController(),
      builder: (c) {
        return Container(
          decoration: BoxDecoration(
            color: primaryColor(context),
            border: Border.all(),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusCard(
                context: context,
                controller: c,
                label: 'COD'.tr,
                count: c.state.cod,
                selected: c.state.selectedTipeKiriman == 'cod',
                onTap: () {
                  if (c.state.selectedTipeKiriman != 'cod') {
                    c.state.selectedKiriman = 0;
                    c.state.transType = '';
                    c.state.selectedTipeKiriman = 'cod';
                    c.update();
                    // c.state.pagingController.refresh();
                  }
                },
                isFirst: true,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'COD ONGKIR'.tr,
                count: c.state.codOngkir,
                selected: c.state.selectedTipeKiriman == 'cod ongkir',
                onTap: () {
                  if (c.state.selectedTipeKiriman != 'cod ongkir') {
                    c.state.selectedKiriman = 1;
                    c.state.transType = 'cod ongkir';
                    c.state.selectedTipeKiriman = 'cod ongkir';
                    c.update();
                    // c.state.pagingController.refresh();
                  }
                },
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'NON COD'.tr,
                count: c.state.noncod,
                selected: c.state.selectedTipeKiriman == 'non cod',
                onTap: () {
                  if (c.state.selectedTipeKiriman != 'non cod') {
                    c.state.selectedKiriman = 2;
                    c.state.transType = 'NON COD';
                    c.state.selectedTipeKiriman = 'non cod';
                    c.update();
                    // c.state.pagingController.refresh();
                  }
                },
                isFirst: false,
                isLast: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _statusCard({
    required BuildContext context,
    required PantauCardController controller,
    required String label,
    required int count,
    required bool selected,
    required VoidCallback onTap,
    required bool isFirst,
    required bool isLast,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: iconColor(context),
              width: 0.5,
            ),
            color: selected
                ? primaryColor(context)
                : AppConst.isLightTheme(context)
                    ? whiteColor
                    : bgDarkColor,
            borderRadius: BorderRadius.horizontal(
              left: isFirst ? const Radius.circular(8) : Radius.zero,
              right: isLast ? const Radius.circular(8) : Radius.zero,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                count.toString(),
                style: sublistTitleTextStyle.copyWith(
                  fontWeight: bold,
                  color: selected
                      ? whiteColor
                      : AppConst.isLightTheme(context)
                          ? blueJNE
                          : whiteColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: sublistTitleTextStyle.copyWith(
                    fontSize: 10,
                    color: selected
                        ? whiteColor
                        : AppConst.isLightTheme(context)
                            ? greyColor
                            : whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
