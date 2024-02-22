import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';

class GetTransactionByAwbModel {
  GetTransactionByAwbModel({
    num? code,
    String? message,
    TransactionModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTransactionByAwbModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? TransactionModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  TransactionModel? _payload;

  GetTransactionByAwbModel copyWith({
    num? code,
    String? message,
    TransactionModel? payload,
  }) =>
      GetTransactionByAwbModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  TransactionModel? get payload => _payload;

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

class Account {
  Account({
    String? accountId,
    String? accountName,
    String? accountBranch,
    String? accountService,
    String? accountCategory,
    String? accountCustType,
    String? accountNumber,
    String? accountStatus,
    String? accountCodFee,
    String? accountTransaction,
    dynamic availableService,
  }) {
    _accountId = accountId;
    _accountName = accountName;
    _accountBranch = accountBranch;
    _accountService = accountService;
    _accountCategory = accountCategory;
    _accountCustType = accountCustType;
    _accountNumber = accountNumber;
    _accountStatus = accountStatus;
    _accountCodFee = accountCodFee;
    _accountTransaction = accountTransaction;
    _availableService = availableService;
  }

  Account.fromJson(dynamic json) {
    _accountId = json['account_id'];
    _accountName = json['account_name'];
    _accountBranch = json['account_branch'];
    _accountService = json['account_service'];
    _accountCategory = json['account_category'];
    _accountCustType = json['account_cust_type'];
    _accountNumber = json['account_number'];
    _accountStatus = json['account_status'];
    _accountCodFee = json['account_cod_fee'];
    _accountTransaction = json['account_transaction'];
    _availableService = json['available_service'];
    _accountNumber = json['number'];
    _accountService = json['service'];
  }

  String? _accountId;
  String? _accountName;
  String? _accountBranch;
  String? _accountService;
  String? _accountCategory;
  String? _accountCustType;
  String? _accountNumber;
  String? _accountStatus;
  String? _accountCodFee;
  String? _accountTransaction;
  dynamic _availableService;

  Account copyWith({
    String? accountId,
    String? accountName,
    String? accountBranch,
    String? accountService,
    String? accountCategory,
    String? accountCustType,
    String? accountNumber,
    String? accountStatus,
    String? accountCodFee,
    String? accountTransaction,
    dynamic availableService,
  }) =>
      Account(
        accountId: accountId ?? _accountId,
        accountName: accountName ?? _accountName,
        accountBranch: accountBranch ?? _accountBranch,
        accountService: accountService ?? _accountService,
        accountCategory: accountCategory ?? _accountCategory,
        accountCustType: accountCustType ?? _accountCustType,
        accountNumber: accountNumber ?? _accountNumber,
        accountStatus: accountStatus ?? _accountStatus,
        accountCodFee: accountCodFee ?? _accountCodFee,
        accountTransaction: accountTransaction ?? _accountTransaction,
        availableService: availableService ?? _availableService,
      );

  String? get accountId => _accountId;

  String? get accountName => _accountName;

  String? get accountBranch => _accountBranch;

  String? get accountService => _accountService;

  String? get accountCategory => _accountCategory;

  String? get accountCustType => _accountCustType;

  String? get accountNumber => _accountNumber;

  String? get accountStatus => _accountStatus;

  String? get accountCodFee => _accountCodFee;

  String? get accountTransaction => _accountTransaction;

  dynamic get availableService => _availableService;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['account_id'] = _accountId;
    map['account_name'] = _accountName;
    map['account_branch'] = _accountBranch;
    map['account_service'] = _accountService;
    map['account_category'] = _accountCategory;
    map['account_cust_type'] = _accountCustType;
    map['account_number'] = _accountNumber;
    map['account_status'] = _accountStatus;
    map['account_cod_fee'] = _accountCodFee;
    map['account_transaction'] = _accountTransaction;
    map['available_service'] = _availableService;
    map['number'] = _accountNumber;
    map['service'] = _accountService;
    return map;
  }
}
