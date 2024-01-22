import 'dart:convert';
TransactionDataModel transactionDataModelFromJson(String str) => TransactionDataModel.fromJson(json.decode(str));
String transactionDataModelToJson(TransactionDataModel data) => json.encode(data.toJson());
class TransactionDataModel {
  TransactionDataModel({
    Delivery? delivery,
    Account? account,
    Origin? origin,
    Destination? destination,
    Goods? goods,
    Shipper? shipper,
    Receiver? receiver,}) {
    _delivery = delivery;
    _account = account;
    _origin = origin;
    _destination = destination;
    _goods = goods;
    _shipper = shipper;
    _receiver = receiver;
  }

  TransactionDataModel.fromJson(dynamic json) {
    _delivery = json['delivery'] != null ? Delivery.fromJson(json['delivery']) : null;
    _account = json['account'] != null ? Account.fromJson(json['account']) : null;
    _origin = json['origin'] != null ? Origin.fromJson(json['origin']) : null;
    _destination = json['destination'] != null ? Destination.fromJson(json['destination']) : null;
    _goods = json['goods'] != null ? Goods.fromJson(json['goods']) : null;
    _shipper = json['shipper'] != null ? Shipper.fromJson(json['shipper']) : null;
    _receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
  }
  Delivery? _delivery;
  Account? _account;
  Origin? _origin;
  Destination? _destination;
  Goods? _goods;
  Shipper? _shipper;
  Receiver? _receiver;

  TransactionDataModel copyWith({ Delivery? delivery,
    Account? account,
    Origin? origin,
    Destination? destination,
    Goods? goods,
    Shipper? shipper,
    Receiver? receiver,
  }) =>
      TransactionDataModel(
        delivery: delivery ?? _delivery,
        account: account ?? _account,
        origin: origin ?? _origin,
        destination: destination ?? _destination,
        goods: goods ?? _goods,
        shipper: shipper ?? _shipper,
        receiver: receiver ?? _receiver,
      );
  Delivery? get delivery => _delivery;
  Account? get account => _account;
  Origin? get origin => _origin;
  Destination? get destination => _destination;
  Goods? get goods => _goods;
  Shipper? get shipper => _shipper;
  Receiver? get receiver => _receiver;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_delivery != null) {
      map['delivery'] = _delivery?.toJson();
    }
    if (_account != null) {
      map['account'] = _account?.toJson();
    }
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    if (_destination != null) {
      map['destination'] = _destination?.toJson();
    }
    if (_goods != null) {
      map['goods'] = _goods?.toJson();
    }
    if (_shipper != null) {
      map['shipper'] = _shipper?.toJson();
    }
    if (_receiver != null) {
      map['receiver'] = _receiver?.toJson();
    }
    return map;
  }

}

Receiver receiverFromJson(String str) => Receiver.fromJson(json.decode(str));
String receiverToJson(Receiver data) => json.encode(data.toJson());
class Receiver {
  Receiver({
    String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zip,
    String? region,
    String? country,
    String? contact,
    String? phone,
    String? district,
    String? subDistrict,}) {
    _name = name;
    _address = address;
    _address1 = address1;
    _address2 = address2;
    _address3 = address3;
    _city = city;
    _zip = zip;
    _region = region;
    _country = country;
    _contact = contact;
    _phone = phone;
    _district = district;
    _subDistrict = subDistrict;
  }

