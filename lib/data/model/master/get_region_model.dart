import 'dart:convert';

RegionModel regionFromJson(String str) => RegionModel.fromJson(json.decode(str));

String regionToJson(RegionModel data) => json.encode(data.toJson());

class RegionModel {
  RegionModel({
    String? code,
    String? name,
  }) {
    _code = code;
    _name = name;
  }

  RegionModel.fromJson(dynamic json) {
    _code = json['code'] ?? json['regionalCode'];
    _name = json['name'] ?? json['regionalName'];
  }

  String? _code;
  String? _name;

  RegionModel copyWith({
    String? code,
    String? name,
  }) =>
      RegionModel(
        code: code ?? _code,
        name: name ?? _name,
      );

  String? get code => _code;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['name'] = _name;
    map['regionalCode'] = _code;
    map['regionalName'] = _name;
    return map;
  }
}
