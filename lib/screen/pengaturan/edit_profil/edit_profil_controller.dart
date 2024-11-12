import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/profile/ccrf_profile_model.dart';
import 'package:css_mobile/data/model/profile/user_profile_model.dart';

import 'package:css_mobile/data/model/master/get_origin_model.dart';
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
  bool isLoadOrigin = false;
  // GetDestinationModel? destinationModel;
  Destination? selectedCity;
  Origin? selectedOrigin;
  UserModel? basicProfil;
  CcrfProfileModel? ccrfProfil;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await profil
          .getBasicProfil()
          .then((value) => basicProfil = value.data?.user);
      update();

      await profil.getCcrfProfil().then((value) {
        if (value.data != null) {
          ccrfProfil = value.data;
          isCcrf = value.data != null &&
              value.data?.generalInfo?.apiStatus == "Y";
        } else {
          ccrfProfil ??= CcrfProfileModel(
            generalInfo: GeneralInfo(
              name: basicProfil?.name?.toUpperCase(),
              brand: basicProfil?.brand?.toUpperCase(),
              address: basicProfil?.address?.toUpperCase(),
              email: basicProfil?.email,
              phone: basicProfil?.phone,
              zipCode: basicProfil?.zipCode,
            ),
          );
          selectedOrigin = basicProfil?.origin;
        }
      });
      update();
    } catch (e, i) {
      e.printError();
      i.printError();

      var basic =
          UserModel.fromJson(await storage.readData(StorageCore.basicProfile));

      brand.text = basic.brand ?? '';
      name.text = basic.name ?? '';
      address.text = basic.address ?? '';
      phone.text = basic.phone ?? '';
      email.text = basic.email ?? '';
      update();
    }
    brand.text = ccrfProfil?.generalInfo?.brand ?? '';
    name.text = ccrfProfil?.generalInfo?.name ?? '';
    address.text = ccrfProfil?.generalInfo?.address ?? '';
    city.text = '${ccrfProfil?.generalInfo?.city}; '
        '${ccrfProfil?.generalInfo?.district}; '
        '${ccrfProfil?.generalInfo?.subDistrict}; '
        '${ccrfProfil?.generalInfo?.zipCode}';
    selectedCity = Destination(
      cityName: ccrfProfil?.generalInfo?.city,
      countryName: ccrfProfil?.generalInfo?.country,
      districtName: ccrfProfil?.generalInfo?.district,
      subdistrictName: ccrfProfil?.generalInfo?.subDistrict,
      zipCode: ccrfProfil?.generalInfo?.zipCode,
      provinceName: ccrfProfil?.generalInfo?.province,
    );
    ktp.text = ccrfProfil?.generalInfo?.ktp ?? '';
    phone.text = ccrfProfil?.generalInfo?.phone ?? '';
    whatsapp.text = ccrfProfil?.generalInfo?.secondPhone ?? '';
    email.text = ccrfProfil?.generalInfo?.email ?? '';
    update();
    isLoading = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    try {
      // var response = await master.getdes(keyword);
      // destinationModel = response;
    } catch (e, i) {
      e.printError();
      i.printError();
    }

    isLoading = false;
    update();
    // return destinationModel?.payload?.toList() ?? [];
    return [];
  }

  Future<List<Origin>> getOriginList(String keyword) async {
    isLoadOrigin = true;
    // var response = await ongkir.postOrigin(keyword);
    // var models = response.payload?.toList();

    isLoadOrigin = false;
    update();
    // return models ?? [];
    return [];
  }

  Future<void> updateBasic() async {
    isLoading = true;
    update();
    String language = await storage.readString(StorageCore.localeApp);
    try {
      await profil
          .putProfileBasic(
            UserModel(
              name: name.text,
              brand: brand.text,
              phone: phone.text,
              address: address.text,
              origin: selectedOrigin,
              zipCode: selectedCity?.zipCode,
              language: language == 'id' ? 'INDONESEIA' : 'ENGLISH',
            ),
          )
          .then(
            (value) => Get.offAndToNamed("/profileGeneral"),
          );
    } catch (e) {
      e.printError();
    }

    isLoading = false;
    update();
  }

  Future<void> updateCcrf() async {
    isLoading = true;
    update();
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
            subDistrict: selectedCity?.subdistrictName,
            zipCode: selectedCity?.zipCode,
          ))
          .then(
            (value) => Get.offAndToNamed("/profileGeneral"),
          );
    } catch (e) {
      e.printError();
    }

    updateBasic();

    isLoading = false;
    update();
  }

  selectOrigin(value) {
    {
      selectedOrigin = value;
      update();
    }
  }
}
