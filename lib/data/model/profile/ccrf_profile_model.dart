class CcrfProfileModel {
  CcrfProfileModel({
    GeneralInfo? generalInfo,
    ReturnAddress? returnAddress,
    Document? document,
    BankAccount? bankAccount,
  }) {
    _generalInfo = generalInfo;
    _returnAddress = returnAddress;
    _document = document;
    _bankAccount = bankAccount;
  }

  CcrfProfileModel.fromJson(dynamic json) {
    _generalInfo = json['generalInfo'] != null ? GeneralInfo.fromJson(json['generalInfo']) : null;
    _returnAddress = json['returnAddress'] != null ? ReturnAddress.fromJson(json['returnAddress']) : null;
    _document = json['document'] != null ? Document.fromJson(json['document']) : null;
    _bankAccount = json['bankAccount'] != null ? BankAccount.fromJson(json['bankAccount']) : null;
  }

  GeneralInfo? _generalInfo;
  ReturnAddress? _returnAddress;
  Document? _document;
  BankAccount? _bankAccount;

  CcrfProfileModel copyWith({
    GeneralInfo? generalInfo,
    ReturnAddress? returnAddress,
    Document? document,
    BankAccount? bankAccount,
  }) =>
      CcrfProfileModel(
        generalInfo: generalInfo ?? _generalInfo,
        returnAddress: returnAddress ?? _returnAddress,
        document: document ?? _document,
        bankAccount: bankAccount ?? _bankAccount,
      );

  GeneralInfo? get generalInfo => _generalInfo;

  ReturnAddress? get returnAddress => _returnAddress;

  Document? get document => _document;

  BankAccount? get bankAccount => _bankAccount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalInfo != null) {
      map['generalInfo'] = _generalInfo?.toJson();
    }
    if (_returnAddress != null) {
      map['returnAddress'] = _returnAddress?.toJson();
    }
    if (_document != null) {
      map['document'] = _document?.toJson();
    }
    if (_bankAccount != null) {
      map['bankAccount'] = _bankAccount?.toJson();
    }
    return map;
  }
}

class BankAccount {
  BankAccount({
    String? ccrfBankaccount,
    String? ccrfAccountname,
    String? ccrfAccountnumber,
  }) {
    _ccrfBankaccount = ccrfBankaccount;
    _ccrfAccountname = ccrfAccountname;
    _ccrfAccountnumber = ccrfAccountnumber;
  }

  BankAccount.fromJson(dynamic json) {
    _ccrfBankaccount = json['ccrfBankaccount'];
    _ccrfAccountname = json['ccrfAccountname'];
    _ccrfAccountnumber = json['ccrfAccountnumber'];
  }

  String? _ccrfBankaccount;
  String? _ccrfAccountname;
  String? _ccrfAccountnumber;

  BankAccount copyWith({
    String? ccrfBankaccount,
    String? ccrfAccountname,
    String? ccrfAccountnumber,
  }) =>
      BankAccount(
        ccrfBankaccount: ccrfBankaccount ?? _ccrfBankaccount,
        ccrfAccountname: ccrfAccountname ?? _ccrfAccountname,
        ccrfAccountnumber: ccrfAccountnumber ?? _ccrfAccountnumber,
      );

  String? get ccrfBankaccount => _ccrfBankaccount;

  String? get ccrfAccountname => _ccrfAccountname;

  String? get ccrfAccountnumber => _ccrfAccountnumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ccrfBankaccount'] = _ccrfBankaccount;
    map['ccrfAccountname'] = _ccrfAccountname;
    map['ccrfAccountnumber'] = _ccrfAccountnumber;
    return map;
  }
}

class Document {
  Document({
    String? ccrfKtpattached,
    String? ccrfNpwpattached,
    String? ccrfAccountattached,
  }) {
    _ccrfKtpattached = ccrfKtpattached;
    _ccrfNpwpattached = ccrfNpwpattached;
    _ccrfAccountattached = ccrfAccountattached;
  }

