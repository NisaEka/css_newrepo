class CountCardModel {
  CountCardModel({
    String? title,
    String? img,
    String? route,
    num? count,
    num? cod,
    num? nonCod,
    num? codOngkir,
  }) {
    _title = title;
    _img = img;
    _route = route;
    _count = count;
    _cod = cod;
    _nonCod = nonCod;
    _codOngkir = codOngkir;
  }

  CountCardModel.fromJson(dynamic json) {
    _title = json['title'];
    _img = json['image'];
    _route = json['route'];
    _count = json['count'];
    _cod = json['cod'];
    _nonCod = json['non_cod'];
    _codOngkir = json['cod_ongkir'];
  }
  String? _title;
  String? _img;
  String? _route;
  num? _count;
  num? _cod;
  num? _nonCod;
  num? _codOngkir;
  CountCardModel copyWith({
    String? title,
    String? img,
    String? route,
    num? count,
    num? cod,
    num? nonCod,
    num? codOngkir,
  }) =>
      CountCardModel(
        title: title ?? _title,
        img: img ?? _img,
        route: route ?? _route,
        count: count ?? _count,
        cod: cod ?? _cod,
        nonCod: nonCod ?? _nonCod,
        codOngkir: codOngkir ?? _codOngkir,
      );
  String? get title => _title;
  String? get img => _img;
  String? get route => _route;
  num? get count => _count;
  num? get cod => _cod;
  num? get nonCod => _nonCod;
  num? get codOngkir => _codOngkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['image'] = _img;
    map['route'] = _route;
    map['count'] = _count;
    map['cod'] = _cod;
    map['non_cod'] = _nonCod;
    map['cod_ongkir'] = _codOngkir;
    return map;
  }
}
