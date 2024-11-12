class TransactionSummaryModel {
  TransactionSummaryModel({
    List<CountCardModel>? summary,
    TotalKirimanCod? totalKirimanCod,
  }) {
    _summary = summary;
    _totalKirimanCod = totalKirimanCod;
  }

  TransactionSummaryModel.fromJson(dynamic json) {
    if (json['summary'] != null) {
      _summary = [];
      json['summary'].forEach((v) {
        _summary?.add(CountCardModel.fromJson(v));
      });
    }
    _totalKirimanCod = json['totalKirimanCod'] != null ? TotalKirimanCod.fromJson(json['totalKirimanCod']) : null;
  }

  List<CountCardModel>? _summary;
  TotalKirimanCod? _totalKirimanCod;

  TransactionSummaryModel copyWith({
    List<CountCardModel>? summary,
    TotalKirimanCod? totalKirimanCod,
  }) =>
      TransactionSummaryModel(
        summary: summary ?? _summary,
        totalKirimanCod: totalKirimanCod ?? _totalKirimanCod,
      );

  List<CountCardModel>? get summary => _summary;

  TotalKirimanCod? get totalKirimanCod => _totalKirimanCod;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_summary != null) {
      map['summary'] = _summary?.map((v) => v.toJson()).toList();
    }
    if (_totalKirimanCod != null) {
      map['totalKirimanCod'] = _totalKirimanCod?.toJson();
    }
    return map;
  }
}

class TotalKirimanCod {
  TotalKirimanCod({
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    num? codAmount,
    num? codOngkirAmount,
  }) {
    _totalCod = totalCod;
    _totalNonCod = totalNonCod;
    _totalCodOngkir = totalCodOngkir;
    _codAmount = codAmount;
    _codOngkirAmount = codOngkirAmount;
  }

  TotalKirimanCod.fromJson(dynamic json) {
    _totalCod = json['totalCod'];
    _totalNonCod = json['totalNonCod'];
    _totalCodOngkir = json['totalCodOngkir'];
    _codAmount = json['codAmount'];
    _codOngkirAmount = json['codOngkirAmount'];
  }

  num? _totalCod;
  num? _totalNonCod;
  num? _totalCodOngkir;
  num? _codAmount;
  num? _codOngkirAmount;

  TotalKirimanCod copyWith({
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
    num? codAmount,
    num? codOngkirAmount,
  }) =>
      TotalKirimanCod(
        totalCod: totalCod ?? _totalCod,
        totalNonCod: totalNonCod ?? _totalNonCod,
        totalCodOngkir: totalCodOngkir ?? _totalCodOngkir,
        codAmount: codAmount ?? _codAmount,
        codOngkirAmount: codOngkirAmount ?? _codOngkirAmount,
      );

  num? get totalCod => _totalCod;

  num? get totalNonCod => _totalNonCod;

  num? get totalCodOngkir => _totalCodOngkir;

  num? get codAmount => _codAmount;

  num? get codOngkirAmount => _codOngkirAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCod'] = _totalCod;
    map['totalNonCod'] = _totalNonCod;
    map['totalCodOngkir'] = _totalCodOngkir;
    map['codAmount'] = _codAmount;
    map['codOngkirAmount'] = _codOngkirAmount;
    return map;
  }
}

class CountCardModel {
  CountCardModel({
    String? status,
    String? image,
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
  }) {
    _status = status;
    _image = image;
    _total = total;
    _totalCod = totalCod;
    _totalNonCod = totalNonCod;
    _totalCodOngkir = totalCodOngkir;
  }

  CountCardModel.fromJson(dynamic json) {
    _status = json['status'];
    _image = json['image'];
    _total = json['total'];
    _totalCod = json['totalCod'];
    _totalNonCod = json['totalNonCod'];
    _totalCodOngkir = json['totalCodOngkir'];
  }

  String? _status;
  String? _image;
  num? _total;
  num? _totalCod;
  num? _totalNonCod;
  num? _totalCodOngkir;

  CountCardModel copyWith({
    String? status,
    String? image,
    num? total,
    num? totalCod,
    num? totalNonCod,
    num? totalCodOngkir,
  }) =>
      CountCardModel(
        status: status ?? _status,
        image: image ?? _image,
        total: total ?? _total,
        totalCod: totalCod ?? _totalCod,
        totalNonCod: totalNonCod ?? _totalNonCod,
        totalCodOngkir: totalCodOngkir ?? _totalCodOngkir,
      );

  String? get status => _status;

  String? get image => _image;

  num? get total => _total;

  num? get totalCod => _totalCod;

  num? get totalNonCod => _totalNonCod;

  num? get totalCodOngkir => _totalCodOngkir;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['image'] = _image;
    map['total'] = _total;
    map['totalCod'] = _totalCod;
    map['totalNonCod'] = _totalNonCod;
    map['totalCodOngkir'] = _totalCodOngkir;
    return map;
  }
}
