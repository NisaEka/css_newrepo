import 'dart:convert';

CODFeeModel payloadFromJson(String str) =>
    CODFeeModel.fromJson(json.decode(str));

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
