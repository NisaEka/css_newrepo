import 'dart:convert';

GetAccountNumberModel getAccountNumberModelFromJson(String str) => GetAccountNumberModel.fromJson(json.decode(str));

String getAccountNumberModelToJson(GetAccountNumberModel data) => json.encode(data.toJson());

class GetAccountNumberModel {
  GetAccountNumberModel({
    num? code,
    String? message,
    List<AccountNumber>? payload,
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
        _payload?.add(AccountNumber.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<AccountNumber>? _payload;

  GetAccountNumberModel copyWith({
    num? code,
    String? message,
    List<AccountNumber>? payload,
  }) =>
      GetAccountNumberModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<AccountNumber>? get payload => _payload;

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

AccountNumber payloadFromJson(String str) => AccountNumber.fromJson(json.decode(str));

String payloadToJson(AccountNumber data) => json.encode(data.toJson());

class AccountNumber {
  AccountNumber({
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
    AvailableService? availableService,
    bool? isSelected,
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
    _isSelected = isSelected;
  }

  AccountNumber.fromJson(dynamic json) {
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
    _availableService = json['available_service'] != null ? AvailableService.fromJson(json['available_service']) : null;
    _isSelected = true;
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
  AvailableService? _availableService;
  bool? _isSelected;

  AccountNumber copyWith({
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
    AvailableService? availableService,
    bool? isSelected,
  }) =>
      AccountNumber(
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
        isSelected: isSelected ?? _isSelected,
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

  AvailableService? get availableService => _availableService;

  bool? get isSelected => _isSelected;

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
    if (_availableService != null) {
      map['available_service'] = _availableService?.toJson();
    }
    map['isSelected'] = _isSelected;
    return map;
  }
}

AvailableService availableServiceFromJson(String str) => AvailableService.fromJson(json.decode(str));

String availableServiceToJson(AvailableService data) => json.encode(data.toJson());

class AvailableService {
  AvailableService({
    dynamic ss,
    dynamic yes,
    String? reg,
    dynamic oke,
    dynamic jtr,
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

  dynamic _ss;
  dynamic _yes;
  String? _reg;
  dynamic _oke;
  dynamic _jtr;
  dynamic _intl;

  AvailableService copyWith({
    dynamic ss,
    dynamic yes,
    String? reg,
    dynamic oke,
    dynamic jtr,
    dynamic intl,
  }) =>
      AvailableService(
        ss: ss ?? _ss,
        yes: yes ?? _yes,
        reg: reg ?? _reg,
        oke: oke ?? _oke,
        jtr: jtr ?? _jtr,
        intl: intl ?? _intl,
      );

  dynamic get ss => _ss;

  dynamic get yes => _yes;

  String? get reg => _reg;

  dynamic get oke => _oke;

  dynamic get jtr => _jtr;

  dynamic get intl => _intl;

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
