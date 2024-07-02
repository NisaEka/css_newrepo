import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/pantau/get_pantau_paketmu_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_paketmu_controller.dart';
import 'package:css_mobile/util/ext/string_ext.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customdropdownfield.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:css_mobile/widgets/forms/customformlabel.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/forms/customtextformfield.dart';
import 'package:css_mobile/widgets/items/riwayat_kiriman_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PantauPaketmuScreen extends StatelessWidget {
  const PantauPaketmuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PantauPaketmuController>(
        init: PantauPaketmuController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller),
            body: _bodyContent(controller, context),
          );
        });
  }

  CustomTopBar _appBarContent(PantauPaketmuController c) {
    return CustomTopBar(
      title: "Pantau Paketmu".tr,
      action: [
        Container(
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: c.isFiltered ? redJNE : Colors.transparent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: IconButton(
              onPressed: () {
                Get.bottomSheet(
                  enableDrag: true,
                  isDismissible: false,
                  // isScrollControlled: true,
                  StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
                    return _filterContent(context, c, setState);
                  }),
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
              icon: const Icon(Icons.filter_alt_outlined),
              color: c.isFiltered ? whiteColor : redJNE,
              tooltip: 'filter',
            ))
      ],
    );
  }

  Widget _filterContent(BuildContext context, PantauPaketmuController c, StateSetter setState) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Theme.of(context).brightness == Brightness.light ? greyLightColor2 : greyDarkColor2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filter',
                style: appTitleTextStyle.copyWith(
                  color: Theme.of(context).brightness == Brightness.light ? blueJNE : redJNE,
                ),
              ),
              IconButton(
                onPressed: () {
                  if (!c.isFiltered) {
                    c.resetFilter();
                  } else {
                    Get.back();
                  }
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          // const Divider(color: greyColor),
          const SizedBox(height: 10),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomFormLabel(label: 'Tanggal AWB'.tr),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextFormField(
                            controller: c.startDateField,
                            readOnly: true,
                            width: Get.width / 2.3,
                            hintText: 'Tanggal Awal'.tr,
                            onTap: () => c.selectDate(context).then((value) {
                              setState(() {
                                c.startDate = value;
                                c.startDateField.text = value.toString().toDateTimeFormat();
                                c.endDate = DateTime.now();
                                c.endDateField.text = DateTime.now().toString().toDateTimeFormat();
                                c.update();
                              });
                            }),
                            // hintText: 'Dari Tanggal',
                          ),
                          CustomTextFormField(
                            controller: c.endDateField,
                            readOnly: true,
                            width: Get.width / 2.3,
                            hintText: 'Tanggal Akhir'.tr,
                            onTap: () => c.selectDate(context).then((value) {
                              setState(() {
                                c.endDate = value;
                                c.endDateField.text = value.toString().toDateTimeFormat();
                                c.update();
                              });
                            }),
                          ),
                        ],
                      ),
                      CustomFormLabel(label: 'Status Kiriman'.tr),
                      const SizedBox(height: 10),
                      // CustomFormLabel(label: 'Petugas Entry'),
                    ],
                  ),
                ),
                // SliverPadding(
                //   padding: const EdgeInsets.symmetric(horizontal: 10),
                //   sliver: SliverGrid(
                //     delegate: SliverChildBuilderDelegate(
                //       (context, index) => GestureDetector(
                //         onTap: () => setState(() {
                //           if (c.selectedStatusKiriman != c.listStatusKiriman[index]) {
                //             c.selectedStatusKiriman = c.listStatusKiriman[index];
                //           } else {
                //             c.selectedStatusKiriman = null;
                //           }
                //           c.update();
                //         }),
                //         child: Container(
                //           alignment: Alignment.center,
                //           decoration: BoxDecoration(
                //             color: c.selectedStatusKiriman == c.listStatusKiriman[index] ? blueJNE : whiteColor,
                //             border: Border.all(
                //               color: c.selectedStatusKiriman != c.listStatusKiriman[index] ? blueJNE : whiteColor,
                //             ),
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Text(
                //             c.listStatusKiriman[index].tr,
                //             textAlign: TextAlign.center,
                //             style: listTitleTextStyle.copyWith(color: c.selectedStatusKiriman == c.listStatusKiriman[index] ? whiteColor : blueJNE),
                //           ),
                //         ),
                //       ),
                //       childCount: c.listStatusKiriman.length,
                //     ),
                //     gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                //       maxCrossAxisExtent: 140,
                //       mainAxisSpacing: 5,
                //       crossAxisSpacing: 16,
                //       childAspectRatio: 2,
                //       // mainAxisExtent: 100
                //     ),
                //   ),
                // ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      // const CustomFormLabel(label: 'Petugas Entry'),
                      CustomDropDownField(
                        items: c.listOfficerEntry
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        label: 'Petugas Entry'.tr,
                        hintText: 'Petugas Entry'.tr,
                        value: c.selectedPetugasEntry,
                        onChanged: (value) {
                          setState(() {
                            c.selectedPetugasEntry = value;
                            c.update();
                          });
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              c.isFiltered
                  ? CustomFilledButton(
                      color: whiteColor,
                      fontColor: blueJNE,
                      borderColor: blueJNE,
                      width: Get.width / 2.5,
                      title: 'Reset Filter'.tr,
                      onPressed: () => c.resetFilter(),
                    )
                  : const SizedBox(),
              CustomFilledButton(
                color: c.startDate != null || c.endDate != null || c.selectedPetugasEntry != null || c.selectedStatusKiriman != null
                    ? blueJNE
                    : greyColor,
                width: c.isFiltered ? Get.width / 2.5 : Get.width - 40,
                title: 'Terapkan'.tr,
                onPressed: () => c.applyFilter(),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyContent(PantauPaketmuController c, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchField,
            hintText: 'Cari'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: Theme.of(context).brightness == Brightness.light ? whiteColor : blueJNE,
            ),
            onChanged: (value) {
              c.searchField.text = value;
              c.update();
              c.pagingController.refresh();
            },
            onClear: () {
              c.searchField.clear();
              c.pagingController.refresh();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                () {
                  c.pagingController.refresh();
                  // c.transactionCount();
                },
              ),
              child: PagedListView<int, PantauPaketmuModel>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PantauPaketmuModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => RiwayatKirimanListItem(
                    data: TransactionModel(
                      awb: item.awbNo,
                      orderId: item.orderId,
                      status: item.statusPod,
                      service: item.service,
                      type: item.awbType,
                      receiver: Receiver(
                        name: item.receiverName,
                      ),
                      createdDate: item.awbDate,
                    ),
                    isLoading: false,
                    index: index,
                    isSelected: c.selectedTransaction.where((e) => e == item).isNotEmpty,
                    onLongPress: () {
                      // c.select(item);
                    },
                    onTap: () {
                      // c.unselect(item);
                    },
                  ),
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                      (index) => const RiwayatKirimanListItem(isLoading: true),
                    ),
                  ),
                  // firstPageProgressIndicatorBuilder: (context) => const LoadingDialog(
                  //   height: 100,
                  //   background: Colors.transparent,
                  // ),
                  noItemsFoundIndicatorBuilder: (context) => const DataEmpty(),
                  noMoreItemsIndicatorBuilder: (context) => const Center(
                    child: Divider(
                      indent: 100,
                      endIndent: 100,
                      thickness: 2,
                      color: blueJNE,
                    ),
                  ),
                  newPageProgressIndicatorBuilder: (context) => const LoadingDialog(
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
}
