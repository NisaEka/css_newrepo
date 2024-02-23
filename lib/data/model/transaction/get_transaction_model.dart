import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';

class GetTransactionModel {
  GetTransactionModel({
    num? code,
    String? message,
    List<TransactionModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(TransactionModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<TransactionModel>? _payload;

  GetTransactionModel copyWith({
    num? code,
    String? message,
    List<TransactionModel>? payload,
  }) =>
      GetTransactionModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<TransactionModel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class TransactionModel {
  TransactionModel({
    String? awb,
    String? awbType,
    String? registrationId,
    String? apiType,
    String? createdDate,
    String? service,
    String? status,
    Receiver? receiver,
    String? orderId,
    num? codAmount,
    String? officerEntry,
    Shipper? shipper,
    Account? account,
    String? pickupStatus,
  }) {
    _awb = awb;
    _awbType = awbType;
    _registrationId = registrationId;
    _apiType = apiType;
    _createdDate = createdDate;
    _service = service;
    _status = status;
    _receiver = receiver;
    _orderId = orderId;
    _codAmount = codAmount;
    _officerEntry = officerEntry;
    _shipper = shipper;
    _account = account;
    _pickupStatus = pickupStatus;
  }

  TransactionModel.fromJson(dynamic json) {
    _awb = json['awb'];
    _awbType = json['awb_type'];
    _registrationId = json['registration_id'];
    _apiType = json['api_type'] ?? json['type'];
    // _apiType = json['type'];
    _createdDate = json['created_date'];
    _service = json['service'];
    _status = json['status'];
    _receiver = json['receiver'] != null ? Receiver.fromJson(json['receiver']) : null;
    _orderId = json['order_id'];
    _codAmount = json['cod_amount'];
    _officerEntry = json['officer_entry'];
    _shipper = json['shipper'] != null ? Shipper.fromJson(json['shipper']) : null;
    _account = json['account'] != null ? Account.fromJson(json['account']) : null;
    _pickupStatus = json['pickup_status'];
  }

  String? _awb;
  String? _awbType;
  String? _registrationId;
  String? _apiType;
  String? _createdDate;
  String? _service;
  String? _status;
  Receiver? _receiver;
  String? _orderId;
  num? _codAmount;
  String? _officerEntry;
  Shipper? _shipper;
  Account? _account;
  String? _pickupStatus;

  TransactionModel copyWith({
    String? awb,
    String? awbType,
    String? registrationId,
    String? apiType,
    String? createdDate,
    String? service,
    String? status,
    Receiver? receiver,
    String? orderId,
    num? codAmount,
    String? officerEntry,
    Shipper? shipper,
    Account? account,
    String? pickupStatus,
  }) =>
      TransactionModel(
        awb: awb ?? _awb,
        awbType: awbType ?? _awbType,
        registrationId: registrationId ?? _registrationId,
        apiType: apiType ?? _apiType,
        createdDate: createdDate ?? _createdDate,
        service: service ?? _service,
        status: status ?? _status,
        receiver: receiver ?? _receiver,
        orderId: orderId ?? _orderId,
        codAmount: codAmount ?? _codAmount,
        officerEntry: officerEntry ?? _officerEntry,
        shipper: shipper ?? _shipper,
        account: account ?? _account,
        pickupStatus: pickupStatus ?? _pickupStatus,
      );

  String? get awb => _awb;

  String? get awbType => _awbType;

  String? get registrationId => _registrationId;

  String? get apiType => _apiType;

  String? get createdDate => _createdDate;

  String? get service => _service;

  String? get status => _status;

  Receiver? get receiver => _receiver;

  String? get orderId => _orderId;

  num? get codAmount => _codAmount;

  String? get officerEntry => _officerEntry;

  Shipper? get shipper => _shipper;

  Account? get account => _account;

  String? get pickupStatus => _pickupStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awb'] = _awb;
    map['awb_type'] = _awbType;
    map['registration_id'] = _registrationId;
    map['type'] = _apiType;
    map['api_type'] = _apiType;
    map['created_date'] = _createdDate;
    map['service'] = _service;
    map['status'] = _status;
    if (_receiver != null) {
      map['receiver'] = _receiver?.toJson();
    }
    map['order_id'] = _orderId;
    map['cod_amount'] = _codAmount;
    map['officer_entry'] = _officerEntry;
    if (_shipper != null) {
      map['shipper'] = _shipper?.toJson();
    }
    if (_account != null) {
      map['account'] = _account?.toJson();
    }
    map['pickup_status'] = _pickupStatus;
    return map;
  }
}
