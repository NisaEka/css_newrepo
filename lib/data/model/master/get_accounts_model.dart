class Account {
  Account({
    String? accountId,
    String? accountBranch,
    String? accountName,
    String? accountType,
    String? accountService,
    String? accountCategory,
    String? accountCustType,
    String? accountNumber,
    String? accountStatus,
    String? accountSs,
    String? accountYes,
    String? accountReg,
    String? accountOke,
    String? accountJtr,
    String? accountIntl,
    String? accountCodfee,
  }) {
    _accountId = accountId;
    _accountBranch = accountBranch;
    _accountName = accountName;
    _accountType = accountType;
    _accountService = accountService;
    _accountCategory = accountCategory;
    _accountCustType = accountCustType;
    _accountNumber = accountNumber;
    _accountStatus = accountStatus;
    _accountSs = accountSs;
    _accountYes = accountYes;
    _accountReg = accountReg;
    _accountOke = accountOke;
    _accountJtr = accountJtr;
    _accountIntl = accountIntl;
    _accountCodfee = accountCodfee;
  }

  Account.fromJson(dynamic json) {
    _accountId = json['accountId'];
    _accountBranch = json['accountBranch'];
    _accountName = json['accountName'];
    _accountType = json['accountType'];
    _accountService = json['accountService'];
    _accountCategory = json['accountCategory'];
    _accountCustType = json['accountCustType'];
    _accountNumber = json['accountNumber'];
    _accountStatus = json['accountStatus'];
    _accountSs = json['accountSs'];
    _accountYes = json['accountYes'];
    _accountReg = json['accountReg'];
    _accountOke = json['accountOke'];
    _accountJtr = json['accountJtr'];
    _accountIntl = json['accountIntl'];
    _accountCodfee = json['accountCodfee'];
  }

  String? _accountId;
  String? _accountBranch;
  String? _accountName;
  String? _accountType;
  String? _accountService;
  String? _accountCategory;
  String? _accountCustType;
  String? _accountNumber;
  String? _accountStatus;
  String? _accountSs;
  String? _accountYes;
  String? _accountReg;
  String? _accountOke;
  String? _accountJtr;
  String? _accountIntl;
  String? _accountCodfee;

  Account copyWith({
    String? accountId,
    String? accountBranch,
    String? accountName,
    String? accountType,
    String? accountService,
    String? accountCategory,
    String? accountCustType,
    String? accountNumber,
    String? accountStatus,
    String? accountSs,
    String? accountYes,
    String? accountReg,
    String? accountOke,
    String? accountJtr,
    String? accountIntl,
    String? accountCodfee,
  }) =>
      Account(
        accountId: accountId ?? _accountId,
        accountBranch: accountBranch ?? _accountBranch,
        accountName: accountName ?? _accountName,
        accountType: accountType ?? _accountType,
        accountService: accountService ?? _accountService,
        accountCategory: accountCategory ?? _accountCategory,
        accountCustType: accountCustType ?? _accountCustType,
        accountNumber: accountNumber ?? _accountNumber,
        accountStatus: accountStatus ?? _accountStatus,
        accountSs: accountSs ?? _accountSs,
        accountYes: accountYes ?? _accountYes,
        accountReg: accountReg ?? _accountReg,
        accountOke: accountOke ?? _accountOke,
        accountJtr: accountJtr ?? _accountJtr,
        accountIntl: accountIntl ?? _accountIntl,
        accountCodfee: accountCodfee ?? _accountCodfee,
      );

  String? get accountId => _accountId;

  String? get accountBranch => _accountBranch;

  String? get accountName => _accountName;

  String? get accountType => _accountType;

  String? get accountService => _accountService;

  String? get accountCategory => _accountCategory;

  String? get accountCustType => _accountCustType;

  String? get accountNumber => _accountNumber;

  String? get accountStatus => _accountStatus;

  String? get accountSs => _accountSs;

  String? get accountYes => _accountYes;

  String? get accountReg => _accountReg;

  String? get accountOke => _accountOke;

  String? get accountJtr => _accountJtr;

  String? get accountIntl => _accountIntl;

  String? get accountCodfee => _accountCodfee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountId'] = _accountId;
    map['accountBranch'] = _accountBranch;
    map['accountName'] = _accountName;
    map['accountType'] = _accountType;
    map['accountService'] = _accountService;
    map['accountCategory'] = _accountCategory;
    map['accountCustType'] = _accountCustType;
    map['accountNumber'] = _accountNumber;
    map['accountStatus'] = _accountStatus;
    map['accountSs'] = _accountSs;
    map['accountYes'] = _accountYes;
    map['accountReg'] = _accountReg;
    map['accountOke'] = _accountOke;
    map['accountJtr'] = _accountJtr;
    map['accountIntl'] = _accountIntl;
    map['accountCodfee'] = _accountCodfee;
    return map;
  }
}
