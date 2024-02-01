import 'package:collection/collection.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/screen/paketmu/draft_transaksi/draft_transaksi_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/draft_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DraftTransaksiScreen extends StatelessWidget {
  const DraftTransaksiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DraftTransaksiController>(
        init: DraftTransaksiController(),
        builder: (controller) {
          return Scaffold(
            appBar: const CustomTopBar(
              title: 'Draft Transaksi',
              action: [
                CustomFilledButton(
                  color: successColor,
                  icon: Icons.sync,
                  width: 100,
                  title: 'Sync Data',
                ),
                SizedBox(width: 20)
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // CustomFilledButton(
                  //   color: errorColor,
                  //   title: 'clear draft',
                  //   onPressed: () {
                  //     controller.storage.deleteString(StorageCore.draftTransaction);
                  //     controller.initData();
                  //     controller.update();
                  //   },
                  // ),
                  const CustomSearchField(
                    hintText: 'cari...',
                  ),
                  Expanded(
                    child: ListView(
                      children: controller.draftList.reversed
                          .mapIndexed(
                            (i, e) => DraftTransactionListItem(
                              data: e,
                              onDelete: () => controller.delete(i),
                              onValidate: () => controller.validate(i),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
