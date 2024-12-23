import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PantauItems extends StatelessWidget {
  final PantauPaketmuCountModel? item;
  final bool isLoading;
  final int? index;

  const PantauItems({
    super.key,
    this.item,
    this.isLoading = true,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
      init: PantauPaketmuController(),
      builder: (c) {
        Widget getStatusIcon(String status) {
          switch (status) {
            case 'Sudah Dijemput':
              return SvgPicture.asset(
                IconsConstant.requestPickup,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Sudah Di Gudang JNE':
              return SvgPicture.asset(
                IconsConstant.building,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Sudah Di Kota Tujuan':
              return SvgPicture.asset(
                IconsConstant.location,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Dalam Proses':
              return SvgPicture.asset(
                IconsConstant.sync,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Sukses Diterima':
              return SvgPicture.asset(
                IconsConstant.docSuccess,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Butuh Dicek':
              return SvgPicture.asset(
                IconsConstant.location,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Proses Pengembalian Ke Kamu':
              return SvgPicture.asset(
                IconsConstant.location,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Sukses Dikembalikan Ke Kamu':
              return SvgPicture.asset(
                IconsConstant.retur,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Dalam Peninjauan':
              return SvgPicture.asset(
                IconsConstant.building,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            case 'Dibatalkan Oleh Kamu':
              return SvgPicture.asset(
                IconsConstant.error,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
            default:
              return SvgPicture.asset(
                IconsConstant.error,
                color: AppConst.isLightTheme(context)
                    ? greyLightColor1
                    : greyDarkColor1,
                height: 100,
              );
          }
        }

        return InkWell(
          onTap: () {
            if (item != null && !isLoading) {
              AppLogger.i('Card tapped.');
              c.setSelectedStatus(index ?? 0);
              Get.to(() => const PantauPaketmuScreen());
            }
          },
          child: Shimmer(
            isLoading: isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            color: isLoading ? greyColor : Colors.transparent,
                          ),
                          child: Text(
                            item?.status ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          color: isLoading ? greyColor : Colors.transparent,
                          child: Text(
                            c.state.selectedKiriman == 0
                                ? item?.totalCod.toString() ?? ''
                                : c.state.selectedKiriman == 1
                                    ? item?.totalCodOngkir.toString() ?? ''
                                    : item?.totalNonCod.toString() ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        // COD
                        c.state.selectedKiriman == 0 ||
                                c.state.selectedKiriman == 1
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                color:
                                    isLoading ? greyColor : Colors.transparent,
                                width: 230,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: Text(
                                              'COD',
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              children: [
                                                const SizedBox(width: 4),
                                                const Text(
                                                  // c.state.selectedKiriman == 0
                                                  //     ? "COD"
                                                  //     : c.state.selectedKiriman == 1
                                                  //     ? "COD ONGKIR"
                                                  //     : '',
                                                  'COD',
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                                const SizedBox(width: 14),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                  ),
                                                  width: 105,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                    child: Text(
                                                      c.state.selectedKiriman ==
                                                              0
                                                          ? 'Rp. ${item?.codAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.codAmount.toString())) : '0'}'
                                                          : c.state.selectedKiriman ==
                                                                  1
                                                              ? 'Rp. ${item?.codOngkirAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.codOngkirAmount.toString())) : '0'}'
                                                              : "Rp. 0",
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                              fontSize: 10,
                                                              color:
                                                                  greyDarkColor1),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    c.state.selectedKiriman == 0
                                                        ? '${item?.codAmountPercentage}%'
                                                        : c.state.selectedKiriman ==
                                                                1
                                                            ? '${item?.codOngkirAmountPercentage}%'
                                                            : "0%",
                                                    style: const TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                        // Ongkir
                        // ignore: unrelated_type_equality_checks
                        c.state.selectedStatusKiriman == 0 ||
                                c.state.selectedKiriman == 2
                            ? Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                color:
                                    isLoading ? greyColor : Colors.transparent,
                                width: 230,
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            'Ongkir',
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(width: 8),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text(
                                                  'Ongkir',
                                                  style: TextStyle(
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: whiteColor,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(5),
                                                      bottomRight:
                                                          Radius.circular(5),
                                                    ),
                                                  ),
                                                  width: 105,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 3),
                                                    child: Text(
                                                      c.state.selectedKiriman ==
                                                              0
                                                          ? 'Rp. ${item?.ongkirCodAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.ongkirCodAmount.toString())) : '0'}'
                                                          : c.state.selectedKiriman ==
                                                                  1
                                                              ? 'Rp. 0'
                                                              : 'Rp. ${item?.ongkirNonCodAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.ongkirNonCodAmount.toString())) : '0'}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .labelMedium
                                                          ?.copyWith(
                                                              fontSize: 10,
                                                              color:
                                                                  greyDarkColor1),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                SizedBox(
                                                  width: 40,
                                                  child: Text(
                                                    c.state.selectedKiriman == 0
                                                        ? '${item?.ongkirCodAmountPercentage}%'
                                                        : c.state.selectedKiriman ==
                                                                1
                                                            ? '0%'
                                                            : '${item?.ongkirNonCodAmountPercentage}%',
                                                    style: const TextStyle(
                                                        color: whiteColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        getStatusIcon(item?.status ?? ''),
                        // Icon(getStatusIcon(item?.status ?? ''),
                        //     color: greyLightColor2, size: 100),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Divider(
                  color: Theme.of(context).colorScheme.outline,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
