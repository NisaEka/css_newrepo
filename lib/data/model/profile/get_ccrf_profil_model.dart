class GetCcrfProfilModel {
  GetCcrfProfilModel({
    num? code,
    String? message,
    CcrfProfilModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetCcrfProfilModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? CcrfProfilModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  CcrfProfilModel? _payload;

  GetCcrfProfilModel copyWith({
    num? code,
    String? message,
    CcrfProfilModel? payload,
  }) =>
      GetCcrfProfilModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  CcrfProfilModel? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

class CcrfProfilModel {
  CcrfProfilModel({
    GeneralInfo? generalInfo,
    ReturnAddress? returnAddress,
    BankAccount? bankAccount,
    Document? document,
  }) {
    _generalInfo = generalInfo;
    _returnAddress = returnAddress;
    _bankAccount = bankAccount;
    _document = document;
  }

  CcrfProfilModel.fromJson(dynamic json) {
    _generalInfo = json['general_info'] != null ? GeneralInfo.fromJson(json['general_info']) : null;
    _returnAddress = json['return_address'] != null ? ReturnAddress.fromJson(json['return_address']) : null;
    _bankAccount = json['bank_account'] != null ? BankAccount.fromJson(json['bank_account']) : null;
    _document = json['document'] != null ? Document.fromJson(json['document']) : null;
  }

  GeneralInfo? _generalInfo;
  ReturnAddress? _returnAddress;
  BankAccount? _bankAccount;
  Document? _document;

  CcrfProfilModel copyWith({
    GeneralInfo? generalInfo,
    ReturnAddress? returnAddress,
    BankAccount? bankAccount,
    Document? document,
  }) =>
      CcrfProfilModel(
        generalInfo: generalInfo ?? _generalInfo,
        returnAddress: returnAddress ?? _returnAddress,
        bankAccount: bankAccount ?? _bankAccount,
        document: document ?? _document,
      );

  GeneralInfo? get generalInfo => _generalInfo;

  ReturnAddress? get returnAddress => _returnAddress;

  BankAccount? get bankAccount => _bankAccount;

  Document? get document => _document;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_generalInfo != null) {
      map['general_info'] = _generalInfo?.toJson();
    }
    if (_returnAddress != null) {
      map['return_address'] = _returnAddress?.toJson();
    }
    if (_bankAccount != null) {
      map['bank_account'] = _bankAccount?.toJson();
    }
    if (_document != null) {
      map['document'] = _document?.toJson();
    }
    return map;
  }
}

class Document {
  Document({
    String? idCard,
    String? npwp,
    String? bankAccount,
  }) {
    _idCard = idCard;
    _npwp = npwp;
    _bankAccount = bankAccount;
  }

  Document.fromJson(dynamic json) {
    _idCard = json['id_card'];
    _npwp = json['npwp'];
    _bankAccount = json['bank_account'];
  }

  String? _idCard;
  String? _npwp;
  String? _bankAccount;

  Document copyWith({
    String? idCard,
    String? npwp,
    String? bankAccount,
  }) =>
      Document(
        idCard: idCard ?? _idCard,
        npwp: npwp ?? _npwp,
        bankAccount: bankAccount ?? _bankAccount,
      );

  String? get idCard => _idCard;

  String? get npwp => _npwp;

  String? get bankAccount => _bankAccount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id_card'] = _idCard;
    map['npwp'] = _npwp;
    map['bank_account'] = _bankAccount;
    return map;
  }
}

class BankAccount {
  BankAccount({
    String? account,
    String? accountNumber,
    String? accountName,
  }) {
    _account = account;
    _accountNumber = accountNumber;
    _accountName = accountName;
  }

  BankAccount.fromJson(dynamic json) {
    _account = json['account'];
    _accountNumber = json['account_number'];
    _accountName = json['account_name'];
  }

  String? _account;
  String? _accountNumber;
  String? _accountName;

  BankAccount copyWith({
    String? account,
    String? accountNumber,
    String? accountName,
  }) =>
      BankAccount(
        account: account ?? _account,
        accountNumber: accountNumber ?? _accountNumber,
        accountName: accountName ?? _accountName,
      );

  String? get account => _account;

  String? get accountNumber => _accountNumber;

  String? get accountName => _accountName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account'] = _account;
    map['account_number'] = _accountNumber;
    map['account_name'] = _accountName;
    return map;
  }
}

class ReturnAddress {
  ReturnAddress({
    String? address,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondaryPhone,
    String? responsibleName,
    String? jlcNumber,
    String? counter,
    String? npwpType,
    dynamic npwpName,
    dynamic npwpNumber,
  }) {
    _address = address;
    _province = province;
    _city = city;
    _district = district;
    _subDistrict = subDistrict;
    _zipCode = zipCode;
    _phone = phone;
    _secondaryPhone = secondaryPhone;
    _responsibleName = responsibleName;
    _jlcNumber = jlcNumber;
    _counter = counter;
    _npwpType = npwpType;
    _npwpName = npwpName;
    _npwpNumber = npwpNumber;
  }

  ReturnAddress.fromJson(dynamic json) {
    _address = json['address'];
    _province = json['province'];
    _city = json['city'];
    _district = json['district'];
    _subDistrict = json['sub_district'];
    _zipCode = json['zip_code'];
    _phone = json['phone'];
    _secondaryPhone = json['secondary_phone'];
    _responsibleName = json['responsible_name'];
    _jlcNumber = json['jlc_number'];
    _counter = json['counter'];
    _npwpType = json['npwpType'];
    _npwpName = json['npwpName'];
    _npwpNumber = json['npwpNumber'];
  }

