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
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Kiriman COD Kamu'.tr,
                      style: Theme.of(context).textTheme.titleLarge),
                  // const DateDropdownFilterButton(),
                ],
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CountCodItem(
                      data: CountCardModel(
                        // image: c.state,
                        status: c.state.transCountCod.first,
                        total: c.state.transSummary?.totalKirimanCod?.totalCod,
                        totalCod:
                            c.state.transSummary?.totalKirimanCod?.totalCod,
                      ),
                    ),
                    CountCodItem(
                      data: CountCardModel(
                        status: c.state.transCountCod.last,
                        total: c.state.transSummary?.totalKirimanCod
                            ?.codOngkirAmount,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
