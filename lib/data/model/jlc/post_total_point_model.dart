class PostTotalPointModel {
  PostTotalPointModel({
    int? statusCode,
    List<Data>? data,
  }) {
    _statusCode = statusCode;
    _data = data;
  }

  PostTotalPointModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  int? _statusCode;
  List<Data>? _data;

  PostTotalPointModel copyWith({
    int? statusCode,
    List<Data>? data,
  }) =>
      PostTotalPointModel(
        statusCode: statusCode ?? _statusCode,
        data: data ?? _data,
      );

  int? get statusCode => _statusCode;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data({
    String? totalTransaksi,
    String? sisaPoint,
  }) {
    _totalTransaksi = totalTransaksi;
    _sisaPoint = sisaPoint;
  }

  Data.fromJson(dynamic json) {
    _totalTransaksi = json['totalTransaksi'];
    _sisaPoint = json['sisaPoint'];
  }

  String? _totalTransaksi;
  String? _sisaPoint;

  Data copyWith({
    String? totalTransaksi,
    String? sisaPoint,
  }) =>
      Data(
        totalTransaksi: totalTransaksi ?? _totalTransaksi,
        sisaPoint: sisaPoint ?? _sisaPoint,
      );

  String? get totalTransaksi => _totalTransaksi;

  String? get sisaPoint => _sisaPoint;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalTransaksi'] = _totalTransaksi;
    map['sisaPoint'] = _sisaPoint;
    return map;
  }
}
