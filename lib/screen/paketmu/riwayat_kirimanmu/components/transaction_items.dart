import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/paketmu/riwayat_kirimanmu/riwayat_kiriman_controller.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customcheckbox.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionItems extends StatelessWidget {
  const TransactionItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RiwayatKirimanController>(
        init: RiwayatKirimanController(),
        builder: (c) {
          return Expanded(
            child: Column(
              children: [
                c.state.isSelect
                    ? CustomCheckbox(
                        value: c.state.isSelectAll,
                        label: 'Pilih Semua'.tr,
                        onChanged: (value) {
                          c.selectAll(value!);
                        },
                      )
                    : const SizedBox(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () {
                        c.state.pagingController.refresh();
                        // c.transactionCount();
                      },
                    ),
                    child: PagedListView<int, TransactionModel>(
                      pagingController: c.state.pagingController,
                      builderDelegate:
                          PagedChildBuilderDelegate<TransactionModel>(
                        transitionDuration: const Duration(milliseconds: 500),
                        itemBuilder: (context, item, index) =>
                            RiwayatKirimanListItem(
                          data: item,
                          isLoading: false,
                          status: item.statusAwb,
                          index: index,
                          isSelected: c.state.selectedTransaction
                              .where((e) => e == item)
                              .isNotEmpty,
                          onLongPress: () {
                            c.select(item);
                          },
                          onTap: () {
                            c.unselect(item);
                          },
                          isDelete: item.statusAwb == "MASIH DI KAMU",
                          onDelete: (context) => showDialog(
                            context: context,
                            builder: (context) => DeleteAlertDialog(
                              onDelete: () {
                                c.delete(item);
                                c.initData();
                                Get.back();
                              },
                              onBack: () {
                                Get.back();
                                c.state.pagingController.refresh();
                                c.initData();
                              },
                            ),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (context) =>
                            const DataEmpty(),
                        firstPageProgressIndicatorBuilder: (context) => Column(
                          children: List.generate(
                            3,
                            (index) =>
                                const RiwayatKirimanListItem(isLoading: true),
                          ),
                        ),
                        // firstPageProgressIndicatorBuilder: (context) => const LoadingDialog(
                        //   height: 100,
                        //   background: Colors.transparent,
                        // ),
                        noItemsFoundIndicatorBuilder: (context) =>
                            const DataEmpty(),
                        noMoreItemsIndicatorBuilder: (context) => const Center(
                          child: Divider(
                            indent: 100,
                            endIndent: 100,
                            thickness: 2,
                            color: blueJNE,
                          ),
                        ),
                        newPageProgressIndicatorBuilder: (context) =>
                            const LoadingDialog(
                          background: Colors.transparent,
                          height: 50,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
