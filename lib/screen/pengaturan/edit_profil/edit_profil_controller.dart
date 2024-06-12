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
  BasicProfilModel? basicProfil;
  CcrfProfilModel? ccrfProfil;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    isLoading = true;
    try {
      await profil.getBasicProfil().then((value) => basicProfil = value.payload);
      update();

      await profil.getCcrfProfil().then((value) {
        if (value.payload != null) {
          ccrfProfil = value.payload;
          isCcrf = value.payload != null;
        } else {
          ccrfProfil ??= CcrfProfilModel(
            generalInfo: GeneralInfo(
              name: basicProfil?.name,
              brand: basicProfil?.brand,
              address: basicProfil?.address,
              email: basicProfil?.email,
              phone: basicProfil?.phone,
            ),
          );
        }
      });
      update();
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
      subDistrictName: ccrfProfil?.generalInfo?.subDistrict,
      zipCode: ccrfProfil?.generalInfo?.zipCode,
      provinceName: ccrfProfil?.generalInfo?.province,
    );
    ktp.text = ccrfProfil?.generalInfo?.idCardNumber ?? '';
    phone.text = ccrfProfil?.generalInfo?.phone ?? '';
    whatsapp.text = ccrfProfil?.generalInfo?.secondaryPhone ?? '';
    email.text = ccrfProfil?.generalInfo?.email ?? '';
    update();
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
