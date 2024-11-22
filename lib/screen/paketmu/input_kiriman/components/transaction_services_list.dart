import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/transaction_info/transaction_controller.dart';
import 'package:css_mobile/widgets/dialog/shimer_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionServicesList extends StatelessWidget {
  const TransactionServicesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TransactionController>(
        init: TransactionController(),
        builder: (c) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: c.state.serviceList.isEmpty &&
                    c.state.isOnline &&
                    !c.state.isServiceLoad
                ? SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => c.initData(),
                      child: Container(
                          decoration: const BoxDecoration(
                            color: greyLightColor3,
                          ),
                          width: Get.width / 2,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.refresh),
                              Text("Try again"),
                            ],
                          )),
                    ),
                  )
                : SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 170,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      childAspectRatio: 4.0,
                      // mainAxisExtent: 10
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => c.onSelectService(index),
                          child: Shimmer(
                            isLoading: c.state.isServiceLoad,
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: c.state.isServiceLoad
                                    ? greyColor
                                    : c.state.selectedService ==
                                            c.state.serviceList[index]
                                        ? AppConst.isLightTheme(context)
                                            ? blueJNE
                                            : redJNE
                                        : greyLightColor3,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: c.state.serviceList.isEmpty
                                  ? const SizedBox()
                                  : Text(
                                      c.state.serviceList[index]
                                                  .serviceDisplay ==
                                              'INTL'
                                          ? '${c.state.serviceList[index].serviceDisplay} - ${c.state.serviceList[index].goodsType}'
                                          : c.state.serviceList[index]
                                                  .serviceDisplay ??
                                              '',
                                      style: listTitleTextStyle.copyWith(
                                        color: c.state.selectedService ==
                                                c.state.serviceList[index]
                                            ? whiteColor
                                            : blueJNE,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                      childCount: c.state.isServiceLoad
                          ? 6
                          : c.state.serviceList.length,
                    ),
                  ),
          );
        });
  }
}
