import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/widgets/items/count_cod_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardKirimanCod extends StatelessWidget {
  const DashboardKirimanCod({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (c) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CountCodItem(
                data: CountCardModel(
                  total: c.state.transSummary?.totalKirimanCod?.totalCod,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
