import 'package:css_mobile/data/model/facility/facility_create_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_bank_info_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_id_card_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_return_address_model.dart';
import 'package:css_mobile/data/model/facility/facility_create_tax_info_model.dart';

class FacilityCreateModel {

  String _brand = '';
  String _name = '';
  String _email = '';
  String _facilityType = '';
  String _termsAndConditions = '';
  FacilityCreateIdCardModel? _idCard;
  FacilityCreateAddressModel? _address;
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

  setFacilityType(String facilityType) {
    _facilityType = facilityType;
  }

  setTermsAndConditions(String termsAndConditions) {
    _termsAndConditions = termsAndConditions;
  }

  setIdCard(FacilityCreateIdCardModel idCard) {
    _idCard = idCard;
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

  setBankInfo(FacilityCreateBankInfoModel bankInfo) {
    _bankInfo = bankInfo;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['brand'] = _brand;
    json['name'] = _name;
    json['email'] = _email;
    json['facility_type'] = _facilityType;
    json['terms_and_conditions'] = _termsAndConditions;
    json['id_card'] = _idCard?.toJson();
    json['address'] = _address?.toJson();
    json['return_address'] = _returnAddress?.toJson();
    json['tax_info'] = _taxInfo?.toJson();
    json['bank_info'] = _bankInfo?.toJson();

    return json;
  }

}