  String? _address;
  String? _province;
  String? _city;
  String? _district;
  String? _subDistrict;
  String? _zipCode;
  String? _phone;
  String? _secondaryPhone;
  String? _responsibleName;
  String? _jlcNumber;
  String? _counter;
  String? _npwpType;
  dynamic _npwpName;
  dynamic _npwpNumber;

  ReturnAddress copyWith({
    String? address,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondaryPhone,
    String? responsibleName,
    String? jlcNumber,
    String? counter,
    String? npwpType,
    dynamic npwpName,
    dynamic npwpNumber,
  }) =>
      ReturnAddress(
        address: address ?? _address,
        province: province ?? _province,
        city: city ?? _city,
        district: district ?? _district,
        subDistrict: subDistrict ?? _subDistrict,
        zipCode: zipCode ?? _zipCode,
        phone: phone ?? _phone,
        secondaryPhone: secondaryPhone ?? _secondaryPhone,
        responsibleName: responsibleName ?? _responsibleName,
        jlcNumber: jlcNumber ?? _jlcNumber,
        counter: counter ?? _counter,
        npwpType: npwpType ?? _npwpType,
        npwpName: npwpName ?? _npwpName,
        npwpNumber: npwpNumber ?? _npwpNumber,
      );

  String? get address => _address;

  String? get province => _province;

  String? get city => _city;

  String? get district => _district;

  String? get subDistrict => _subDistrict;

  String? get zipCode => _zipCode;

  String? get phone => _phone;

  String? get secondaryPhone => _secondaryPhone;

  String? get responsibleName => _responsibleName;

  String? get jlcNumber => _jlcNumber;

  String? get counter => _counter;

  String? get npwpType => _npwpType;

  dynamic get npwpName => _npwpName;

  dynamic get npwpNumber => _npwpNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address'] = _address;
    map['province'] = _province;
    map['city'] = _city;
    map['district'] = _district;
    map['sub_district'] = _subDistrict;
    map['zip_code'] = _zipCode;
    map['phone'] = _phone;
    map['secondary_phone'] = _secondaryPhone;
    map['responsible_name'] = _responsibleName;
    map['jlc_number'] = _jlcNumber;
    map['counter'] = _counter;
    map['npwpType'] = _npwpType;
    map['npwpName'] = _npwpName;
    map['npwpNumber'] = _npwpNumber;
    return map;
  }
}

class GeneralInfo {
  GeneralInfo({
    String?brand,
    String? name,
    String? idCardNumber,
    String? address,
    String? country,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondaryPhone,
    String? email,
    String? apiStatus,
  }) {
    _brand = brand;
    _name = name;
    _idCardNumber = idCardNumber;
    _address = address;
    _country = country;
    _province = province;
    _city = city;
    _district = district;
    _subDistrict = subDistrict;
    _zipCode = zipCode;
    _phone = phone;
    _secondaryPhone = secondaryPhone;
    _email = email;
    _apiStatus = apiStatus;
  }

  GeneralInfo.fromJson(dynamic json) {
    _brand = json['brand'];
    _name = json['name'];
    _idCardNumber = json['id_card_number'];
    _address = json['address'];
    _country = json['country'];
    _province = json['province'];
    _city = json['city'];
    _district = json['district'];
    _subDistrict = json['sub_district'];
    _zipCode = json['zip_code'];
    _phone = json['phone'];
    _secondaryPhone = json['secondary_phone'];
    _email = json['email'];
    _apiStatus = json['api_status'];
  }

  String? _brand;
  String? _name;
  String? _idCardNumber;
  String? _address;
  String? _country;
  String? _province;
  String? _city;
  String? _district;
  String? _subDistrict;
  String? _zipCode;
  String? _phone;
  String? _secondaryPhone;
  String? _email;
  String? _apiStatus;

  GeneralInfo copyWith({
    String? brand,
    String? name,
    String? idCardNumber,
    String? address,
    String? country,
    String? province,
    String? city,
    String? district,
    String? subDistrict,
    String? zipCode,
    String? phone,
    String? secondaryPhone,
    String? email,
    String? apiStatus,
  }) =>
      GeneralInfo(
        brand: brand ?? _brand,
        name: name ?? _name,
        idCardNumber: idCardNumber ?? _idCardNumber,
        address: address ?? _address,
        country: country ?? _country,
        province: province ?? _province,
        city: city ?? _city,
        district: district ?? _district,
        subDistrict: subDistrict ?? _subDistrict,
        zipCode: zipCode ?? _zipCode,
        phone: phone ?? _phone,
        secondaryPhone: secondaryPhone ?? _secondaryPhone,
        email: email ?? _email,
        apiStatus: apiStatus ?? _apiStatus,
      );

  String? get brand => _brand;

  String? get name => _name;

  String? get idCardNumber => _idCardNumber;

  String? get address => _address;

  String? get country => _country;

  String? get province => _province;

  String? get city => _city;

  String? get district => _district;

  String? get subDistrict => _subDistrict;

  String? get zipCode => _zipCode;

  String? get phone => _phone;

  String? get secondaryPhone => _secondaryPhone;

  String? get email => _email;

  String? get apiStatus => _apiStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['brand'] = _brand;
    map['name'] = _name;
    map['id_card_number'] = _idCardNumber;
    map['address'] = _address;
    map['country'] = _country;
    map['province'] = _province;
    map['city'] = _city;
    map['district'] = _district;
    map['sub_district'] = _subDistrict;
    map['zip_code'] = _zipCode;
    map['phone'] = _phone;
    map['secondary_phone'] = _secondaryPhone;
    map['email'] = _email;
    map['api_status'] = _apiStatus;
    return map;
  }
}
