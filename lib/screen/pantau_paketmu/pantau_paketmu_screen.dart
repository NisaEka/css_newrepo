import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/pantau/pantau_paketmu_list_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/pantau_paketmu/components/pantau_paketmu_list_filter.dart';
import 'package:css_mobile/screen/pantau_paketmu/detail/pantau_paketmu_detail_screen.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/input_formatter/custom_formatter.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/bar/custombackbutton.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuScreen extends StatelessWidget {
  const PantauPaketmuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Find the controller (initialization is handled here)
    PantauPaketmuController controller = Get.find<PantauPaketmuController>();

    return GetBuilder<PantauPaketmuController>(
      init: controller, // Ensure controller is initialized here if not already
      builder: (controller) {
        return Scaffold(
          appBar: CustomTopBar(
            title: 'Pantau Paketmu'.tr,
            leading: CustomBackButton(
              onPressed: () =>
                  Get.delete<DashboardController>().then((_) => Get.back()),
            ),
            action: const [
              PantauPaketmuListFilter(),
            ],
          ),
          body: _bodyContent(controller, context),
        );
      },
    );
  }

  Widget _bodyContent(PantauPaketmuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.state.searchField,
            hintText: 'Cari'.tr,
            inputFormatters: [
              UpperCaseTextFormatter(),
            ],
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light
                  ? whiteColor
                  : blueJNE,
            ),
            onChanged: (value) {
              c.onSearchChanged(value); // Assuming this method calls update()
            },
            onClear: () {
              c.state.searchField.clear();
              c.state.pagingController.refresh();
            },
            margin: const EdgeInsets.only(top: 20),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  AppLogger.i('Refresh');
                  c.applyFilter(isDetail: true);
                },
              ),
              child: PagedListView<int, PantauPaketmuListModel>(
                pagingController: c.state.pagingController,
                builderDelegate:
                    PagedChildBuilderDelegate<PantauPaketmuListModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                    data: TransactionModel(
                      awb: item.awbNo,
                      orderId: item.orderId,
                      statusAwb: item.statusawb,
                      serviceCode: item.service,
                      apiType: item.awbType,
                      receiverName: item.receiverName,
                      createdDateSearch: item.awbDate,
                    ),
                    isLoading: false,
                    index: index,
                    isSelected: c.state.selectedTransaction
                        .where((e) => e == item)
                        .isNotEmpty,
                    onLongPress: () {
                      // c.select(item);
                    },
                    onTap: () {
                      Get.to(
                        const PantauPaketmuDetailScreen(),
                        arguments: {"awbNo": item.awbNo},
                      );
                    },
                  ),
                  firstPageErrorIndicatorBuilder: (context) => _loading(),
                  firstPageProgressIndicatorBuilder: (context) => _loading(),
                  noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
                  noMoreItemsIndicatorBuilder: (context) => Center(
                    child: Divider(
                      indent: 100,
                      endIndent: 100,
                      thickness: 2,
                      color: primaryColor(context),
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
  }

  Widget _loading() {
    return Column(
      children: List.generate(
        10,
        (index) => const RiwayatKirimanListItem(isLoading: true),
      ),
    );
  }
}
