import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/facility/facility_model.dart';
import 'package:css_mobile/data/storage_core.dart';

class FacilityController extends BaseController {

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<FacilityModel> codFacilities = FacilityModel().getCodFacilities();
  List<FacilityModel> nonCodFacilities = FacilityModel().getNonCodFacilities();

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
        showMainContent = true;
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