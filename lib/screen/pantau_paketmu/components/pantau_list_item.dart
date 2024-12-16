import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_count_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PantauItems extends StatelessWidget {
  final PantauPaketmuCountModel? item;
  final bool? isLoading;

  const PantauItems({super.key, this.item, this.isLoading});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
      init: PantauPaketmuController(),
      builder: (c) {
        return InkWell(
          onTap: () {
            if (item != null && !c.state.isLoading) {
              AppLogger.i('Card tapped.');
              Get.to(() => const PantauPaketmuScreen());
            }
          },
          child: Shimmer(
            isLoading: c.state.isLoading,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: Container(
                            decoration: BoxDecoration(
                              color: c.state.isLoading
                                  ? greyColor
                                  : Colors.transparent,
                            ),
                            child: Text(
                              item?.status ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          child: Container(
                            color: c.state.isLoading
                                ? greyColor
                                : Colors.transparent,
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
                        ),
                        // COD
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          color: c.state.isLoading
                              ? greyColor
                              : Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: blueJNE,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: blueJNE),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 3),
                                          const Text(
                                            'COD',
                                            style: TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                          const SizedBox(width: 13),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                              child: Text(
                                                c.state.selectedKiriman == 0
                                                    ? 'Rp. ${item?.codAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.codAmount.toString())) : '0'}'
                                                    : c.state.selectedKiriman ==
                                                            1
                                                        ? 'Rp. ${item?.codOngkirAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.codOngkirAmount.toString())) : '0'}'
                                                        : "Rp. 0",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(fontSize: 10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            c.state.selectedKiriman == 0
                                                ? '${item?.codAmountPercentage}%'
                                                : c.state.selectedKiriman == 1
                                                    ? '${item?.ongkirCodAmountPercentage}%'
                                                    : "0%",
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Ongkir
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 3),
                          color: c.state.isLoading
                              ? greyColor
                              : Colors.transparent,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: warningColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: warningColor),
                                ),
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
                                            decoration: const BoxDecoration(
                                              color: whiteColor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(5),
                                                bottomRight: Radius.circular(5),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 3),
                                              child: Text(
                                                c.state.selectedKiriman == 0
                                                    ? 'Rp. ${item?.ongkirCodAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.ongkirCodAmount.toString())) : '0'}'
                                                    : c.state.selectedKiriman ==
                                                            1
                                                        ? 'Rp 0'
                                                        : 'Rp. ${item?.ongkirNonCodAmount != null ? NumberFormat('#,##0', 'id').format(int.parse(item!.ongkirNonCodAmount.toString())) : '0'}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium
                                                    ?.copyWith(fontSize: 10),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            c.state.selectedKiriman == 0
                                                ? '${item?.ongkirCodAmountPercentage}%'
                                                : c.state.selectedKiriman == 1
                                                    ? '0%'
                                                    : '${item?.ongkirNonCodAmountPercentage}%',
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10),
                                          ),
                                        ],
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
                    const Spacer(),
                    const Column(
                      children: [
                        SizedBox(height: 10),
                        Icon(Icons.location_on_outlined,
                            color: greyLightColor2, size: 100)
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
