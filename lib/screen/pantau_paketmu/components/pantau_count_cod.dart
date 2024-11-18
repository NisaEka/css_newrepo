import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_screen.dart';

class PantauCountCod extends StatelessWidget {
  final String title;

  const PantauCountCod({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return GetX<PantauPaketmuController>(
      init: PantauPaketmuController(),
      builder: (controller) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title.tr,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    // You can add a filter dropdown here if needed
                    // const DateDropdownFilterButton(),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: controller.state.countList.map((item) {
                      return _buildPantauCountCardItem(
                        context,
                        controller,
                        title: item['status'] ?? '',
                        totalCod: item['totalCod'] ?? 0,
                        codAmount: item['codAmount'] ?? 0,
                        ongkirCodAmount: item['ongkirCodAmount'] ?? 0,
                        totalCodOngkir: item['totalCodOngkir'] ?? 0,
                        codOngkirAmount: item['codOngkirAmount'] ?? 0,
                        totalNonCod: item['totalNonCod'] ?? 0,
                        ongkirNonCodAmount: item['ongkirNonCodAmount'] ?? 0,
                        totalCodPercentage:
                            (item['totalCodPercentage'] ?? 0).toDouble(),
                        codAmountPercentage:
                            (item['codAmountPercentage'] ?? 0).toDouble(),
                        ongkirCodAmountPercentage:
                            (item['ongkirCodAmountPercentage'] ?? 0).toDouble(),
                        totalCodOngkirPercentage:
                            (item['totalCodOngkirPercentage'] ?? 0).toDouble(),
                        codOngkirAmountPercentage:
                            (item['codOngkirAmountPercentage'] ?? 0).toDouble(),
                        totalNonCodPercentage:
                            (item['totalNonCodPercentage'] ?? 0).toDouble(),
                        ongkirNonCodAmountPercentage:
                            (item['ongkirNonCodAmountPercentage'] ?? 0)
                                .toDouble(),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPantauCountCardItem(
    BuildContext context,
    PantauPaketmuController controller, {
    required String title,
    required int totalCod,
    required int codAmount,
    required int ongkirCodAmount,
    required int totalCodOngkir,
    required int codOngkirAmount,
    required int totalNonCod,
    required int ongkirNonCodAmount,
    required double totalCodPercentage,
    required double codAmountPercentage,
    required double ongkirCodAmountPercentage,
    required double totalCodOngkirPercentage,
    required double codOngkirAmountPercentage,
    required double totalNonCodPercentage,
    required double ongkirNonCodAmountPercentage,
  }) {
    return Card.outlined(
      elevation: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: InkWell(
        splashColor: redJNE.withOpacity(0.3),
        onTap: () {
          AppLogger.i('Card tapped.');
          controller.state.selectedStatusKiriman.value = title;
          controller.state.selectedTipeKiriman.value = 'cod';
          controller.applyFilter(isDetail: true);
          Get.to(() => const PantauPaketmuScreen());
        },
        child: Container(
          width: Get.width / 1.5,
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                ),
              ),

              // Total COD Ongkir and Percentage Section
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      totalCod.toString(),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                    ),
                    const SizedBox(width: 10),
                    if (title != "Total Kiriman")
                      Text(
                        '($totalCodPercentage%)',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                      ),
                  ],
                ),
              ),
              CustomLabelText(
                title: 'COD'.tr,
                value:
                    'Rp ${codAmount.toInt().toCurrency()} ${title != "Total Kiriman" ? '($codAmountPercentage%)' : ''}',
                isHorizontal: true,
                isHasSpace: true,
                fontColor: whiteColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                color: blueJNE.withOpacity(0.8),
              ),
              Container(
                decoration: BoxDecoration(
                  color: redJNE.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ), // Rounded corners
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                child: CustomLabelText(
                  title: 'Ongkir'.tr,
                  value:
                      'Rp ${ongkirCodAmount.toInt().toCurrency()} ${title != "Total Kiriman" ? '($ongkirCodAmountPercentage%)' : ''}',
                  isHorizontal: true,
                  isHasSpace: true,
                  fontColor: whiteColor,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
