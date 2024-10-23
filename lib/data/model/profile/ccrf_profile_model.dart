class CcrfProfileModel {
  CcrfProfileModel({
      GeneralInfo? generalInfo, 
      ReturnAddress? returnAddress, 
      Document? document, 
      BankAccount? bankAccount,}){
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
CcrfProfileModel copyWith({  GeneralInfo? generalInfo,
  ReturnAddress? returnAddress,
  Document? document,
  BankAccount? bankAccount,
}) => CcrfProfileModel(  generalInfo: generalInfo ?? _generalInfo,
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
      String? ccrfAccountnumber,}){
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
BankAccount copyWith({  String? ccrfBankaccount,
  String? ccrfAccountname,
  String? ccrfAccountnumber,
}) => BankAccount(  ccrfBankaccount: ccrfBankaccount ?? _ccrfBankaccount,
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
      String? ccrfAccountattached,}){
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
Document copyWith({  String? ccrfKtpattached,
  String? ccrfNpwpattached,
  String? ccrfAccountattached,
}) => Document(  ccrfKtpattached: ccrfKtpattached ?? _ccrfKtpattached,
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
      String? ccrfNpwpnumber,}){
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
ReturnAddress copyWith({  String? ccrfReturnaddress,
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
}) => ReturnAddress(  ccrfReturnaddress: ccrfReturnaddress ?? _ccrfReturnaddress,
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
  String? get ccrfReturnaddress => _ccrfReturnaddress;
  String? get ccrfReturnprovince => _ccrfReturnprovince;
  String? get ccrfReturncity => _ccrfReturncity;
  String? get ccrfReturndistrict => _ccrfReturndistrict;
  String? get ccrfReturnsubdistrict => _ccrfReturnsubdistrict;
  String? get ccrfReturnzipcode => _ccrfReturnzipcode;
  String? get ccrfReturnphone => _ccrfReturnphone;
  String? get ccrfReturnhandphone => _ccrfReturnhandphone;
  String? get ccrfReturnresponsiblename => _ccrfReturnresponsiblename;
  String? get ccrfJlcnumber => _ccrfJlcnumber;
  String? get ccrfCounter => _ccrfCounter;
  String? get ccrfNpwptype => _ccrfNpwptype;
  String? get ccrfNpwpname => _ccrfNpwpname;
  String? get ccrfNpwpnumber => _ccrfNpwpnumber;

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
      String? ccrfBrand, 
      String? ccrfName, 
      String? ccrfKtp, 
      String? ccrfAddress, 
      String? ccrfCountry, 
      String? ccrfProvince, 
      String? ccrfCity, 
      String? ccrfDistrict, 
      String? ccrfSubdistrict, 
      String? ccrfZipcode, 
      String? ccrfPhone, 
      String? ccrfHandphone, 
      String? ccrfEmail, 
      String? ccrfApistatus,}){
    _ccrfBrand = ccrfBrand;
    _ccrfName = ccrfName;
    _ccrfKtp = ccrfKtp;
    _ccrfAddress = ccrfAddress;
    _ccrfCountry = ccrfCountry;
    _ccrfProvince = ccrfProvince;
    _ccrfCity = ccrfCity;
    _ccrfDistrict = ccrfDistrict;
    _ccrfSubdistrict = ccrfSubdistrict;
    _ccrfZipcode = ccrfZipcode;
    _ccrfPhone = ccrfPhone;
    _ccrfHandphone = ccrfHandphone;
    _ccrfEmail = ccrfEmail;
    _ccrfApistatus = ccrfApistatus;
}

  GeneralInfo.fromJson(dynamic json) {
    _ccrfBrand = json['ccrfBrand'];
    _ccrfName = json['ccrfName'];
    _ccrfKtp = json['ccrfKtp'];
    _ccrfAddress = json['ccrfAddress'];
    _ccrfCountry = json['ccrfCountry'];
    _ccrfProvince = json['ccrfProvince'];
    _ccrfCity = json['ccrfCity'];
    _ccrfDistrict = json['ccrfDistrict'];
    _ccrfSubdistrict = json['ccrfSubdistrict'];
    _ccrfZipcode = json['ccrfZipcode'];
    _ccrfPhone = json['ccrfPhone'];
    _ccrfHandphone = json['ccrfHandphone'];
    _ccrfEmail = json['ccrfEmail'];
    _ccrfApistatus = json['ccrfApistatus'];
  }
  String? _ccrfBrand;
  String? _ccrfName;
  String? _ccrfKtp;
  String? _ccrfAddress;
  String? _ccrfCountry;
  String? _ccrfProvince;
  String? _ccrfCity;
  String? _ccrfDistrict;
  String? _ccrfSubdistrict;
  String? _ccrfZipcode;
  String? _ccrfPhone;
  String? _ccrfHandphone;
  String? _ccrfEmail;
  String? _ccrfApistatus;
GeneralInfo copyWith({  String? ccrfBrand,
  String? ccrfName,
  String? ccrfKtp,
  String? ccrfAddress,
  String? ccrfCountry,
  String? ccrfProvince,
  String? ccrfCity,
  String? ccrfDistrict,
  String? ccrfSubdistrict,
  String? ccrfZipcode,
  String? ccrfPhone,
  String? ccrfHandphone,
  String? ccrfEmail,
  String? ccrfApistatus,
}) => GeneralInfo(  ccrfBrand: ccrfBrand ?? _ccrfBrand,
  ccrfName: ccrfName ?? _ccrfName,
  ccrfKtp: ccrfKtp ?? _ccrfKtp,
  ccrfAddress: ccrfAddress ?? _ccrfAddress,
  ccrfCountry: ccrfCountry ?? _ccrfCountry,
  ccrfProvince: ccrfProvince ?? _ccrfProvince,
  ccrfCity: ccrfCity ?? _ccrfCity,
  ccrfDistrict: ccrfDistrict ?? _ccrfDistrict,
  ccrfSubdistrict: ccrfSubdistrict ?? _ccrfSubdistrict,
  ccrfZipcode: ccrfZipcode ?? _ccrfZipcode,
  ccrfPhone: ccrfPhone ?? _ccrfPhone,
  ccrfHandphone: ccrfHandphone ?? _ccrfHandphone,
  ccrfEmail: ccrfEmail ?? _ccrfEmail,
  ccrfApistatus: ccrfApistatus ?? _ccrfApistatus,
);
  String? get ccrfBrand => _ccrfBrand;
  String? get ccrfName => _ccrfName;
  String? get ccrfKtp => _ccrfKtp;
  String? get ccrfAddress => _ccrfAddress;
  String? get ccrfCountry => _ccrfCountry;
  String? get ccrfProvince => _ccrfProvince;
  String? get ccrfCity => _ccrfCity;
  String? get ccrfDistrict => _ccrfDistrict;
  String? get ccrfSubdistrict => _ccrfSubdistrict;
  String? get ccrfZipcode => _ccrfZipcode;
  String? get ccrfPhone => _ccrfPhone;
  String? get ccrfHandphone => _ccrfHandphone;
  String? get ccrfEmail => _ccrfEmail;
  String? get ccrfApistatus => _ccrfApistatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ccrfBrand'] = _ccrfBrand;
    map['ccrfName'] = _ccrfName;
    map['ccrfKtp'] = _ccrfKtp;
    map['ccrfAddress'] = _ccrfAddress;
    map['ccrfCountry'] = _ccrfCountry;
    map['ccrfProvince'] = _ccrfProvince;
    map['ccrfCity'] = _ccrfCity;
    map['ccrfDistrict'] = _ccrfDistrict;
    map['ccrfSubdistrict'] = _ccrfSubdistrict;
    map['ccrfZipcode'] = _ccrfZipcode;
    map['ccrfPhone'] = _ccrfPhone;
    map['ccrfHandphone'] = _ccrfHandphone;
    map['ccrfEmail'] = _ccrfEmail;
    map['ccrfApistatus'] = _ccrfApistatus;
    return map;
  }

}