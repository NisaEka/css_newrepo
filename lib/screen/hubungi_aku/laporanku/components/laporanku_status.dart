import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatusLaporanku extends StatelessWidget {
  const StatusLaporanku({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
      init: LaporankuController(),
      builder: (c) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: iconColor(context),
              width: 0.5,
            ),
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(8),
              right: Radius.circular(8),
            ),
          ),
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _statusCard(
                context: context,
                controller: c,
                label: 'Semua'.tr,
                count: c.state.total,
                selected: c.state.selectedStatus == 0,
                onTap: () {
                  c.state.status = '';
                  c.state.selectedStatus = 0;
                  c.update();
                  c.state.pagingController.refresh();
                },
                isFirst: true,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'Belum Diproses'.tr,
                count: c.state.waiting,
                selected: c.state.selectedStatus == 3,
                onTap: () {
                  c.state.selectedStatus = 3;
                  c.state.status = 'On Process';
                  c.update();
                  c.state.pagingController.refresh();
                },
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'Masih Diproses'.tr,
                count: c.state.onProcess,
                selected: c.state.selectedStatus == 1,
                onTap: () {
                  c.state.selectedStatus = 1;
                  c.state.status = 'Reply CS';
                  c.update();
                  c.state.pagingController.refresh();
                },
                isFirst: false,
                isLast: false,
              ),
              _statusCard(
                context: context,
                controller: c,
                label: 'Selesai'.tr,
                count: c.state.closed,
                selected: c.state.selectedStatus == 2,
                onTap: () {
                  c.state.selectedStatus = 2;
                  c.state.status = 'Closed';
                  c.update();
                  c.state.pagingController.refresh();
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
    required LaporankuController controller,
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
          height: 70,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
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
                style: listTitleTextStyle.copyWith(
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
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: sublistTitleTextStyle.copyWith(
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
