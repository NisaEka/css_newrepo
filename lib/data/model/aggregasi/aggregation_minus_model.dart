class AggregationMinusModel {

  String _aggMinDoc = "";
  String get aggMinDoc => _aggMinDoc;

  String _custGroupId = "";
  String get custGroupId => _custGroupId;

  String _custId = "";
  String get custId => _custId;

  String _custName = "";
  String get custName => _custName;

  int _codAmount = 0;
  int get codAmount => _codAmount;

  int _codFee = 0;
  int get codFee => _codFee;

  int _netAmount = 0;
  int get netAmount => _netAmount;

  String _codType = "";
  String get codType => _codType;

  String _payType = "";
  String get payType => _payType;

  AggregationMinusModel.fromJson(dynamic json) {
    _aggMinDoc = json["agg_min_doc"];
    _custGroupId = json["cust_group_id"];
    _custId = json["cust_id"];
    _custName = json["cust_name"];
    _codAmount = json["cod_amount"];
    _codFee = json["cod_fee"];
    _netAmount = json["net_amount"];
    _codType = json["cod_type"];
    _payType = json["pay_type"];
  }

}