import 'package:css_mobile/screen/cek_ongkir/controller.dart';
import 'package:css_mobile/util/ext/int_ext.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/items/ongkir_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CekOngkirData extends StatelessWidget {
  const CekOngkirData({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CekOngkirController>(
        init: CekOngkirController(),
        builder: (c) {
          return Column(
            children: [
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFormLabel(label: 'Layanan'.tr),
                  CustomFormLabel(label: 'Biaya & Durasi'.tr),
                ],
              ),
              const Divider(),
              Column(
                children: c.state.ongkirList
                    .map(
                      (e) => OngkirListItem(
                        serviceTitle: e.serviceDisplay.toString(),
                        serviceSubtitle: e.goodsType.toString(),
                        servicePrice: (e.price!.toInt() + c.state.isr).toInt().toCurrency().toString(),
                        serviceDuration: '${e.etdFrom ?? ''} - ${e.etdThru ?? ''} ${e.times ?? ''}',
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        });
  }
}
