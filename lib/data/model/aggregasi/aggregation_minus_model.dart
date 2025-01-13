class AggregationMinusModel {
  String _aggMinDoc = "";

  String get aggMinDoc => _aggMinDoc;

  String _custGroupId = "";

  String get custGroupId => _custGroupId;

  String _custId = "";

  String get custId => _custId;

  String _custName = "";

  String get custName => _custName;

  int _codAmt = 0;

  int get codAmt => _codAmt;

  int _codFee = 0;

  int get codFee => _codFee;

  int _netAmt = 0;

  int get netAmt => _netAmt;

  String _codType = "";

  String get codType => _codType;

  String _payType = "";

  String get payType => _payType;

  String _createddtm = "";

  String get createddtm => _createddtm;

  AggregationMinusModel.fromJson(dynamic json) {
    _aggMinDoc = json["aggMinDoc"];
    _custGroupId = json["custGroupId"];
    _custId = json["custId"];
    _custName = json["custName"];
    _codAmt = json["codAmt"];
    _codFee = json["codFee"];
    _netAmt = json["netAmt"];
    _codType = json["codType"];
    _payType = json["payType"];
    _createddtm = json["createddtm"];
  }

  AggregationMinusModel({
    String? aggMinDoc,
    String? custGroupId,
    String? custId,
    String? custName,
    int? codAmt,
    int? codFee,
    int? netAmt,
    String? codType,
    String? payType,
    String? createddtm,
  }) {
    _aggMinDoc = aggMinDoc ?? '';
    _custGroupId = custGroupId ?? '';
    _custId = custId ?? '';
    _custName = custName ?? '';
    _codAmt = codAmt ?? 0;
    _codFee = codFee ?? 0;
    _netAmt = netAmt ?? 0;
    _codType = codType ?? '';
    _payType = payType ?? '';
    _createddtm = createddtm ?? '';
  }
}
