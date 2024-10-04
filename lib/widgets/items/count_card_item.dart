import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/image_const.dart';
import 'package:css_mobile/data/model/dashboard/count_card_model.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customlabel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CountCardItem extends StatelessWidget {
  final CountCardModel data;
  final bool isLoading;
  final int index;

  const CountCardItem({
    super.key,
    required this.data,
    this.isLoading = false,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      "Jumlah Transaksi",
      "Masih di Kamu",
      "Sudah di Jemput",
      "Dalam Perjalanan",
      "Sukses Diterima",
      "Sudah Kembali",
      "Dalam Peninjauan",
      "Dibatalkan",
    ];
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageConstant.dashboardCountIcons[index],
                      height: 25,
                    ),
                    const SizedBox(height: 28),
                    _loadingText(Text('${data.count ?? 0}', style: Theme.of(context).textTheme.headlineLarge)),
                    const SizedBox(height: 18),
                    Text(data.title?.tr ?? titles[index].tr, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
              ),
              CustomLabelText(
                title: 'COD',
                value: data.cod?.toString() ?? '',
                isHorizontal: true,
                isHasSpace: true,
                fontColor: whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: successColor.withOpacity(0.6),
              ),
              CustomLabelText(
                title: 'NON COD',
                value: data.nonCod?.toString() ?? '',
                isHorizontal: true,
                isHasSpace: true,
                fontColor: whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: warningColor.withOpacity(0.8),
              ),
              CustomLabelText(
                title: 'COD ONGKIR',
                value: data.codOngkir?.toString() ?? '',
                isHorizontal: true,
                isHasSpace: true,
                fontColor: whiteColor,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: infoColor.withOpacity(0.6),
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
