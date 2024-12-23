import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/util/constant.dart';

class FacilityController extends BaseController {
  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<FacilityModel> codFacilities = [];
  List<FacilityModel> nonCodFacilities = [];

  String _bannerStatus = Constant.bannerStatusHide;
  String get bannerStatus => _bannerStatus;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    showLoadingIndicator = true;
    try {
      MenuModel menuModel =
          MenuModel.fromJson(await storage.readData(StorageCore.userMenu));
      if (menuModel.fasilitas == Constant.keyMenuAllowed) {
        await facility.getFacilities().then((response) async {
          if (response.code == HttpStatus.ok) {
            final facilities = response.data ?? List.empty();
            _determineBannerStatus(facilities);

            for (var facility in facilities) {
              if (facility.type == Constant.keyTypeCod) {
                codFacilities.add(facility);
              } else {
                nonCodFacilities.add(facility);
              }
            }

            showMainContent = true;
          } else {
            showErrorContent = true;
          }
        });
      } else {
        showProhibitedContent = true;
        update();
      }
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

  void _determineBannerStatus(List<FacilityModel> facilities) {
    final facilityOnProgressStatuses = facilities.map((e) => e.onProcess);
    final facilityCanUseStatuses = facilities.map((e) => e.canUse);

    if (facilityOnProgressStatuses.contains(true)) {
      _bannerStatus = Constant.bannerStatusOnProcess;
    } else if (facilityCanUseStatuses.contains(true)) {
      _bannerStatus = Constant.bannerStatusIdle;
    } else {
      _bannerStatus = Constant.bannerStatusHide;
    }

    update();
  }

  Future<void> onRefreshAction() async {
    showLoadingIndicator = false;
    showMainContent = false;
    showErrorContent = false;
    showProhibitedContent = false;

    _bannerStatus = Constant.bannerStatusHide;

    codFacilities.clear();
    nonCodFacilities.clear();

    initData();
  }
}
