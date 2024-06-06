import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/profile/get_basic_profil_model.dart';
import 'package:css_mobile/data/model/profile/get_ccrf_profil_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final brand = TextEditingController();
  final name = TextEditingController();
  final address = TextEditingController();
  final city = TextEditingController();
  final ktp = TextEditingController();
  final phone = TextEditingController();
  final whatsapp = TextEditingController();
  final email = TextEditingController();

  bool isLoading = false;
  bool isCcrf = false;
  GetDestinationModel? destinationModel;
  Destination? selectedCity;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await profil.getCcrfProfil().then((value) {
        isCcrf = value.payload != null;
        brand.text = value.payload?.generalInfo?.brand ?? '';
        name.text = value.payload?.generalInfo?.name ?? '';
        address.text = value.payload?.generalInfo?.address ?? '';
        city.text = '${value.payload?.generalInfo?.city}; '
            '${value.payload?.generalInfo?.district}; '
            '${value.payload?.generalInfo?.subDistrict}; '
            '${value.payload?.generalInfo?.zipCode}';
        selectedCity = Destination(
          cityName: value.payload?.generalInfo?.city,
          countryName: value.payload?.generalInfo?.country,
          districtName: value.payload?.generalInfo?.district,
          subDistrictName: value.payload?.generalInfo?.subDistrict,
          zipCode: value.payload?.generalInfo?.zipCode,
          provinceName: value.payload?.generalInfo?.province,
        );
        ktp.text = value.payload?.generalInfo?.idCardNumber ?? '';
        phone.text = value.payload?.generalInfo?.phone ?? '';
        whatsapp.text = value.payload?.generalInfo?.secondaryPhone ?? '';
        email.text = value.payload?.generalInfo?.email ?? '';
        update();
      });
    } catch (e, i) {
      e.printError();
      i.printError();

      var basic = BasicProfilModel.fromJson(await storage.readData(StorageCore.userProfil));

      brand.text = basic.brand ?? '';
      name.text = basic.name ?? '';
      address.text = basic.address ?? '';
      phone.text = basic.phone ?? '';
      email.text = basic.email ?? '';
      update();
    }

    isLoading = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    try {
      var response = await transaction.getDestination(keyword);
      destinationModel = response;
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    return destinationModel?.payload?.toList() ?? [];
  }

  Future<void> updateData() async {
    try {
      await profil
          .putProfileCCRF(GeneralInfo(
            brand: brand.text,
            name: name.text,
            address: address.text,
            country: selectedCity?.countryName,
            district: selectedCity?.districtName,
            province: selectedCity?.provinceName,
            city: selectedCity?.cityName,
            subDistrict: selectedCity?.subDistrictName,
            zipCode: selectedCity?.zipCode,
          ))
          .then(
            (value) => Get.offAndToNamed("/profileGeneral"),
          );
    } catch (e) {
      e.printError();
    }
  }
}
