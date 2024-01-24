import 'dart:convert';

GetCodFeeModel getCodFeeModelFromJson(String str) => GetCodFeeModel.fromJson(json.decode(str));

String getCodFeeModelToJson(GetCodFeeModel data) => json.encode(data.toJson());

class GetCodFeeModel {
  GetCodFeeModel({
    num? code,
    String? message,
    CODFeeModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetCodFeeModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? CODFeeModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  CODFeeModel? _payload;

  GetCodFeeModel copyWith({
    num? code,
    String? message,
    CODFeeModel? payload,
  }) =>
      GetCodFeeModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  CODFeeModel? get payload => _payload;

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

CODFeeModel payloadFromJson(String str) => CODFeeModel.fromJson(json.decode(str));

String payloadToJson(CODFeeModel data) => json.encode(data.toJson());

class CODFeeModel {
  CODFeeModel({
    String? code,
    num? disc,
  }) {
    _code = code;
    _disc = disc;
  }

  CODFeeModel.fromJson(dynamic json) {
    _code = json['code'];
    _disc = json['disc'];
  }

  String? _code;
  num? _disc;

  CODFeeModel copyWith({
    String? code,
    num? disc,
  }) =>
      CODFeeModel(
        code: code ?? _code,
        disc: disc ?? _disc,
      );

  String? get code => _code;

  num? get disc => _disc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['disc'] = _disc;
    return map;
  }
}