  Receiver.fromJson(dynamic json) {
    _name = json['name'];
    _address = json['address'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _address3 = json['address3'];
    _city = json['city'];
    _zip = json['zip'];
    _region = json['region'];
    _country = json['country'];
    _contact = json['contact'];
    _phone = json['phone'];
    _district = json['district'];
    _subDistrict = json['sub_district'];
  }
  String? _name;
  String? _address;
  String? _address1;
  String? _address2;
  String? _address3;
  String? _city;
  String? _zip;
  String? _region;
  String? _country;
  String? _contact;
  String? _phone;
  String? _district;
  String? _subDistrict;

  Receiver copyWith({ String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zip,
    String? region,
    String? country,
    String? contact,
    String? phone,
    String? district,
    String? subDistrict,
  }) =>
      Receiver(
        name: name ?? _name,
        address: address ?? _address,
        address1: address1 ?? _address1,
        address2: address2 ?? _address2,
        address3: address3 ?? _address3,
        city: city ?? _city,
        zip: zip ?? _zip,
        region: region ?? _region,
        country: country ?? _country,
        contact: contact ?? _contact,
        phone: phone ?? _phone,
        district: district ?? _district,
        subDistrict: subDistrict ?? _subDistrict,
      );
  String? get name => _name;
  String? get address => _address;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get address3 => _address3;
  String? get city => _city;
  String? get zip => _zip;
  String? get region => _region;
  String? get country => _country;
  String? get contact => _contact;
  String? get phone => _phone;
  String? get district => _district;
  String? get subDistrict => _subDistrict;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['address'] = _address;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['address3'] = _address3;
    map['city'] = _city;
    map['zip'] = _zip;
    map['region'] = _region;
    map['country'] = _country;
    map['contact'] = _contact;
    map['phone'] = _phone;
    map['district'] = _district;
    map['sub_district'] = _subDistrict;
    return map;
  }

}

Shipper shipperFromJson(String str) => Shipper.fromJson(json.decode(str));
String shipperToJson(Shipper data) => json.encode(data.toJson());
class Shipper {
  Shipper({
    String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zip,
    String? region,
    String? country,
    String? contact,
    String? phone,}) {
    _name = name;
    _address = address;
    _address1 = address1;
    _address2 = address2;
    _address3 = address3;
    _city = city;
    _zip = zip;
    _region = region;
    _country = country;
    _contact = contact;
    _phone = phone;
  }

  Shipper.fromJson(dynamic json) {
    _name = json['name'];
    _address = json['address'];
    _address1 = json['address1'];
    _address2 = json['address2'];
    _address3 = json['address3'];
    _city = json['city'];
    _zip = json['zip'];
    _region = json['region'];
    _country = json['country'];
    _contact = json['contact'];
    _phone = json['phone'];
  }
  String? _name;
  String? _address;
  String? _address1;
  String? _address2;
  String? _address3;
  String? _city;
  String? _zip;
  String? _region;
  String? _country;
  String? _contact;
  String? _phone;

  Shipper copyWith({ String? name,
    String? address,
    String? address1,
    String? address2,
    String? address3,
    String? city,
    String? zip,
    String? region,
    String? country,
    String? contact,
    String? phone,
  }) =>
      Shipper(
        name: name ?? _name,
        address: address ?? _address,
        address1: address1 ?? _address1,
        address2: address2 ?? _address2,
        address3: address3 ?? _address3,
        city: city ?? _city,
        zip: zip ?? _zip,
        region: region ?? _region,
        country: country ?? _country,
        contact: contact ?? _contact,
        phone: phone ?? _phone,
      );
  String? get name => _name;
  String? get address => _address;
  String? get address1 => _address1;
  String? get address2 => _address2;
  String? get address3 => _address3;
  String? get city => _city;
  String? get zip => _zip;
  String? get region => _region;
  String? get country => _country;
  String? get contact => _contact;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['address'] = _address;
    map['address1'] = _address1;
    map['address2'] = _address2;
    map['address3'] = _address3;
    map['city'] = _city;
    map['zip'] = _zip;
    map['region'] = _region;
    map['country'] = _country;
    map['contact'] = _contact;
    map['phone'] = _phone;
    return map;
  }

}

Goods goodsFromJson(String str) => Goods.fromJson(json.decode(str));
String goodsToJson(Goods data) => json.encode(data.toJson());
class Goods {
  Goods({
    String? type,
    String? desc,
    num? amount,
    num? quantity,
    num? weight,}) {
    _type = type;
    _desc = desc;
    _amount = amount;
    _quantity = quantity;
    _weight = weight;
  }

