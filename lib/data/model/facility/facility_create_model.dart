import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_return_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_tax_info_model.dart';

class FacilityCreateModel {
  String _brand = '';
  String _name = '';
  String _email = '';
  String _jlcNumber = '';
  String _facilityType = '';
  String _termsAndConditions = '';
  FacilityCreateIdCardModel? _idCard;
  FacilityCreateAddressModel? _address;
  FacilityCreateAddressModel? get address => _address;
  FacilityCreateReturnAddress? _returnAddress;
  FacilityCreateTaxInfoModel? _taxInfo;
  FacilityCreateBankInfoModel? _bankInfo;

  setBrand(String brand) {
    _brand = brand;
  }

  setName(String name) {
    _name = name;
  }

  setEmail(String email) {
    _email = email;
  }

  setJlcNumber(String jlcNumber) {
    _jlcNumber = jlcNumber;
  }

  setFacilityType(String facilityType) {
    _facilityType = facilityType;
  }

  String getFacilityType() {
    return _facilityType;
  }

  setTermsAndConditions(String termsAndConditions) {
    _termsAndConditions = termsAndConditions;
  }

  setIdCard(FacilityCreateIdCardModel idCard) {
    _idCard = idCard;
  }

  String getIdCardPath() {
    return _idCard?.imageUrl ?? '';
  }

  setIdCardPath(String path) {
    _idCard?.setImageUrl(path);
  }

  setAddress(FacilityCreateAddressModel address) {
    _address = address;
  }

  setReturnAddress(FacilityCreateReturnAddress returnAddress) {
    _returnAddress = returnAddress;
  }

  setTaxInfo(FacilityCreateTaxInfoModel taxInfo) {
    _taxInfo = taxInfo;
  }

  String getTaxInfoPath() {
    return _taxInfo?.imageUrl ?? '';
  }

  setTaxInfoPath(String path) {
    _taxInfo?.setImageUrl(path);
  }

  setBankInfo(FacilityCreateBankInfoModel bankInfo) {
    _bankInfo = bankInfo;
  }

  setBankInfoPath(String path) {
    _bankInfo?.setAccountImageUrl(path);
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['brand'] = _brand;
    json['name'] = _name;
    json['email'] = _email;
    json['jlcNumber'] = _jlcNumber;
    json['facilityType'] = _facilityType;
    json['termsAndConditions'] = _termsAndConditions;
    json['idCard'] = _idCard?.toJson();
    json['address'] = _address?.toJson();
    json['returnAddress'] = _returnAddress?.toJson();
    json['taxInfo'] = _taxInfo?.toJson();
    json['bankInfo'] = _bankInfo?.toJson();

    return json;
  }
}