  Document.fromJson(dynamic json) {
    _ccrfKtpattached = json['ccrfKtpattached'];
    _ccrfNpwpattached = json['ccrfNpwpattached'];
    _ccrfAccountattached = json['ccrfAccountattached'];
  }

  String? _ccrfKtpattached;
  String? _ccrfNpwpattached;
  String? _ccrfAccountattached;

  Document copyWith({
    String? ccrfKtpattached,
    String? ccrfNpwpattached,
    String? ccrfAccountattached,
  }) =>
      Document(
        ccrfKtpattached: ccrfKtpattached ?? _ccrfKtpattached,
        ccrfNpwpattached: ccrfNpwpattached ?? _ccrfNpwpattached,
        ccrfAccountattached: ccrfAccountattached ?? _ccrfAccountattached,
      );

  String? get ccrfKtpattached => _ccrfKtpattached;

  String? get ccrfNpwpattached => _ccrfNpwpattached;

  String? get ccrfAccountattached => _ccrfAccountattached;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ccrfKtpattached'] = _ccrfKtpattached;
    map['ccrfNpwpattached'] = _ccrfNpwpattached;
    map['ccrfAccountattached'] = _ccrfAccountattached;
    return map;
  }
}

class ReturnAddress {
  ReturnAddress({
    String? ccrfReturnaddress,
    String? ccrfReturnprovince,
    String? ccrfReturncity,
    String? ccrfReturndistrict,
    String? ccrfReturnsubdistrict,
    String? ccrfReturnzipcode,
    String? ccrfReturnphone,
    String? ccrfReturnhandphone,
    String? ccrfReturnresponsiblename,
    String? ccrfJlcnumber,
    String? ccrfCounter,
    String? ccrfNpwptype,
    String? ccrfNpwpname,
    String? ccrfNpwpnumber,
  }) {
    _ccrfReturnaddress = ccrfReturnaddress;
    _ccrfReturnprovince = ccrfReturnprovince;
    _ccrfReturncity = ccrfReturncity;
    _ccrfReturndistrict = ccrfReturndistrict;
    _ccrfReturnsubdistrict = ccrfReturnsubdistrict;
    _ccrfReturnzipcode = ccrfReturnzipcode;
    _ccrfReturnphone = ccrfReturnphone;
    _ccrfReturnhandphone = ccrfReturnhandphone;
    _ccrfReturnresponsiblename = ccrfReturnresponsiblename;
    _ccrfJlcnumber = ccrfJlcnumber;
    _ccrfCounter = ccrfCounter;
    _ccrfNpwptype = ccrfNpwptype;
    _ccrfNpwpname = ccrfNpwpname;
    _ccrfNpwpnumber = ccrfNpwpnumber;
  }

  ReturnAddress.fromJson(dynamic json) {
    _ccrfReturnaddress = json['ccrfReturnaddress'];
    _ccrfReturnprovince = json['ccrfReturnprovince'];
    _ccrfReturncity = json['ccrfReturncity'];
    _ccrfReturndistrict = json['ccrfReturndistrict'];
    _ccrfReturnsubdistrict = json['ccrfReturnsubdistrict'];
    _ccrfReturnzipcode = json['ccrfReturnzipcode'];
    _ccrfReturnphone = json['ccrfReturnphone'];
    _ccrfReturnhandphone = json['ccrfReturnhandphone'];
    _ccrfReturnresponsiblename = json['ccrfReturnresponsiblename'];
    _ccrfJlcnumber = json['ccrfJlcnumber'];
    _ccrfCounter = json['ccrfCounter'];
    _ccrfNpwptype = json['ccrfNpwptype'];
    _ccrfNpwpname = json['ccrfNpwpname'];
    _ccrfNpwpnumber = json['ccrfNpwpnumber'];
  }

