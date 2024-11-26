import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/util/ext/num_ext.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountCodItem extends StatelessWidget {
  final CountCardModel data;
  final bool isLoading;
  final int? totalCOD;
  final double? percentage;

  const CountCodItem({
    super.key,
    this.isLoading = false,
    required this.data,
    this.totalCOD,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          // padding: const EdgeInsets.all(10),
          width: Get.width / 2,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: greyColor),
            // color: whiteColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      data.status?.tr ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 5),
                    _loadingText(Text(
                        'Rp. ${data.total?.toInt().toCurrency() ?? 0}',
                        style: Theme.of(context).textTheme.headlineLarge)),
                    const SizedBox(height: 18),
                  ],
                ),
              ),
              CustomLabelText(
                title:
                    '${data.totalCod ?? totalCOD} dari ${data.total} Kiriman ($percentage%)'
                        .tr,
                value: data.totalCod?.toInt().toCurrency() ?? '',
                isHorizontal: true,
                isHasSpace: true,
                fontColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: greyColor.withOpacity(0.2),
              ),
            ],
          ),
        ));
  }

  Widget _loadingText(Widget child) {
    return Shimmer(
      isLoading: isLoading,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        color: isLoading ? greyColor : Colors.transparent,
        child: child,
      ),
    );
  }
}
