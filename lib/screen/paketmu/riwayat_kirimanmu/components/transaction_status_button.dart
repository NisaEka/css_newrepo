import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionStatusButton extends StatelessWidget {
  const TransactionStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
      init: RiwayatKirimanController(),
      builder: (c) {
        return Container(
          margin: const EdgeInsets.only(bottom: 15),
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
                label: 'Kiriman'.tr,
                count: c.state.total,
                selected: c.state.selectedKiriman == 0,
                value: 'ALL',
                isFirst: true,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'COD'.tr,
                count: c.state.cod,
                selected: c.state.selectedKiriman == 1,
                value: 'COD',
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'NON COD'.tr,
                count: c.state.noncod,
                selected: c.state.selectedKiriman == 2,
                value: 'NON COD',
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'COD ONGKIR'.tr,
                count: c.state.codOngkir,
                selected: c.state.selectedKiriman == 3,
                value: 'COD ONGKIR',
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
    required RiwayatKirimanController controller,
    required String label,
    required int count,
    required bool selected,
    required bool isFirst,
    required bool isLast,
    String? value,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (value == 'COD ONGKIR') {
            controller.state.selectedKiriman = 3;
            controller.state.transType = 'COD ONGKIR';
          } else if (value == 'NON COD') {
            controller.state.selectedKiriman = 2;
            controller.state.transType = 'NON COD';
          } else if (value == 'COD') {
            controller.state.selectedKiriman = 1;
            controller.state.transType = 'COD';
          } else if (value == 'ALL') {
            controller.state.selectedKiriman = 0;
            controller.state.transType = '';
          }
          controller.update();
          controller.state.pagingController.refresh();
        },
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
                style: subTitleTextStyle.copyWith(
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