  String? _ccrfReturnaddress;
  String? _ccrfReturnprovince;
  String? _ccrfReturncity;
  String? _ccrfReturndistrict;
  String? _ccrfReturnsubdistrict;
  String? _ccrfReturnzipcode;
  String? _ccrfReturnphone;
  String? _ccrfReturnhandphone;
  String? _ccrfReturnresponsiblename;
  String? _ccrfJlcnumber;
  String? _ccrfCounter;
  String? _ccrfNpwptype;
  String? _ccrfNpwpname;
  String? _ccrfNpwpnumber;

  ReturnAddress copyWith({
    String? ccrfReturnaddress,
    String? ccrfReturnprovince,
    String? ccrfReturncity,
    String? ccrfReturndistrict,
    String? ccrfReturnsubdistrict,
    String? ccrfReturnzipcode,
    String? ccrfReturnphone,
    String? ccrfReturnhandphone,
    String? ccrfReturnresponsiblename,
    String? ccrfJlcnumber,
    String? ccrfCounter,
    String? ccrfNpwptype,
    String? ccrfNpwpname,
    String? ccrfNpwpnumber,
  }) =>
      ReturnAddress(
        ccrfReturnaddress: ccrfReturnaddress ?? _ccrfReturnaddress,
        ccrfReturnprovince: ccrfReturnprovince ?? _ccrfReturnprovince,
        ccrfReturncity: ccrfReturncity ?? _ccrfReturncity,
        ccrfReturndistrict: ccrfReturndistrict ?? _ccrfReturndistrict,
        ccrfReturnsubdistrict: ccrfReturnsubdistrict ?? _ccrfReturnsubdistrict,
        ccrfReturnzipcode: ccrfReturnzipcode ?? _ccrfReturnzipcode,
        ccrfReturnphone: ccrfReturnphone ?? _ccrfReturnphone,
        ccrfReturnhandphone: ccrfReturnhandphone ?? _ccrfReturnhandphone,
        ccrfReturnresponsiblename: ccrfReturnresponsiblename ?? _ccrfReturnresponsiblename,
        ccrfJlcnumber: ccrfJlcnumber ?? _ccrfJlcnumber,
        ccrfCounter: ccrfCounter ?? _ccrfCounter,
        ccrfNpwptype: ccrfNpwptype ?? _ccrfNpwptype,
        ccrfNpwpname: ccrfNpwpname ?? _ccrfNpwpname,
        ccrfNpwpnumber: ccrfNpwpnumber ?? _ccrfNpwpnumber,
      );

  String? get address => _ccrfReturnaddress;

  String? get province => _ccrfReturnprovince;

  String? get city => _ccrfReturncity;

  String? get district => _ccrfReturndistrict;

  String? get subDistrict => _ccrfReturnsubdistrict;

  String? get zipCode => _ccrfReturnzipcode;

  String? get phone => _ccrfReturnphone;

  String? get secondPhone => _ccrfReturnhandphone;

  String? get responsibleName => _ccrfReturnresponsiblename;

  String? get jlcNumber => _ccrfJlcnumber;

  String? get counter => _ccrfCounter;

  String? get npwpType => _ccrfNpwptype;

  String? get npwpName => _ccrfNpwpname;

  String? get npwpNumber => _ccrfNpwpnumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ccrfReturnaddress'] = _ccrfReturnaddress;
    map['ccrfReturnprovince'] = _ccrfReturnprovince;
    map['ccrfReturncity'] = _ccrfReturncity;
    map['ccrfReturndistrict'] = _ccrfReturndistrict;
    map['ccrfReturnsubdistrict'] = _ccrfReturnsubdistrict;
    map['ccrfReturnzipcode'] = _ccrfReturnzipcode;
    map['ccrfReturnphone'] = _ccrfReturnphone;
    map['ccrfReturnhandphone'] = _ccrfReturnhandphone;
    map['ccrfReturnresponsiblename'] = _ccrfReturnresponsiblename;
    map['ccrfJlcnumber'] = _ccrfJlcnumber;
    map['ccrfCounter'] = _ccrfCounter;
    map['ccrfNpwptype'] = _ccrfNpwptype;
    map['ccrfNpwpname'] = _ccrfNpwpname;
    map['ccrfNpwpnumber'] = _ccrfNpwpnumber;
    return map;
  }
}

