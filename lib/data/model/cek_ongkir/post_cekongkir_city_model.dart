class CityModel {
  CityModel({
    String? code,
    String? label,
  }) {
    _code = code;
    _label = label;
  }

  CityModel.fromJson(dynamic json) {
    _code = json['code'];
    _label = json['label'];
  }

  String? _code;
  String? _label;

  CityModel copyWith({
    String? code,
    String? label,
  }) =>
      CityModel(
        code: code ?? _code,
        label: label ?? _label,
      );

  String? get code => _code;

  String? get label => _label;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['label'] = _label;
    return map;
  }
}
