import 'package:css_mobile/const/app_const.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/icon_const.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/screen/pengaturan/petugas/add/tambah_petugas_screen.dart';
import 'package:css_mobile/screen/pengaturan/petugas/pengaturan_petugas_controller.dart';
import 'package:css_mobile/widgets/bar/customtopbar.dart';
import 'package:css_mobile/widgets/dialog/data_empty_dialog.dart';
import 'package:css_mobile/widgets/dialog/delete_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:css_mobile/widgets/forms/customsearchfield.dart';
import 'package:css_mobile/widgets/items/petugas_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PengaturanPetugasScreen extends StatelessWidget {
  const PengaturanPetugasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PengaturanPetugasController>(
        init: PengaturanPetugasController(),
        builder: (controller) {
          return Scaffold(
            appBar: _appBarContent(controller, context),
            body: _bodyContent(controller, context),
          );
        });
  }

  CustomTopBar _appBarContent(PengaturanPetugasController c, BuildContext context){
    return CustomTopBar(
      title: 'Pengaturan Petugas'.tr,
      action: [
        IconButton(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          onPressed: () => Get.to(const TambahPetugasScreen(), arguments: {
            'isEdit': false,
          })?.then((value) => c.pagingController.refresh()),
          icon: Icon(
            Icons.add,
            color: AppConst.isLightTheme(context) ? blueJNE : redJNE,
          ),
        ),
      ],
    );
  }

  Widget _bodyContent(PengaturanPetugasController c, BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          CustomSearchField(
            controller: c.searchOfficer,
            hintText: 'Cari Data Petugas'.tr,
            prefixIcon: SvgPicture.asset(
              IconsConstant.search,
              color: AppConst.isLightTheme(context) ? whiteColor : blueJNE,
            ),
            onChanged: (value) {
              c.searchOfficer.text = value;
              c.update();
              c.pagingController.refresh();
            },
            onClear: () {
              c.searchOfficer.clear();
              c.update();
              c.pagingController.refresh();
            },
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () => Future.sync(
                    () => c.pagingController.refresh(),
              ),
              child: PagedListView<int, PetugasModel>(
                pagingController: c.pagingController,
                builderDelegate: PagedChildBuilderDelegate<PetugasModel>(
                  transitionDuration: const Duration(milliseconds: 500),
                  itemBuilder: (context, item, index) => PetugasListItem(
                    // isLoading: true,
                    index: index,
                    icon: Icon(
                      Icons.shield_outlined,
                      color: item.status == "Y" ? successColor : errorColor,
                    ),
                    title: item.name ?? '',
                    subtitle: '${item.email ?? '-'}\n${item.phone ?? '-'}\n${item.branch ?? ''} - ${item.origin ?? ''}',
                    onTap: () => Get.to(const TambahPetugasScreen(), arguments: {
                      'isEdit': true,
                      'data': item,
                    })?.then((value) => c.pagingController.refresh()),
                    onDelete: (context) => showDialog(
                      context: context,
                      builder: (context) => DeleteAlertDialog(
                        onDelete: () {
                          c.delete(item);
                          Get.back();
                        },
                        onBack: () {
                          Get.back();
                          c.pagingController.refresh();
                        },
                      ),
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (context) => const DataEmpty(),
                  firstPageProgressIndicatorBuilder: (context) => Column(
                    children: List.generate(
                      3,
                          (index) => PetugasListItem(
                        isLoading: c.isLoading,
                        title: '',
                        icon: const Icon(Icons.shield),
                        index: 0,
                      ),
                    ),
                  ),
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
          ),
        ],
      ),
    );
  }
}
