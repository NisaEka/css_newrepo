import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

class FacilityController extends BaseController {

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<FacilityModel> codFacilities = [];
  List<FacilityModel> nonCodFacilities = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    showLoadingIndicator = true;
    try {
      AllowedMenu allowedMenu = AllowedMenu.fromJson(
          await storage.readData(StorageCore.allowedMenu)
      );
      if (allowedMenu.fasilitas == 'Y') {
        await facility.getFacilities()
            .then((response) async {
              if (response.code == 200) {
                response.payload?.forEach((facility) {
                  if (facility.type == "COD") {
                    codFacilities.add(facility);
                  } else {
                    nonCodFacilities.add(facility);
                  }
                });
                showMainContent = true;
              } else {
                showErrorContent = true;
              }
        });
      } else {
        showProhibitedContent = true;
      }


    } catch(e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

}