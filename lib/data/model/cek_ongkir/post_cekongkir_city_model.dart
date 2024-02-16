class PostCekongkirCityModel {
  PostCekongkirCityModel({
    List<City>? detail,
  }) {
    _detail = detail;
  }

  PostCekongkirCityModel.fromJson(dynamic json) {
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(City.fromJson(v));
      });
    }
    if (json['payload'] != null) {
      _detail = [];
      json['payload'].forEach((v) {
        _detail?.add(City.fromJson(v));
      });
    }
  }

  List<City>? _detail;

  PostCekongkirCityModel copyWith({
    List<City>? detail,
  }) =>
      PostCekongkirCityModel(
        detail: detail ?? _detail,
      );

  List<City>? get detail => _detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    if (_detail != null) {
      map['payload'] = _detail?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class City {
  City({
    String? code,
    String? label,
  }) {
    _code = code;
    _label = label;
  }

  City.fromJson(dynamic json) {
    _code = json['code'];
    _label = json['label'];
  }

  String? _code;
  String? _label;

  City copyWith({
    String? code,
    String? label,
  }) =>
      City(
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
