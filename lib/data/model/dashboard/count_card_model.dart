class PropertySummary {
  PropertySummary({
    this.countCardModel,
    // this.totalKirimanCod,
  });

  PropertySummary.fromJson(Map<String, dynamic> json) {
    if (json['summary'] != null) {
      countCardModel = (json['summary'] as List<dynamic>)
          .map((item) => CountCardModel1.fromJson(item as Map<String, dynamic>))
          .toList();
    }
    // totalKirimanCod = TotalKirimanCodModel.fromJson(json['totalKirimanCod']);
  }

  List<CountCardModel1>? countCardModel;
  // TotalKirimanCodModel? totalKirimanCod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countCardModel != null) {
      map['summary'] = countCardModel!.map((e) => e.toJson()).toList();
    }
    // if (totalKirimanCod != null) {
    //   map['totalKirimanCod'] = totalKirimanCod!.toJson();
    // }
    return map;
  }
}

class TotalKirimanCodModel {
  TotalKirimanCodModel({
    this.totalCod,
    this.totalNonCod,
    this.totalCodOngkir,
    this.codAmount,
    this.codOngkirAmount,
  });

  TotalKirimanCodModel.fromJson(Map<String, dynamic> json) {
    totalCod = json['totalCod'];
    totalNonCod = json['totalNonCod'];
    totalCodOngkir = json['totalCodOngkir'];
    codAmount = json['codAmount'];
    codOngkirAmount = json['codOngkirAmount'];
  }

  num? totalCod;
  num? totalNonCod;
  num? totalCodOngkir;
  num? codAmount;
  num? codOngkirAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCod'] = totalCod;
    map['totalNonCod'] = totalNonCod;
    map['totalCodOngkir'] = totalCodOngkir;
    map['codAmount'] = codAmount;
    map['codOngkirAmount'] = codOngkirAmount;
    return map;
  }
}

class CountCardModel1 {
  CountCardModel1({
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

  CountCardModel1.fromJson(dynamic json) {
    _title = json['status'];
    _img = json['image'];
    _route = json['status'];
    _count = json['total'];
    _cod = json['totalCod'];
    _nonCod = json['totalNonCod'];
    _codOngkir = json['totalCodOngkir'];
  }
  String? _title;
  String? _img;
  String? _route;
  num? _count;
  num? _cod;
  num? _nonCod;
  num? _codOngkir;
  CountCardModel1 copyWith({
    String? title,
    String? img,
    String? route,
    num? count,
    num? cod,
    num? nonCod,
    num? codOngkir,
  }) =>
      CountCardModel1(
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
