import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/components/contact_appbar.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver/add/add_receiver_screen.dart';
import 'package:css_mobile/screen/paketmu/input_kiriman/receiver_info/receiver/list_receiver_controller.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ListPenerimaScreen extends StatelessWidget {
  const ListPenerimaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ListPenerimaController>(
        init: ListPenerimaController(),
        builder: (controller) {
          return Scaffold(
            appBar: ContactAppbar(
              isDropshipper: false,
              isOnline: controller.isOnline,
              onAdd: () => Get.to(const AddReceiverScreen()),
            ),
            body: RefreshIndicator(
              onRefresh: () => controller.initData(),
              child: _bodyContent(controller, context),
            ),
          );
        });
  }

  Widget _bodyContent(ListPenerimaController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.search,
            hintText: 'Cari Data Penerima'.tr,
            prefixIcon: Icon(
              Icons.search,
              color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
            ),
            inputFormatters: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                return newValue.copyWith(text: newValue.text.toUpperCase());
              })
            ],
            onChanged: (value) {
              c.pagingController.refresh();
            },
            onClear: () {
              c.search.clear();
              c.pagingController.refresh();
            },
          ),
          c.isLoading
              ? Expanded(
                  child: ListView.builder(
                  itemBuilder: (context, i) =>
                      c.receiverItem(ReceiverModel(), i, context),
                  itemCount: 10,
                ))
              : Expanded(
                  child: PagedListView<int, ReceiverModel>(
                      pagingController: c.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<ReceiverModel>(
                        transitionDuration: const Duration(milliseconds: 500),
                        itemBuilder: (context, item, index) =>
                            c.pagingController.itemList!.isNotEmpty
                                ? c.receiverItem(item, index, context)
                                : const Center(child: DataEmpty()),
                        noItemsFoundIndicatorBuilder: (context) =>
                            const DataEmpty(),
                        newPageProgressIndicatorBuilder: (context) =>
                            const LoadingDialog(
                          background: Colors.transparent,
                          height: 50,
                          size: 30,
                        ),
                      )
                      //  ListView(
                      //   shrinkWrap: true,
                      //   children: c.pagingController.itemList!.isNotEmpty
                      //       ? c.pagingController.itemList!
                      //           .mapIndexed(
                      //             (i, e) => c.receiverItem(e, i, context),
                      //           )
                      //           .toList()
                      //       : [const Center(child: DataEmpty())],
                      // ),
                      ))
        ],
      ),
    );
  }
}
