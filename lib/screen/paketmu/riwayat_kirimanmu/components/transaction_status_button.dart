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
                onTap: () {
                  if (c.state.selectedKiriman != 0) {
                    c.state.selectedKiriman = 0;
                    c.state.transType = '';
                    c.update();
                    c.state.pagingController.refresh();
                  }
                },
                isFirst: true,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'COD'.tr,
                count: c.state.cod,
                selected: c.state.selectedKiriman == 1,
                onTap: () {
                  if (c.state.selectedKiriman != 1) {
                    c.state.selectedKiriman = 1;
                    c.state.transType = 'COD';
                    c.update();
                    c.state.pagingController.refresh();
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
                selected: c.state.selectedKiriman == 2,
                onTap: () {
                  if (c.state.selectedKiriman != 2) {
                    c.state.selectedKiriman = 2;
                    c.state.transType = 'NON COD';
                    c.update();
                    c.state.pagingController.refresh();
                  }
                },
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'COD ONGKIR'.tr,
                count: c.state.codOngkir,
                selected: c.state.selectedKiriman == 3,
                onTap: () {
                  if (c.state.selectedKiriman != 3) {
                    c.state.selectedKiriman = 3;
                    c.state.transType = 'COD ONGKIR';
                    c.update();
                    c.state.pagingController.refresh();
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
    required RiwayatKirimanController controller,
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
