import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/eclaim/eclaim_model.dart';
import 'package:css_mobile/screen/hubungi_aku/eclaim/eclaim_controller.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/items/eclaim_list_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class EclaimItems extends StatelessWidget {
  const EclaimItems({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<EclaimController>(
      init: EclaimController(),
      builder: (c) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(2),
              child: Text('Daftar Klaim',
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            SizedBox(
              height: screenHeight * 0.5,
              child: RefreshIndicator(
                onRefresh: () => Future.sync(() {
                  c.state.pagingController.refresh();
                }),
                child: PagedListView<int, EclaimModel>(
                  pagingController: c.state.pagingController,
                  builderDelegate: PagedChildBuilderDelegate<EclaimModel>(
                    transitionDuration: const Duration(milliseconds: 500),
                    itemBuilder: (context, item, index) => EclaimListItem(
                      claimType: item.kategori ?? '',
                      awb: item.awb ?? '',
                      date: item.createDate ?? '',
                      amount: item.valueclaim ?? '',
                      isSuccess: true,
                    ),
                    firstPageErrorIndicatorBuilder: (context) =>
                        const DataEmpty(),
                    firstPageProgressIndicatorBuilder: (context) => Column(
                      children: List.generate(
                        3,
                        (index) => const EclaimListItem(isLoading: true),
                      ),
                    ),
                    noItemsFoundIndicatorBuilder: (context) =>
                        const DataEmpty(),
                    noMoreItemsIndicatorBuilder: (context) => Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Divider(
                          indent: 100,
                          endIndent: 100,
                          thickness: 2,
                          color: primaryColor(context),
                        ),
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
        );
      },
    );
  }
}
