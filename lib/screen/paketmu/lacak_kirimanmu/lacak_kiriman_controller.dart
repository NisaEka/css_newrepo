import 'package:collection/collection.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/data/model/lacak_kiriman/post_lacak_kiriman_model.dart';
import 'package:css_mobile/screen/paketmu/lacak_kirimanmu/lacak_kiriman_detail.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:css_mobile/widgets/dialog/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class LacakKirimanController extends BaseController {
  final searchField = TextEditingController();
  final String? resi = Get.arguments?['nomor_resi'];

  String? phoneNumber;
  List<PostLacakKirimanModel?> cnotes = [];
  final PagingController<int, PostLacakKirimanModel> pagingController = PagingController(firstPageKey: 1);

  bool isLoading = false;
  bool isLogin = false;

  PostLacakKirimanModel? trackModel = PostLacakKirimanModel();

  @override
  void onInit() {
    super.onInit();
    cekToken();
    if (resi != null) {
      searchField.text = resi ?? '';
      Future.delayed(Duration.zero, () async {
        countInputSearch(searchField.text);

        // if (await cekToken()) {
        searchCnotes(resi ?? '');
        // } else {
        //   Get.to(
        //     () => PhoneNumberConfirmationScreen(
        //       awb: resi ?? '',
        //       isLoading: isLoading,
        //     ),
        //   )?.then(
        //     (phoneNumber) {
        //       phoneNumber = phoneNumber;
        //       searchCnotes(resi ?? '');
        //     },
        //   );
        // }
      });
    }
  }

  Future<void> searchCnotes(String value) async {
    cnotes.clear();
    isLoading = true;
    FocusScope.of(Get.context!).unfocus();

    update();

    value.split('\n').take(101).forEachIndexed((index, cnote) async {
      // var response = await trace.postTracingByCnote(cnote);
      final response = await cekToken() ? await trace.postTracingByCnote(cnote) : await trace.postTracingByCnotePublic(cnote, phoneNumber ?? '');

      if (response.code == 200) {
        cnotes.add(response.data);
      } else {
        if (cnote.isNotEmpty) {
          cnotes.add(PostLacakKirimanModel(
            cnote: Cnote(cnoteNo: cnote, podStatus: isLogin ? "NOT FOUND" : "DETAIL"),
          ));
        }
      }
      update();
    });

    Future.delayed(
      const Duration(seconds: 3),
      () {
        isLoading = false;
        update();
      },
    );
  }

  Future<bool> cekToken() async {
    String? token = await storage.readAccessToken();
    AppLogger.d('token : $token');
    isLogin = token != null;
    update();

    return isLogin;
  }

  Future<void> cekResi({
    required PostLacakKirimanModel? nomorResi,
    required String phoneNumber,
    required int index,
  }) async {
    isLoading = true;
    FocusScope.of(Get.context!).unfocus();

    Get.dialog(const LoadingDialog());
    update();
    try {
      // final response = await cekToken() ? await trace.postTracingByCnote(nomorResi) : await trace.postTracingByCnotePublic(nomorResi, phoneNumber);
      final response = await trace.postTracingByCnotePublic(nomorResi?.cnote?.cnoteNo ?? '', phoneNumber);
      trackModel = response.data;
      debugPrint("lacaak response ${trackModel?.toJson()}");
    } catch (e, i) {
      AppLogger.e('error cekResi $e, $i');
    }

    isLoading = false;
    update();

    // return trackModel ?? PostLacakKirimanModel();
    if (trackModel != null) {
      Get.to(LacakKirimanDetail(
        data: trackModel ?? PostLacakKirimanModel(),
      ))?.then((_) {
        cnotes[index] = trackModel;
        update();
        Get.back();
        FocusScope.of(Get.context!).unfocus();
      });
    } else {
      Get.dialog(
        DefaultAlertDialog(
          subtitle: 'Data Tidak Ditemukan'.tr,
          confirmButtonTitle: 'Ok'.tr,
          onConfirm: () {
            cnotes[index] = PostLacakKirimanModel(
              cnote: Cnote(cnoteNo: nomorResi?.cnote?.cnoteNo, podStatus: "NOT FOUND"),
            );
            update();

            Get.close(2);
            FocusScope.of(Get.context!).unfocus();
          },
        ),
      );
    }
  }

  void countInputSearch(String value) {
    if (value.split('\n').where((element) => element.isNotEmpty).length > 100) {
      Get.dialog(
        DefaultAlertDialog(
          title: "Peringatan".tr,
          icon: Icon(
            Icons.warning,
            color: warningColor,
            size: Get.width / 4,
          ),
          subtitle: 'Maksimal Pencarian adalah 100 awb'.tr,
          confirmButtonTitle: 'Ok'.tr,
          onConfirm: () {
            Get.back();
            FocusScope.of(Get.context!).unfocus();
          },
        ),
      );
    }
  }
}
