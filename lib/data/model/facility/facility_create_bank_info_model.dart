class FacilityCreateBankInfoModel {
  String _bankId = '';

  String get bankId => _bankId;

  String _accountNumber = '';

  String get accountNumber => _accountNumber;

  String _accountName = '';

  String get accountName => _accountName;

  String _accountImageUrl = '';

  String get accountImageUrl => _accountImageUrl;

  FacilityCreateBankInfoModel({
    String? bankId,
    String? accountNumber,
    String? accountName,
    String? accountImageUrl,
  }) {
    _bankId = bankId ?? '';
    _accountNumber = accountNumber ?? '';
    _accountName = accountName ?? '';
    _accountImageUrl = accountImageUrl ?? '';
  }

  setBankId(String bankId) {
    _bankId = bankId;
  }

  setAccountNumber(String accountNumber) {
    _accountNumber = accountNumber;
  }

  setAccountName(String accountName) {
    _accountName = accountName;
  }

  setAccountImageUrl(String accountImageUrl) {
    _accountImageUrl = accountImageUrl;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['bankId'] = _bankId;
    json['accountNumber'] = _accountNumber;
    json['accountName'] = _accountName;
    json['accountImageUrl'] = _accountImageUrl;

    return json;
  }

  FacilityCreateBankInfoModel.fromJson(dynamic json) {
    _bankId = json['bankId'];
    _accountNumber = json['accountNumber'];
    _accountName = json['accountName'];
    _accountImageUrl = json['accountImageUrl'];
  }
}
