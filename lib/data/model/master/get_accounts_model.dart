class TransAccountModel {
  TransAccountModel({
    String? accountId,
    String? accountBranch,
    String? accountMain,
    String? accountName,
    num? accountTypeId,
    String? accountType,
    num? accountServiceId,
    String? accountService,
    num? accountCategoryId,
    String? accountCategory,
    num? accountPaymentTypeId,
    String? accountPaymentType,
    num? accountPayoutTypeId,
    String? accountPayoutType,
    num? accountPrefixId,
    num? accountPrefix,
    num? accountCustTypeId,
    String? accountCustType,
    String? accountCustTypeBfr,
    String? accountNumber,
    String? accountIndustryType,
    String? accountStatus,
    String? mainAccount,
    String? accountSs,
    String? accountYes,
    String? accountReg,
    String? accountOke,
    String? accountJtr,
    String? accountIntl,
    String? accountDiscount,
    num? accountDesreq1,
    num? accountDesreq2,
    num? accountDesreq3,
    num? accountDiscIc,
    num? accountDiscDm,
    num? accountDiscIn,
    String? accountCodfee,
    String? accountTransaction,
    num? apiStatus,
    String? apiDescription,
    String? apiTcustdescription,
    String? registrationId,
    String? ccrfId,
    String? accountCreatedate,
    String? accountParentId,
    String? accountOrigin,
  }) {
    _accountId = accountId;
    _accountBranch = accountBranch;
    _accountMain = accountMain;
    _accountName = accountName;
    _accountTypeId = accountTypeId;
    _accountType = accountType;
    _accountServiceId = accountServiceId;
    _accountService = accountService;
    _accountCategoryId = accountCategoryId;
    _accountCategory = accountCategory;
    _accountPaymentTypeId = accountPaymentTypeId;
    _accountPaymentType = accountPaymentType;
    _accountPayoutTypeId = accountPayoutTypeId;
    _accountPayoutType = accountPayoutType;
    _accountPrefixId = accountPrefixId;
    _accountPrefix = accountPrefix;
    _accountCustTypeId = accountCustTypeId;
    _accountCustType = accountCustType;
    _accountCustTypeBfr = accountCustTypeBfr;
    _accountNumber = accountNumber;
    _accountIndustryType = accountIndustryType;
    _accountStatus = accountStatus;
    _mainAccount = mainAccount;
    _accountSs = accountSs;
    _accountYes = accountYes;
    _accountReg = accountReg;
    _accountOke = accountOke;
    _accountJtr = accountJtr;
    _accountIntl = accountIntl;
    _accountDiscount = accountDiscount;
    _accountDesreq1 = accountDesreq1;
    _accountDesreq2 = accountDesreq2;
    _accountDesreq3 = accountDesreq3;
    _accountDiscIc = accountDiscIc;
    _accountDiscDm = accountDiscDm;
    _accountDiscIn = accountDiscIn;
    _accountCodfee = accountCodfee;
    _accountTransaction = accountTransaction;
    _apiStatus = apiStatus;
    _apiDescription = apiDescription;
    _apiTcustdescription = apiTcustdescription;
    _registrationId = registrationId;
    _ccrfId = ccrfId;
    _accountCreatedate = accountCreatedate;
    _accountParentId = accountParentId;
    _accountOrigin = accountOrigin;
  }

  TransAccountModel.fromJson(dynamic json) {
    _accountId = json['accountId'];
    _accountBranch = json['accountBranch'];
    _accountMain = json['accountMain'];
    _accountName = json['accountName'];
    _accountTypeId = json['accountTypeId'];
    _accountType = json['accountType'];
    _accountServiceId = json['accountServiceId'];
    _accountService = json['accountService'];
    _accountCategoryId = json['accountCategoryId'];
    _accountCategory = json['accountCategory'];
    _accountPaymentTypeId = json['accountPaymentTypeId'];
    _accountPaymentType = json['accountPaymentType'];
    _accountPayoutTypeId = json['accountPayoutTypeId'];
    _accountPayoutType = json['accountPayoutType'];
    _accountPrefixId = json['accountPrefixId'];
    _accountPrefix = json['accountPrefix'];
    _accountCustTypeId = json['accountCustTypeId'];
    _accountCustType = json['accountCustType'];
    _accountCustTypeBfr = json['accountCustTypeBfr'];
    _accountNumber = json['accountNumber'];
    _accountIndustryType = json['accountIndustryType'];
    _accountStatus = json['accountStatus'];
    _mainAccount = json['mainAccount'];
    _accountSs = json['accountSs'];
    _accountYes = json['accountYes'];
    _accountReg = json['accountReg'];
    _accountOke = json['accountOke'];
    _accountJtr = json['accountJtr'];
    _accountIntl = json['accountIntl'];
    _accountDiscount = json['accountDiscount'];
    _accountDesreq1 = json['accountDesreq1'];
    _accountDesreq2 = json['accountDesreq2'];
    _accountDesreq3 = json['accountDesreq3'];
    _accountDiscIc = json['accountDiscIc'];
    _accountDiscDm = json['accountDiscDm'];
    _accountDiscIn = json['accountDiscIn'];
    _accountCodfee = json['accountCodfee'];
    _accountTransaction = json['accountTransaction'];
    _apiStatus = json['apiStatus'];
    _apiDescription = json['apiDescription'];
    _apiTcustdescription = json['apiTcustdescription'];
    _registrationId = json['registrationId'];
    _ccrfId = json['ccrfId'];
    _accountCreatedate = json['accountCreatedate'];
    _accountParentId = json['accountParentId'];
    _accountOrigin = json['accountOrigin'];
  }

  String? _accountId;
  String? _accountBranch;
  String? _accountMain;
  String? _accountName;
  num? _accountTypeId;
  String? _accountType;
  num? _accountServiceId;
  String? _accountService;
  num? _accountCategoryId;
  String? _accountCategory;
  num? _accountPaymentTypeId;
  String? _accountPaymentType;
  num? _accountPayoutTypeId;
  String? _accountPayoutType;
  num? _accountPrefixId;
  num? _accountPrefix;
  num? _accountCustTypeId;
  String? _accountCustType;
  String? _accountCustTypeBfr;
  String? _accountNumber;
  String? _accountIndustryType;
  String? _accountStatus;
  String? _mainAccount;
  String? _accountSs;
  String? _accountYes;
  String? _accountReg;
  String? _accountOke;
  String? _accountJtr;
  String? _accountIntl;
  String? _accountDiscount;
  num? _accountDesreq1;
  num? _accountDesreq2;
  num? _accountDesreq3;
  num? _accountDiscIc;
  num? _accountDiscDm;
  num? _accountDiscIn;
  String? _accountCodfee;
  String? _accountTransaction;
  num? _apiStatus;
  String? _apiDescription;
  String? _apiTcustdescription;
  String? _registrationId;
  String? _ccrfId;
  String? _accountCreatedate;
  String? _accountParentId;
  String? _accountOrigin;

  TransAccountModel copyWith({
    String? accountId,
    String? accountBranch,
    String? accountMain,
    String? accountName,
    num? accountTypeId,
    String? accountType,
    num? accountServiceId,
    String? accountService,
    num? accountCategoryId,
    String? accountCategory,
    num? accountPaymentTypeId,
    String? accountPaymentType,
    num? accountPayoutTypeId,
    String? accountPayoutType,
    num? accountPrefixId,
    num? accountPrefix,
    num? accountCustTypeId,
    String? accountCustType,
    String? accountCustTypeBfr,
    String? accountNumber,
    String? accountIndustryType,
    String? accountStatus,
    String? mainAccount,
    String? accountSs,
    String? accountYes,
    String? accountReg,
    String? accountOke,
    String? accountJtr,
    String? accountIntl,
    String? accountDiscount,
    num? accountDesreq1,
    num? accountDesreq2,
    num? accountDesreq3,
    num? accountDiscIc,
    num? accountDiscDm,
    num? accountDiscIn,
    String? accountCodfee,
    String? accountTransaction,
    num? apiStatus,
    String? apiDescription,
    String? apiTcustdescription,
    String? registrationId,
    String? ccrfId,
    String? accountCreatedate,
    String? accountParentId,
    String? accountOrigin,
  }) =>
      TransAccountModel(
        accountId: accountId ?? _accountId,
        accountBranch: accountBranch ?? _accountBranch,
        accountMain: accountMain ?? _accountMain,
        accountName: accountName ?? _accountName,
        accountTypeId: accountTypeId ?? _accountTypeId,
        accountType: accountType ?? _accountType,
        accountServiceId: accountServiceId ?? _accountServiceId,
        accountService: accountService ?? _accountService,
        accountCategoryId: accountCategoryId ?? _accountCategoryId,
        accountCategory: accountCategory ?? _accountCategory,
        accountPaymentTypeId: accountPaymentTypeId ?? _accountPaymentTypeId,
        accountPaymentType: accountPaymentType ?? _accountPaymentType,
        accountPayoutTypeId: accountPayoutTypeId ?? _accountPayoutTypeId,
        accountPayoutType: accountPayoutType ?? _accountPayoutType,
        accountPrefixId: accountPrefixId ?? _accountPrefixId,
        accountPrefix: accountPrefix ?? _accountPrefix,
        accountCustTypeId: accountCustTypeId ?? _accountCustTypeId,
        accountCustType: accountCustType ?? _accountCustType,
        accountCustTypeBfr: accountCustTypeBfr ?? _accountCustTypeBfr,
        accountNumber: accountNumber ?? _accountNumber,
        accountIndustryType: accountIndustryType ?? _accountIndustryType,
        accountStatus: accountStatus ?? _accountStatus,
        mainAccount: mainAccount ?? _mainAccount,
        accountSs: accountSs ?? _accountSs,
        accountYes: accountYes ?? _accountYes,
        accountReg: accountReg ?? _accountReg,
        accountOke: accountOke ?? _accountOke,
        accountJtr: accountJtr ?? _accountJtr,
        accountIntl: accountIntl ?? _accountIntl,
        accountDiscount: accountDiscount ?? _accountDiscount,
        accountDesreq1: accountDesreq1 ?? _accountDesreq1,
        accountDesreq2: accountDesreq2 ?? _accountDesreq2,
        accountDesreq3: accountDesreq3 ?? _accountDesreq3,
        accountDiscIc: accountDiscIc ?? _accountDiscIc,
        accountDiscDm: accountDiscDm ?? _accountDiscDm,
        accountDiscIn: accountDiscIn ?? _accountDiscIn,
        accountCodfee: accountCodfee ?? _accountCodfee,
        accountTransaction: accountTransaction ?? _accountTransaction,
        apiStatus: apiStatus ?? _apiStatus,
        apiDescription: apiDescription ?? _apiDescription,
        apiTcustdescription: apiTcustdescription ?? _apiTcustdescription,
        registrationId: registrationId ?? _registrationId,
        ccrfId: ccrfId ?? _ccrfId,
        accountCreatedate: accountCreatedate ?? _accountCreatedate,
        accountParentId: accountParentId ?? _accountParentId,
        accountOrigin: accountOrigin ?? _accountOrigin,
      );

  String? get accountId => _accountId;

  String? get accountBranch => _accountBranch;

  String? get accountMain => _accountMain;

  String? get accountName => _accountName;

  num? get accountTypeId => _accountTypeId;

  String? get accountType => _accountType;

  num? get accountServiceId => _accountServiceId;

  String? get accountService => _accountService;

  num? get accountCategoryId => _accountCategoryId;

  String? get accountCategory => _accountCategory;

  num? get accountPaymentTypeId => _accountPaymentTypeId;

  String? get accountPaymentType => _accountPaymentType;

  num? get accountPayoutTypeId => _accountPayoutTypeId;

  String? get accountPayoutType => _accountPayoutType;

  num? get accountPrefixId => _accountPrefixId;

  num? get accountPrefix => _accountPrefix;

  num? get accountCustTypeId => _accountCustTypeId;

  String? get accountCustType => _accountCustType;

  String? get accountCustTypeBfr => _accountCustTypeBfr;

  String? get accountNumber => _accountNumber;

  String? get accountIndustryType => _accountIndustryType;

  String? get accountStatus => _accountStatus;

  String? get mainAccount => _mainAccount;

  String? get accountSs => _accountSs;

  String? get accountYes => _accountYes;

  String? get accountReg => _accountReg;

  String? get accountOke => _accountOke;

  String? get accountJtr => _accountJtr;

  String? get accountIntl => _accountIntl;

  String? get accountDiscount => _accountDiscount;

  num? get accountDesreq1 => _accountDesreq1;

  num? get accountDesreq2 => _accountDesreq2;

  num? get accountDesreq3 => _accountDesreq3;

  num? get accountDiscIc => _accountDiscIc;

  num? get accountDiscDm => _accountDiscDm;

  num? get accountDiscIn => _accountDiscIn;

  String? get accountCodfee => _accountCodfee;

  String? get accountTransaction => _accountTransaction;

  num? get apiStatus => _apiStatus;

  String? get apiDescription => _apiDescription;

  String? get apiTcustdescription => _apiTcustdescription;

  String? get registrationId => _registrationId;

  String? get ccrfId => _ccrfId;

  String? get accountCreatedate => _accountCreatedate;

  String? get accountParentId => _accountParentId;

  String? get accountOrigin => _accountOrigin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accountId'] = _accountId;
    map['accountBranch'] = _accountBranch;
    map['accountMain'] = _accountMain;
    map['accountName'] = _accountName;
    map['accountTypeId'] = _accountTypeId;
    map['accountType'] = _accountType;
    map['accountServiceId'] = _accountServiceId;
    map['accountService'] = _accountService;
    map['accountCategoryId'] = _accountCategoryId;
    map['accountCategory'] = _accountCategory;
    map['accountPaymentTypeId'] = _accountPaymentTypeId;
    map['accountPaymentType'] = _accountPaymentType;
    map['accountPayoutTypeId'] = _accountPayoutTypeId;
    map['accountPayoutType'] = _accountPayoutType;
    map['accountPrefixId'] = _accountPrefixId;
    map['accountPrefix'] = _accountPrefix;
    map['accountCustTypeId'] = _accountCustTypeId;
    map['accountCustType'] = _accountCustType;
    map['accountCustTypeBfr'] = _accountCustTypeBfr;
    map['accountNumber'] = _accountNumber;
    map['accountIndustryType'] = _accountIndustryType;
    map['accountStatus'] = _accountStatus;
    map['mainAccount'] = _mainAccount;
    map['accountSs'] = _accountSs;
    map['accountYes'] = _accountYes;
    map['accountReg'] = _accountReg;
    map['accountOke'] = _accountOke;
    map['accountJtr'] = _accountJtr;
    map['accountIntl'] = _accountIntl;
    map['accountDiscount'] = _accountDiscount;
    map['accountDesreq1'] = _accountDesreq1;
    map['accountDesreq2'] = _accountDesreq2;
    map['accountDesreq3'] = _accountDesreq3;
    map['accountDiscIc'] = _accountDiscIc;
    map['accountDiscDm'] = _accountDiscDm;
    map['accountDiscIn'] = _accountDiscIn;
    map['accountCodfee'] = _accountCodfee;
    map['accountTransaction'] = _accountTransaction;
    map['apiStatus'] = _apiStatus;
    map['apiDescription'] = _apiDescription;
    map['apiTcustdescription'] = _apiTcustdescription;
    map['registrationId'] = _registrationId;
    map['ccrfId'] = _ccrfId;
    map['accountCreatedate'] = _accountCreatedate;
    map['accountParentId'] = _accountParentId;
    map['accountOrigin'] = _accountOrigin;
    return map;
  }
}
