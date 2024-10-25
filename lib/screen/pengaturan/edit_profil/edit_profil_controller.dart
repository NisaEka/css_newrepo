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
              value.data?.generalInfo?.ccrfApistatus == "Y";
        } else {
          ccrfProfil ??= CcrfProfileModel(
            generalInfo: GeneralInfo(
              ccrfName: basicProfil?.name?.toUpperCase(),
              ccrfBrand: basicProfil?.brand?.toUpperCase(),
              ccrfAddress: basicProfil?.address?.toUpperCase(),
              ccrfEmail: basicProfil?.email,
              ccrfPhone: basicProfil?.phone,
              ccrfZipcode: basicProfil?.zipCode,
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
          UserModel.fromJson(await storage.readData(StorageCore.userProfil));

      brand.text = basic.brand ?? '';
      name.text = basic.name ?? '';
      address.text = basic.address ?? '';
      phone.text = basic.phone ?? '';
      email.text = basic.email ?? '';
      update();
    }
    brand.text = ccrfProfil?.generalInfo?.ccrfBrand ?? '';
    name.text = ccrfProfil?.generalInfo?.ccrfName ?? '';
    address.text = ccrfProfil?.generalInfo?.ccrfAddress ?? '';
    city.text = '${ccrfProfil?.generalInfo?.ccrfCity}; '
        '${ccrfProfil?.generalInfo?.ccrfDistrict}; '
        '${ccrfProfil?.generalInfo?.ccrfSubdistrict}; '
        '${ccrfProfil?.generalInfo?.ccrfZipcode}';
    selectedCity = Destination(
      cityName: ccrfProfil?.generalInfo?.ccrfCity,
      countryName: ccrfProfil?.generalInfo?.ccrfCountry,
      districtName: ccrfProfil?.generalInfo?.ccrfDistrict,
      subdistrictName: ccrfProfil?.generalInfo?.ccrfSubdistrict,
      zipCode: ccrfProfil?.generalInfo?.ccrfZipcode,
      provinceName: ccrfProfil?.generalInfo?.ccrfProvince,
    );
    ktp.text = ccrfProfil?.generalInfo?.ccrfKtp ?? '';
    phone.text = ccrfProfil?.generalInfo?.ccrfPhone ?? '';
    whatsapp.text = ccrfProfil?.generalInfo?.ccrfHandphone ?? '';
    email.text = ccrfProfil?.generalInfo?.ccrfEmail ?? '';
    update();
    isLoading = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    isLoading = true;
    try {
      // var response = await transaction.getDestination(keyword);
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

  Future<void> updateData() async {
    isLoading = true;
    update();
    try {
      await profil
          .putProfileCCRF(GeneralInfo(
            ccrfBrand: brand.text,
            ccrfName: name.text,
            ccrfAddress: address.text,
            ccrfCountry: selectedCity?.countryName,
            ccrfDistrict: selectedCity?.districtName,
            ccrfProvince: selectedCity?.provinceName,
            ccrfCity: selectedCity?.cityName,
            ccrfSubdistrict: selectedCity?.subdistrictName,
            ccrfZipcode: selectedCity?.zipCode,
          ))
          .then(
            (value) => Get.offAndToNamed("/profileGeneral"),
          );
    } catch (e) {
      e.printError();
    }

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