  Goods.fromJson(dynamic json) {
    _type = json['type'];
    _desc = json['desc'];
    _amount = json['amount'];
    _quantity = json['quantity'];
    _weight = json['weight'];
  }

  String? _type;
  String? _desc;
  num? _amount;
  num? _quantity;
  num? _weight;

  Goods copyWith({ String? type,
    String? desc,
    num? amount,
    num? quantity,
    num? weight,
  }) =>
      Goods(
        type: type ?? _type,
        desc: desc ?? _desc,
        amount: amount ?? _amount,
        quantity: quantity ?? _quantity,
        weight: weight ?? _weight,
      );

  String? get type => _type;

  String? get desc => _desc;

  num? get amount => _amount;

  num? get quantity => _quantity;

  num? get weight => _weight;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['desc'] = _desc;
    map['amount'] = _amount;
    map['quantity'] = _quantity;
    map['weight'] = _weight;
    return map;
  }

}

Destination destinationFromJson(String str) => Destination.fromJson(json.decode(str));
String destinationToJson(Destination data) => json.encode(data.toJson());
class Destination {
  Destination({
    String? code,
    String? desc,}) {
    _code = code;
    _desc = desc;
  }

  Destination.fromJson(dynamic json) {
    _code = json['code'];
    _desc = json['desc'];
  }
  String? _code;
  String? _desc;

  Destination copyWith({ String? code,
    String? desc,
  }) =>
      Destination(code: code ?? _code,
        desc: desc ?? _desc,
      );
  String? get code => _code;
  String? get desc => _desc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['desc'] = _desc;
    return map;
  }

}

Origin originFromJson(String str) => Origin.fromJson(json.decode(str));
String originToJson(Origin data) => json.encode(data.toJson());
class Origin {
  Origin({
    String? code,
    String? desc,
    String? branch,}) {
    _code = code;
    _desc = desc;
    _branch = branch;
  }

  Origin.fromJson(dynamic json) {
    _code = json['code'];
    _desc = json['desc'];
    _branch = json['branch'];
  }
  String? _code;
  String? _desc;
  String? _branch;

  Origin copyWith({ String? code,
    String? desc,
    String? branch,
  }) =>
      Origin(code: code ?? _code,
        desc: desc ?? _desc,
        branch: branch ?? _branch,
      );
  String? get code => _code;
  String? get desc => _desc;
  String? get branch => _branch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['desc'] = _desc;
    map['branch'] = _branch;
    return map;
  }

}

Account accountFromJson(String str) => Account.fromJson(json.decode(str));
String accountToJson(Account data) => json.encode(data.toJson());
class Account {
  Account({
    String? number,
    String? service,}) {
    _number = number;
    _service = service;
  }

  Account.fromJson(dynamic json) {
    _number = json['number'];
    _service = json['service'];
  }
  String? _number;
  String? _service;

  Account copyWith({ String? number,
    String? service,
  }) =>
      Account(number: number ?? _number,
        service: service ?? _service,
      );
  String? get number => _number;
  String? get service => _service;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['number'] = _number;
    map['service'] = _service;
    return map;
  }

}

Delivery deliveryFromJson(String str) => Delivery.fromJson(json.decode(str));
String deliveryToJson(Delivery data) => json.encode(data.toJson());
class Delivery {
  Delivery({
    String? serviceCode,
    String? woodPackaging,
    String? specialInstruction,
    String? codFlag,
    String? codOngkir,
    num? codFee,
    String? insuranceFlag,
    num? insuranceFee,
    num? flatRate,
    num? flatRateWithInsurance,
    num? freightCharge,
    num? freightChargeWithInsurance,}) {
    _serviceCode = serviceCode;
    _woodPackaging = woodPackaging;
    _specialInstruction = specialInstruction;
    _codFlag = codFlag;
    _codOngkir = codOngkir;
    _codFee = codFee;
    _insuranceFlag = insuranceFlag;
    _insuranceFee = insuranceFee;
    _flatRate = flatRate;
    _flatRateWithInsurance = flatRateWithInsurance;
    _freightCharge = freightCharge;
    _freightChargeWithInsurance = freightChargeWithInsurance;
  }

