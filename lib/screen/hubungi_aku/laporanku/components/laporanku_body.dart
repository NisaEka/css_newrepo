import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/laporanku/get_ticket_model.dart';
import 'package:css_mobile/screen/hubungi_aku/laporanku/laporanku_controller.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/laporanku_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../detail/detail_laporanku_screen.dart';
import 'laporanku_status.dart';

class LaporankuBody extends StatelessWidget {
  const LaporankuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LaporankuController>(
        init: LaporankuController(),
        builder: (c) {
          return Padding(
            padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
            child: Column(
              children: [
                CustomSearchField(
                  hintText: "Cari".tr,
                  controller: c.state.searchField,
                  prefixIcon: SvgPicture.asset(
                    IconsConstant.search,
                    color: Theme.of(context).brightness == Brightness.light
                        ? whiteColor
                        : blueJNE,
                  ),
                  margin: EdgeInsets.zero,
                  onChanged: (p0) => c.state.pagingController.refresh(),
                ),
                const StatusLaporanku(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => Future.sync(
                      () {
                        c.state.pagingController.refresh();
                      },
                    ),
                    child: PagedListView<int, TicketModel>(
                      pagingController: c.state.pagingController,
                      builderDelegate: PagedChildBuilderDelegate<TicketModel>(
                        transitionDuration: const Duration(milliseconds: 500),
                        itemBuilder: (context, item, index) =>
                            LaporankuListItem(
                          data: item,
                          index: index,
                          onTap: () =>
                              Get.to(DetailLaporankuScreen(data: item))?.then(
                            (_) => c.state.pagingController.refresh(),
                          ),
                        ),
                        firstPageErrorIndicatorBuilder: (context) =>
                            const DataEmpty(),
                        firstPageProgressIndicatorBuilder: (context) => Column(
                          children: List.generate(
                            10,
                            (index) => const LaporankuListItem(
                              isLoading: true,
                              // onTap: () => Get.to(const DetailLaporankuScreen()),
                            ),
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
                ),
              ],
            ),
          );
        });
  }
}
