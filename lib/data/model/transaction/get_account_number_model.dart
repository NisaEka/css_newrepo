import 'dart:convert';

GetAccountNumberModel getAccountNumberModelFromJson(String str) => GetAccountNumberModel.fromJson(json.decode(str));

String getAccountNumberModelToJson(GetAccountNumberModel data) => json.encode(data.toJson());

class GetAccountNumberModel {
  GetAccountNumberModel({
    num? code,
    String? message,
    List<Account>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetAccountNumberModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(Account.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<Account>? _payload;

  GetAccountNumberModel copyWith({
    num? code,
    String? message,
    List<Account>? payload,
  }) =>
      GetAccountNumberModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<Account>? get payload => _payload;

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

Account payloadFromJson(String str) => Account.fromJson(json.decode(str));

String payloadToJson(Account data) => json.encode(data.toJson());

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
    String? accountType,
    AvailableService? availableService,
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
    _accountType = accountType;
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
    _accountType = json['account_type'];
    _availableService = json['available_service'] != null ? AvailableService.fromJson(json['available_service']) : null;
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
  String? _accountType;
  AvailableService? _availableService;

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
    String? accountType,
    AvailableService? availableService,
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
        accountType: accountType ?? _accountType,
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

  String? get accountType => _accountType;

  AvailableService? get availableService => _availableService;

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
    map['account_type'] = _accountType;
    if (_availableService != null) {
      map['available_service'] = _availableService?.toJson();
    }
    return map;
  }
}

AvailableService availableServiceFromJson(String str) => AvailableService.fromJson(json.decode(str));

String availableServiceToJson(AvailableService data) => json.encode(data.toJson());

class AvailableService {
  AvailableService({
    String? ss,
    String? yes,
    String? reg,
    String? oke,
    String? jtr,
    dynamic intl,
  }) {
    _ss = ss;
    _yes = yes;
    _reg = reg;
    _oke = oke;
    _jtr = jtr;
    _intl = intl;
  }

  AvailableService.fromJson(dynamic json) {
    _ss = json['ss'];
    _yes = json['yes'];
    _reg = json['reg'];
    _oke = json['oke'];
    _jtr = json['jtr'];
    _intl = json['intl'];
  }

  String? _ss;
  String? _yes;
  String? _reg;
  String? _oke;
  String? _jtr;
  String? _intl;

  AvailableService copyWith({
    String? ss,
    String? yes,
    String? reg,
    String? oke,
    String? jtr,
    String? intl,
  }) =>
      AvailableService(
        ss: ss ?? _ss,
        yes: yes ?? _yes,
        reg: reg ?? _reg,
        oke: oke ?? _oke,
        jtr: jtr ?? _jtr,
        intl: intl ?? _intl,
      );

  String? get ss => _ss;

  String? get yes => _yes;

  String? get reg => _reg;

  String? get oke => _oke;

  String? get jtr => _jtr;

  String? get intl => _intl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ss'] = _ss;
    map['yes'] = _yes;
    map['reg'] = _reg;
    map['oke'] = _oke;
    map['jtr'] = _jtr;
    map['intl'] = _intl;
    return map;
  }
}
