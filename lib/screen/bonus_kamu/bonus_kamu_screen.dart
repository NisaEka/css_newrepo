import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/bonus_kamu/bonus_kamu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/jlcpoint/jlcpoint_box.dart';
import 'package:css_mobile/widgets/jlcpoint/point_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class BonusKamuScreen extends StatelessWidget {
  final String url = 'https://jlc.jne.co.id';

  const BonusKamuScreen({super.key});

  Future<void> _launchURL() async {
    await launchUrl(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BonusKamuController>(
        init: BonusKamuController(),
        builder: (controller) {
          return Scaffold(
            appBar: CustomTopBar(
              title: 'Bonus Kamu'.tr,
            ),
            body: _bodyContent(controller, context),
          );
        });
  }

  Widget _bodyContent(BonusKamuController c, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 100,
          child: Stack(
            children: [
              JlcPointBox(
                totalTransaksi: c.totalTransaksi ?? '0',
                jlcPoint: c.jlcPoint ?? '0',
              ),
              Positioned(
                bottom: 0,
                right: 25,
                child: CustomFilledButton(
                  color: primaryColor(context),
                  title: "Tukarkan Poinmu".tr.toUpperCase(),
                  width: 128,
                  height: 24,
                  radius: 20,
                  padding: EdgeInsets.zero,
                  fontColor: whiteColor,
                  fontSize: 9,
                  boxShadow: [
                    BoxShadow(
                      color: secondaryColor(context),
                      spreadRadius: 0.3,
                      offset: const Offset(2, 2),
                    ),
                  ],
                  onPressed: () => _launchURL(),
                ),
              )
            ],
          ),
        ),
        Row(
          children: [
            CustomFilledButton(
              color: c.tabIndex == 0
                  ? primaryColor(context)
                  : primaryColor(context).withOpacity(0.5),
              title: "Total Transaksi".tr,
              radius: 0,
              width: Get.width / 2,
              fontStyle: subTitleTextStyle.copyWith(color: whiteColor),
              boxShadow: [
                BoxShadow(
                  color: c.tabIndex == 0
                      ? secondaryColor(context)
                      : primaryColor(context).withOpacity(0.8),
                  spreadRadius: 2,
                  offset: const Offset(-2, 2),
                )
              ],
              onPressed: () {
                c.tabIndex = 0;
                c.update();
              },
            ),
            CustomFilledButton(
              color: c.tabIndex == 1
                  ? primaryColor(context)
                  : primaryColor(context).withOpacity(0.5),
              title: "Penukaran Poin Terakhir".tr,
              radius: 0,
              width: Get.width / 2,
              fontStyle: subTitleTextStyle.copyWith(color: whiteColor),
              boxShadow: [
                BoxShadow(
                  color: c.tabIndex == 1
                      ? secondaryColor(context)
                      : primaryColor(context).withOpacity(0.8),
                  spreadRadius: 2,
                  offset: const Offset(2, 2),
                )
              ],
              onPressed: () {
                c.tabIndex = 1;
                c.update();
              },
            ),
          ],
        ),
        Expanded(
          child: Center(
            child: c.tabIndex == 0
                ? ListView(
                    shrinkWrap: c.totalTransaksiList.isEmpty || c.isLoading,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    children: c.isLoading
                        ? List.generate(
                            5,
                            (index) => const PointListItem(isLoading: true),
                          )
                        : c.totalTransaksiList.isNotEmpty
                            ? c.totalTransaksiList
                                .map(
                                  (e) => PointListItem(
                                    dateTime: e.tglTransaksi
                                            ?.toDate(
                                                originFormat:
                                                    'yyyy-MM-dd HH:mmzzz')
                                            .toString()
                                            .toLongDateTimeFormat() ??
                                        '',
                                    point: e.point == '0'
                                        ? 0
                                        : e.point?.toDouble(),
                                    title: 'Resi'.tr,
                                    subtitle: e.noConnote ?? '',
                                    status:
                                        e.status == "N" ? "Valid" : "Cancel",
                                    amount: e.jmlTransaksi,
                                  ),
                                )
                                .toList()
                            : [
                                DataEmpty(
                                    text:
                                        'Belum ada riwayat transaksi point'.tr)
                              ],
                  )
                : ListView(
                    shrinkWrap: c.reedemPointList.isEmpty,
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    children: c.isLoading
                        ? List.generate(
                            5,
                            (index) => const PointListItem(isLoading: true),
                          )
                        : c.reedemPointList.isNotEmpty
                            ? c.reedemPointList
                                .map(
                                  (e) => PointListItem(
                                    dateTime: e.tglPenukaran ?? '',
                                    point: e.penukaranPoint?.toDouble() ?? 0,
                                    title: 'Nomor'.tr,
                                    subtitle: e.noPenukaran ?? '',
                                    rewards: e.jmlHadiah ?? '0',
                                  ),
                                )
                                .toList()
                            : [
                                DataEmpty(
                                    text:
                                        "Belum ada riwayat penukaran point".tr)
                              ],
                  ),
          ),
        ),
      ],
    );
  }
}
