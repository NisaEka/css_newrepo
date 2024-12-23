import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PantauTotalKiriman extends StatelessWidget {
  final bool isLoading;
  const PantauTotalKiriman({
    super.key,
    this.isLoading = true,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
      init: PantauPaketmuController(),
      builder: (c) {
        return Shimmer(
          isLoading: isLoading,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isLoading ? greyColor : Colors.transparent,
                ),
                child: Text(
                  c.state.selectedKiriman == 0
                      ? c.state.cod.toString()
                      : c.state.selectedKiriman == 1
                          ? c.state.codOngkir.toString()
                          : c.state.noncod.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 40),
                ),
              ),
              const SizedBox(width: 5),
              Column(
                children: [
                  const SizedBox(height: 25),
                  Container(
                    decoration: BoxDecoration(
                      color: isLoading ? greyColor : Colors.transparent,
                    ),
                    child: Text(
                      "Total Kiriman",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 15),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Spacer(),
              Column(
                children: [
                  //COD
                  c.state.selectedKiriman == 0 || c.state.selectedKiriman == 1
                      ? Container(
                          decoration: BoxDecoration(
                            color: c.state.isLoading ? greyColor : whiteColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: blueJNE),
                          ),
                          width: 160,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: blueJNE,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 3),
                                  child: Text(
                                    'COD',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                // padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  c.state.selectedKiriman == 0
                                      ? (c.state.countList.isNotEmpty &&
                                              c.state.countList.first
                                                      .codAmount !=
                                                  null
                                          ? 'Rp. ${NumberFormat('#,##0', 'id').format(int.parse(c.state.countList.first.codAmount.toString()))}'
                                          : 'Rp. 0')
                                      : c.state.selectedKiriman == 1
                                          ? (c.state.countList.isNotEmpty &&
                                                  c.state.countList.first
                                                          .ongkirCodAmount !=
                                                      null
                                              ? 'Rp. ${NumberFormat('#,##0', 'id').format(int.parse(c.state.countList.first.codOngkirAmount.toString()))}'
                                              : 'Rp. 0')
                                          : 'Rp. 0',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontSize: 10,
                                          color: blueJNE,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                  c.state.selectedKiriman == 0 || c.state.selectedKiriman == 1
                      ? const SizedBox(height: 5)
                      : const SizedBox(),
                  // ONGKIR
                  c.state.selectedKiriman == 0 || c.state.selectedKiriman == 2
                      ? Container(
                          decoration: BoxDecoration(
                            color: c.state.isLoading ? greyColor : whiteColor,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: blueJNE),
                          ),
                          width: 160,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: blueJNE,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  child: Text(
                                    'Ongkir',
                                    style: TextStyle(
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  c.state.selectedKiriman == 0
                                      ? (c.state.countList.isNotEmpty &&
                                              c.state.countList.first
                                                      .ongkirCodAmount !=
                                                  null
                                          ? 'Rp. ${NumberFormat('#,##0', 'id').format(int.parse(c.state.countList.first.ongkirCodAmount.toString()))}'
                                          : 'Rp. 0')
                                      : c.state.selectedKiriman == 1
                                          ? (c.state.countList.isNotEmpty &&
                                                  c.state.countList.first
                                                          .ongkirCodAmount !=
                                                      null
                                              ? 'Rp. 0'
                                              : 'Rp. 0')
                                          : 'Rp. ${NumberFormat('#,##0', 'id').format(int.parse(c.state.countList.first.ongkirNonCodAmount.toString()))}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          fontSize: 10,
                                          color: blueJNE,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
