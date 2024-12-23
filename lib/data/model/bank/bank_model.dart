class BankModel {
  BankModel({
    String? bankId,
    String? bankName,
  }) {
    _bankId = bankId;
    _bankName = bankName;
  }

  BankModel.fromJson(dynamic json) {
    _bankId = json['bankId'];
    _bankName = json['bankName'];
  }

  String? _bankId;
  String? _bankName;

  BankModel copyWith({
    String? bankId,
    String? bankName,
  }) =>
      BankModel(
        bankId: bankId ?? _bankId,
        bankName: bankName ?? _bankName,
      );

  String? get bankId => _bankId;

  String? get bankName => _bankName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['bankId'] = _bankId;
    map['bankName'] = _bankName;

    return map;
  }
}
