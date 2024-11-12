import 'dart:convert';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/master/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_receiver_model.dart';
import 'package:css_mobile/data/model/master/get_shipper_model.dart';

DataTransactionModel transactionDataModelFromJson(String str) =>
    DataTransactionModel.fromJson(json.decode(str));

String transactionDataModelToJson(DataTransactionModel data) =>
    json.encode(data.toJson());

class DataTransactionModel {
  DataTransactionModel({
    String? awb,
    String? awbType,
    String? registrationId,
    String? type,
    String? createdDate,
    String? status,
    String? orderId,
    String? officerEntry,
    String? pickupStatus,
    Delivery? delivery,
    Account? account,
    OriginModel? origin,
    Destination? destination,
    Goods? goods,
    ShipperModel? shipper,
    DropshipperModel? dropshipper,
    ReceiverModel? receiver,
    Account? dataAccount,
    Destination? dataDestination,
    String? createAt,
    String? updateAt,
  }) {
    _awb = awb;
    _awbType = awbType;
    _registrationId = registrationId;
    _type = type;
    _createdDate = createdDate;
    _status = status;
    _orderId = orderId;
    _officerEntry = officerEntry;
    _pickupStatus = pickupStatus;
    _delivery = delivery;
    _account = account;
    _origin = origin;
    _destination = destination;
    _goods = goods;
    _shipper = shipper;
    _receiver = receiver;
    _dataAccount = dataAccount;
    _dataDestination = dataDestination;
    _createAt = createAt;
    _updateAt = updateAt;
  }

  DataTransactionModel.fromJson(dynamic json) {
    _awb = json['awb'];
    _awbType = json['awb_type'];
    _registrationId = json['registration_id'];
    _type = json['api_type'] ?? json['type'];
    _createdDate = json['created_date'];
    _status = json['status'];
    _orderId = json['order_id'];
    _officerEntry = json['officer_entry'];
    _pickupStatus = json['pickup_status'];
    _delivery = json['delivery'] != null
        ? Delivery.fromJson(json['delivery'])
        : json['info'] != null
            ? Delivery.fromJson(json['info'])
            : json['transaction'] != null
                ? Delivery.fromJson(json['transaction'])
                : null;
    _account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
    _origin =
        json['origin'] != null ? OriginModel.fromJson(json['origin']) : null;
    _destination = json['destination'] != null
        ? Destination.fromJson(json['destination'])
        : null;
    _goods = json['goods'] != null ? Goods.fromJson(json['goods']) : null;
    _shipper =
        json['shipper'] != null ? ShipperModel.fromJson(json['shipper']) : null;
    _receiver = json['receiver'] != null
        ? ReceiverModel.fromJson(json['receiver'])
        : null;
    _dataAccount = json['data_account'] != null
        ? Account.fromJson(json['data_account'])
        : null;
    _dataDestination = json['data_destination'] != null
        ? Destination.fromJson(json['data_destination'])
        : null;
    _createAt = json['create_at'];
    _updateAt = json['update_at'];
  }

  String? _awb;
  String? _awbType;
  String? _registrationId;
  String? _type;
  String? _createdDate;
  String? _status;
  String? _orderId;
  String? _officerEntry;
  String? _pickupStatus;
  Delivery? _delivery;
  Account? _account;
  OriginModel? _origin;
  Destination? _destination;
  Goods? _goods;
  ShipperModel? _shipper;
  ReceiverModel? _receiver;
  Account? _dataAccount;
  Destination? _dataDestination;
  String? _createAt;
  String? _updateAt;

  DataTransactionModel copyWith({
    String? awb,
    String? awbType,
    String? registrationId,
    String? type,
    String? createdDate,
    String? status,
    String? orderId,
    String? officerEntry,
    String? pickupStatus,
    Delivery? delivery,
    Account? account,
    OriginModel? origin,
    Destination? destination,
    Goods? goods,
    ShipperModel? shipper,
    ReceiverModel? receiver,
    Account? dataAccount,
    Destination? dataDestination,
    String? createAt,
    String? updateAt,
  }) =>
      DataTransactionModel(
        awb: awb ?? _awb,
        awbType: awbType ?? _awbType,
        registrationId: registrationId ?? _registrationId,
        type: type ?? _type,
        createdDate: createdDate ?? _createdDate,
        status: status ?? _status,
        orderId: orderId ?? _orderId,
        officerEntry: officerEntry ?? _officerEntry,
        pickupStatus: pickupStatus ?? _pickupStatus,
        delivery: delivery ?? _delivery,
        account: account ?? _account,
        origin: origin ?? _origin,
        destination: destination ?? _destination,
        goods: goods ?? _goods,
        shipper: shipper ?? _shipper,
        receiver: receiver ?? _receiver,
        dataAccount: dataAccount ?? _dataAccount,
        dataDestination: dataDestination ?? _dataDestination,
        createAt: createAt ?? _createAt,
        updateAt: updateAt ?? _updateAt,
      );

  String? get awb => _awb;

  String? get awbType => _awbType;

  String? get registrationId => _registrationId;

  String? get type => _type;

  String? get createdDate => _createdDate;

  String? get status => _status;

  String? get orderId => _orderId;

  String? get officerEntry => _officerEntry;

  String? get pickupStatus => _pickupStatus;

  Delivery? get delivery => _delivery;

  Account? get account => _account;

  OriginModel? get origin => _origin;

  Destination? get destination => _destination;

  Goods? get goods => _goods;

  ShipperModel? get shipper => _shipper;

  ReceiverModel? get receiver => _receiver;

  Account? get dataAccount => _dataAccount;

  Destination? get dataDestination => _dataDestination;

  String? get createAt => _createAt;

  String? get updateAt => _updateAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awb'] = _awb;
    map['awb_type'] = _awbType;
    map['registration_id'] = _registrationId;
    map['type'] = _type;
    map['api_type'] = _type;
    map['created_date'] = _createdDate;
    map['order_id'] = _orderId;
    map['officer_entry'] = _officerEntry;
    map['pickup_status'] = _pickupStatus;
    if (_delivery != null) {
      map['delivery'] = _delivery?.toJson();
      map['info'] = _delivery?.toJson();
      map['transaction'] = _delivery?.toJson();
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
    if (_dataAccount != null) {
      map['data_account'] = _dataAccount?.toJson();
    }
    if (_dataDestination != null) {
      map['data_destination'] = _dataDestination?.toJson();
    }
    map['create_at'] = _createAt;
    map['update_at'] = _updateAt;
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
    num? weight,
  }) {
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

  Goods copyWith({
    String? type,
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
    num? freightChargeWithInsurance,
  }) {
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

  Delivery copyWith({
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
        freightChargeWithInsurance:
            freightChargeWithInsurance ?? _freightChargeWithInsurance,
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
