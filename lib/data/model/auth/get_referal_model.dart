import 'package:css_mobile/data/model/master/get_origin_model.dart';

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
    String? counter,
    String? id,
    String? name,
    String? defaultOrigin,
    OriginModel? origin,
  }) {
    _counter = counter;
    _id = id;
    _name = name;
    _defaultOrigin = defaultOrigin;
    _origin = origin;
  }

  ReferalModel.fromJson(dynamic json) {
    _counter = json['counter'];
    _id = json['id'];
    _name = json['name'];
    _defaultOrigin = json['default_origin'];
    _origin =
        json['origin'] != null ? OriginModel.fromJson(json['origin']) : null;
  }

  String? _counter;
  String? _id;
  String? _name;
  String? _defaultOrigin;
  OriginModel? _origin;

  ReferalModel copyWith({
    String? counter,
    String? id,
    String? name,
    String? defaultOrigin,
    OriginModel? origin,
  }) =>
      ReferalModel(
        counter: counter ?? _counter,
        id: id ?? _id,
        name: name ?? _name,
        defaultOrigin: defaultOrigin ?? _defaultOrigin,
        origin: origin ?? _origin,
      );

  String? get counter => _counter;

  String? get id => _id;

  String? get name => _name;

  String? get defaultOrigin => _defaultOrigin;

  OriginModel? get origin => _origin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['counter'] = _counter;
    map['id'] = _id;
    map['name'] = _name;
    map['default_origin'] = _defaultOrigin;
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    return map;
  }
}
