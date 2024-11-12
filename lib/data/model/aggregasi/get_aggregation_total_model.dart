class GetAggregationTotalModel {
  GetAggregationTotalModel({
    num? statusCode,
    String? message,
    AggTotal? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GetAggregationTotalModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null
        ? AggTotal.fromJson(json['data'])
        : AggTotal.fromJson("{'total': 0}");
  }

  num? _statusCode;
  String? _message;
  AggTotal? _data;

  GetAggregationTotalModel copyWith({
    num? statusCode,
    String? message,
    AggTotal? data,
  }) =>
      GetAggregationTotalModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  AggTotal? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
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
