class GetReferalModel {
  GetReferalModel({
    num? code,
    String? message,
    List<ReferalModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetReferalModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(ReferalModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<ReferalModel>? _payload;

  GetReferalModel copyWith({
    num? code,
    String? message,
    List<ReferalModel>? payload,
  }) =>
      GetReferalModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<ReferalModel>? get payload => _payload;

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

class ReferalModel {
  ReferalModel({
    String? id,
    String? name,
    String? defaultOrigin,
    String? origin,
    String? counter,
  }) {
    _id = id;
    _name = name;
    _defaultOrigin = defaultOrigin;
    _origin = origin;
    _counter = counter;
  }

  ReferalModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _defaultOrigin = json['default_origin'];
    _origin = json['origin'];
    _counter = json['counter'];
  }

  String? _id;
  String? _name;
  String? _defaultOrigin;
  String? _origin;
  String? _counter;

  ReferalModel copyWith({
    String? id,
    String? name,
    String? defaultOrigin,
    String? origin,
    String? counter,
  }) =>
      ReferalModel(
        id: id ?? _id,
        name: name ?? _name,
        defaultOrigin: defaultOrigin ?? _defaultOrigin,
        origin: origin ?? _origin,
        counter: counter ?? _counter,
      );

  String? get id => _id;

  String? get name => _name;

  String? get defaultOrigin => _defaultOrigin;

  String? get origin => _origin;

  String? get counter => _counter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['default_origin'] = _defaultOrigin;
    map['origin'] = _origin;
    map['counter'] = _counter;
    return map;
  }
}
