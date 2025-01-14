import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/bank/facility_form_bank_controller.dart';
import 'package:css_mobile/screen/profile/profil_menu/facility/form/return/facility_form_return_controller.dart';
import 'package:css_mobile/util/constant.dart';
import 'package:css_mobile/widgets/dialog/default_alert_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pinput.dart';
import 'facility_form_info_state.dart';

class FacilityFormInfoController extends BaseController {
  final state = FacilityFormInfoState();
  final String _facilityType = Get.arguments['facility_type'];

  bool _pickImageFailed = false;

  bool get pickImageFailed => _pickImageFailed;

  set pickImageFailed(bool value) {
    _pickImageFailed = value;
    update();
  }

  bool _isOnline = true;

  bool get isOnline => _isOnline;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getUserProfile()]);
    _checkConnectivity();
  }

  @override
  void onClose() {
    Get.delete<FacilityFormInfoController>();
    Get.delete<FacilityFormReturnController>(force: true);
    Get.delete<FacilityFormBankController>(force: true);
    super.onClose();
  }

  Future<void> _getUserProfile() async {
    await profil.getBasicProfil().then((result) {
      if (result.code == HttpStatus.ok) {
        var payload = result.data?.user;
        state.brand.setText(payload?.brand ?? '');
        state.fullName.setText(payload?.name ?? '');
        state.whatsAppPhone.setText(payload?.phone ?? '');
        state.email.setText(payload?.email ?? '');
      }
    });
  }

  void _checkConnectivity() {
    connection.checkConnection();

    (Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      connection.isOnline().then((value) {
        _isOnline = value && (result != ConnectivityResult.none);
        update();
      });
    }));
  }

  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    final imageNotNull = image != null;

    if (imageNotNull) {
      final imageSizeApproved = await image.length() <= Constant.maxImageLength;

      if (imageSizeApproved) {
        state.pickedImageUrl = image.path;
      } else {
        Get.dialog(DefaultAlertDialog(
          title: 'Gagal mengambil gambar.'.tr,
          subtitle:
              'Periksa kembali file gambar KTP. File gambar tidak boleh kosong atau lebih dari 2MB'
                  .tr,
          confirmButtonTitle: 'OK'.tr,
          onConfirm: () => onRefreshUploadState(),
        ));
      }

      update();
    }
  }

  void onRefreshUploadState() {
    _pickImageFailed = false;
    update();
  }

  Future<List<Destination>> getDestinationList(String keyword) async {
    state.isLoading = true;
    state.destinationList.clear();

    var response =
        await master.getDestinations(QueryModel(search: keyword.toUpperCase()));
    var models = response.data?.toList();

    state.isLoading = false;
    update();

    return models ?? List.empty();
  }

  Future<String> getJlcAccount() async {
    var response = await master.getAccounts(QueryModel(where: [
      {'accountService': 'JLC'},
    ], limit: 1));
    return response.data?.first.accountNumber ?? '';
  }

  Future<FacilityCreateModel> submitData() async {
    state.requestData.setBrand(state.brand.text);
    state.requestData.setName(state.fullName.text);
    state.requestData.setJlcNumber(await getJlcAccount());
    state.requestData.setEmail(state.email.text);
    state.requestData.setFacilityType(_facilityType);

    final FacilityCreateIdCardModel idCard = FacilityCreateIdCardModel();
    idCard.setNumber(state.idCardNumber.text);
    idCard.setImageUrl(state.pickedImageUrl ?? "");
    state.requestData.setIdCard(idCard);

    final FacilityCreateAddressModel address = FacilityCreateAddressModel();
    address.setAddress(state.fullAddress.text);
    address.setCountry(state.selectedDestination!.countryName!);
    address.setProvince(state.selectedDestination!.provinceName!);
    address.setCity(state.selectedDestination!.cityName!);
    address.setDistrict(state.selectedDestination!.districtName!);
    address.setSubDistrict(state.selectedDestination!.subdistrictName!);
    address.setZipCode(state.selectedDestination!.zipCode!);
    address.setPhone(state.phone.text);
    address.setHandPhone(state.whatsAppPhone.text);
    state.requestData.setAddress(address);

    return state.requestData;
  }
}