  Delivery.fromJson(dynamic json) {
    _serviceCode = json['service_code'];
    _woodPackaging = json['wood_packaging'];
    _specialInstruction = json['special_instruction'];
    _codFlag = json['cod_flag'];
    _codOngkir = json['cod_ongkir'];
    _codFee = json['cod_fee'];
    _insuranceFlag = json['insurance_flag'];
    _insuranceFee = json['insurance_fee'];
    _flatRate = json['flat_rate'];
    _flatRateWithInsurance = json['flat_rate_with_insurance'];
    _freightCharge = json['freight_charge'];
    _freightChargeWithInsurance = json['freight_charge_with_insurance'];
  }

  String? _serviceCode;
  String? _woodPackaging;
  String? _specialInstruction;
  String? _codFlag;
  String? _codOngkir;
  num? _codFee;
  String? _insuranceFlag;
  num? _insuranceFee;
  num? _flatRate;
  num? _flatRateWithInsurance;
  num? _freightCharge;
  num? _freightChargeWithInsurance;

  Delivery copyWith({ String? serviceCode,
    String? woodPackaging,
    String? specialInstruction,
    String? codFlag,
    String? codOngkir,
    num? codFee,
    String? insuranceFlag,
    num? insuranceFee,
    num? flatRate,
    num? flatRateWithInsurance,
    num? freightCharge,
    num? freightChargeWithInsurance,
  }) =>
      Delivery(
        serviceCode: serviceCode ?? _serviceCode,
        woodPackaging: woodPackaging ?? _woodPackaging,
        specialInstruction: specialInstruction ?? _specialInstruction,
        codFlag: codFlag ?? _codFlag,
        codOngkir: codOngkir ?? _codOngkir,
        codFee: codFee ?? _codFee,
        insuranceFlag: insuranceFlag ?? _insuranceFlag,
        insuranceFee: insuranceFee ?? _insuranceFee,
        flatRate: flatRate ?? _flatRate,
        flatRateWithInsurance: flatRateWithInsurance ?? _flatRateWithInsurance,
        freightCharge: freightCharge ?? _freightCharge,
        freightChargeWithInsurance: freightChargeWithInsurance ?? _freightChargeWithInsurance,
      );

  String? get serviceCode => _serviceCode;

  String? get woodPackaging => _woodPackaging;

  String? get specialInstruction => _specialInstruction;

  String? get codFlag => _codFlag;

  String? get codOngkir => _codOngkir;

  num? get codFee => _codFee;

  String? get insuranceFlag => _insuranceFlag;

  num? get insuranceFee => _insuranceFee;

  num? get flatRate => _flatRate;

  num? get flatRateWithInsurance => _flatRateWithInsurance;

  num? get freightCharge => _freightCharge;

  num? get freightChargeWithInsurance => _freightChargeWithInsurance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_code'] = _serviceCode;
    map['wood_packaging'] = _woodPackaging;
    map['special_instruction'] = _specialInstruction;
    map['cod_flag'] = _codFlag;
    map['cod_ongkir'] = _codOngkir;
    map['cod_fee'] = _codFee;
    map['insurance_flag'] = _insuranceFlag;
    map['insurance_fee'] = _insuranceFee;
    map['flat_rate'] = _flatRate;
    map['flat_rate_with_insurance'] = _flatRateWithInsurance;
    map['freight_charge'] = _freightCharge;
    map['freight_charge_with_insurance'] = _freightChargeWithInsurance;
    return map;
  }

}