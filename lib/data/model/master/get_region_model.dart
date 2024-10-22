import 'dart:convert';

Region regionFromJson(String str) => Region.fromJson(json.decode(str));

String regionToJson(Region data) => json.encode(data.toJson());

class Region {
  Region({
    String? code,
    String? name,
  }) {
    _code = code;
    _name = name;
  }

  Region.fromJson(dynamic json) {
    _code = json['code'] ?? json['regionalCode'];
    _name = json['name'] ?? json['regionalName'];
  }

  String? _code;
  String? _name;

  Region copyWith({
    String? code,
    String? name,
  }) =>
      Region(
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
