import 'pantau_count_model.dart';

class CountCardModel {
  CountCardModel({
    String? status,
    String? image,
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    num? codAmount,
    num? codOngkirAmount,
    num? percentageCod,
    num? percentageCodOngkir,
    List<ChartData>? chart,
  }) {
    _status = status;
    _image = image;
    _total = total;
    _totalCod = totalCod;
    _totalNonCod = totalNonCod;
    _totalCodOngkir = totalCodOngkir;
    _codAmount = codAmount;
    _codOngkirAmount = codOngkirAmount;
    _percentageCod = percentageCod;
    _percentageCodOngkir = percentageCodOngkir;
    _chart = chart;
  }

  CountCardModel.fromJson(dynamic json) {
    _status = json['status'];
    _image = json['image'];
    _total = json['total'];
    _totalCod = json['totalCod'];
    _totalNonCod = json['totalNonCod'];
    _totalCodOngkir = json['totalCodOngkir'];
    _codAmount = json['codAmount'];
    _codOngkirAmount = json['codOngkirAmount'];
    _percentageCod = json['percentageCod'];
    _percentageCodOngkir = json['percentageCodOngkir'];
    if (json['chart'] != null) {
      _chart = [];
      json['chart'].forEach((v) {
        _chart?.add(ChartData.fromJson(v));
      });
    }
  }

  String? _status;
  String? _image;
  num? _total;
  num? _totalCod;
  num? _totalNonCod;
  num? _totalCodOngkir;
  num? _codAmount;
  num? _codOngkirAmount;
  num? _percentageCod;
  num? _percentageCodOngkir;
  List<ChartData>? _chart;

  CountCardModel copyWith({
    String? status,
    String? image,
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    num? codAmount,
    num? codOngkirAmount,
    num? percentageCod,
    num? percentageCodOngkir,
    List<ChartData>? chart,
  }) =>
      CountCardModel(
        status: status ?? _status,
        image: image ?? _image,
        total: total ?? _total,
        totalCod: totalCod ?? _totalCod,
        totalNonCod: totalNonCod ?? _totalNonCod,
        totalCodOngkir: totalCodOngkir ?? _totalCodOngkir,
        codAmount: codAmount ?? _codAmount,
        codOngkirAmount: codOngkirAmount ?? _codOngkirAmount,
        percentageCod: percentageCod ?? _percentageCod,
        percentageCodOngkir: percentageCodOngkir ?? _percentageCodOngkir,
        chart: chart ?? _chart,
      );

  String? get status => _status;

  String? get image => _image;

  num? get total => _total;

  num? get totalCod => _totalCod;

  num? get totalNonCod => _totalNonCod;

  num? get totalCodOngkir => _totalCodOngkir;

  num? get codAmount => _codAmount;

  num? get codOngkirAmount => _codOngkirAmount;

  num? get percentageCod => _percentageCod;

  num? get percentageCodOngkir => _percentageCodOngkir;

  List<ChartData>? get chart => _chart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['image'] = _image;
    map['total'] = _total;
    map['totalCod'] = _totalCod;
    map['totalNonCod'] = _totalNonCod;
    map['totalCodOngkir'] = _totalCodOngkir;
    map['codAmount'] = _codAmount;
    map['codOngkirAmount'] = _codOngkirAmount;
    map['percentageCod'] = _percentageCod;
    map['percentageCodOngkir'] = _percentageCodOngkir;
    if (_chart != null) {
      map['chart'] = _chart?.map((v) => v.toJson()).toList();
    }

    return map;
  }
}