class GeneralInfo {
  GeneralInfo({
    String? brand,
    String? name,
    String? ktp,
    String? address,
    String? country,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondPhone,
    String? email,
    String? apiStatus,
  }) {
    _brand = brand;
    _name = name;
    _ktp = ktp;
    _address = address;
    _country = country;
    _province = province;
    _city = city;
    _district = district;
    _subDistrict = subDistrict;
    _zipCode = zipCode;
    _phone = phone;
    _secondPhone = secondPhone;
    _email = email;
    _apiStatus = apiStatus;
  }

  GeneralInfo.fromJson(dynamic json) {
    _brand = json['ccrfBrand'] ?? json['brand'];
    _name = json['ccrfName'] ?? json['name'];
    _ktp = json['ccrfKtp'];
    _address = json['ccrfAddress'] ?? json['address'];
    _country = json['ccrfCountry'] ?? json['country'];
    _province = json['ccrfProvince'] ?? json['province'];
    _city = json['ccrfCity'] ?? json['city'];
    _district = json['ccrfDistrict'] ?? json['district'];
    _subDistrict = json['ccrfSubdistrict'] ?? json['subDistrict'];
    _zipCode = json['ccrfZipcode'] ?? json['zipCode'];
    _zipCode = json['ccrfZipcode'] ?? json['zipCode'];
    _phone = json['ccrfPhone'];
    _secondPhone = json['ccrfHandphone'];
    _email = json['ccrfEmail'];
    _apiStatus = json['ccrfApistatus'];
  }

  String? _brand;
  String? _name;
  String? _ktp;
  String? _address;
  String? _country;
  String? _province;
  String? _city;
  String? _district;
  String? _subDistrict;
  String? _zipCode;
  String? _phone;
  String? _secondPhone;
  String? _email;
  String? _apiStatus;

  GeneralInfo copyWith({
    String? brand,
    String? name,
    String? ktp,
    String? address,
    String? country,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondPhone,
    String? email,
    String? apiStatus,
  }) =>
      GeneralInfo(
        brand: brand ?? _brand,
        name: name ?? _name,
        ktp: ktp ?? _ktp,
        address: address ?? _address,
        country: country ?? _country,
        province: province ?? _province,
        city: city ?? _city,
        district: district ?? _district,
        subDistrict: subDistrict ?? _subDistrict,
        zipCode: zipCode ?? _zipCode,
        phone: phone ?? _phone,
        secondPhone: secondPhone ?? _secondPhone,
        email: email ?? _email,
        apiStatus: apiStatus ?? _apiStatus,
      );

  String? get brand => _brand;

  String? get name => _name;

  String? get ktp => _ktp;

  String? get address => _address;

  String? get country => _country;

  String? get province => _province;

  String? get city => _city;

  String? get district => _district;

  String? get subDistrict => _subDistrict;

  String? get zipCode => _zipCode;

  String? get phone => _phone;

  String? get secondPhone => _secondPhone;

  String? get email => _email;

  String? get apiStatus => _apiStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ccrfBrand'] = _brand;
    map['brand'] = _brand;
    map['ccrfName'] = _name;
    map['name'] = _name;
    map['ccrfKtp'] = _ktp;
    map['address'] = _address;
    map['ccrfAddress'] = _address;
    map['ccrfCountry'] = _country;
    map['country'] = _country;
    map['ccrfProvince'] = _province;
    map['province'] = _province;
    map['ccrfCity'] = _city;
    map['city'] = _city;
    map['ccrfDistrict'] = _district;
    map['district'] = _district;
    map['ccrfSubdistrict'] = _subDistrict;
    map['subDistrict'] = _subDistrict;
    map['ccrfZipcode'] = _zipCode;
    map['zipCode'] = _zipCode;
    map['ccrfPhone'] = _phone;
    map['ccrfHandphone'] = _secondPhone;
    map['ccrfEmail'] = _email;
    map['ccrfApistatus'] = _apiStatus;
    return map;
  }
}
