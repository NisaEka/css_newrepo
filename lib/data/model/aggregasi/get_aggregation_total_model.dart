class GetAggregationTotalModel {
  GetAggregationTotalModel({
    num? code,
    String? message,
    AggTotal? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetAggregationTotalModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? AggTotal.fromJson(json['payload']) : AggTotal.fromJson("{'total': 0}");
  }

  num? _code;
  String? _message;
  AggTotal? _payload;

  GetAggregationTotalModel copyWith({
    num? code,
    String? message,
    AggTotal? payload,
  }) =>
      GetAggregationTotalModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  AggTotal? get payload => _payload;

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

class AggTotal {
  AggTotal({
    num? total,
  }) {
    _total = total;
  }

  AggTotal.fromJson(dynamic json) {
    _total = json['total'] ?? 0;
  }

  num? _total;

  AggTotal copyWith({
    num? total,
  }) =>
      AggTotal(
        total: total ?? _total,
      );

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total ?? 0;
    return map;
  }
}
