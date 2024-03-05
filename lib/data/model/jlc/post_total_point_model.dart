class PostTotalPointModel {
  PostTotalPointModel({
    bool? status,
    List<Data>? data,
  }) {
    _status = status;
    _data = data;
  }

  PostTotalPointModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }

  bool? _status;
  List<Data>? _data;

  PostTotalPointModel copyWith({
    bool? status,
    List<Data>? data,
  }) =>
      PostTotalPointModel(
        status: status ?? _status,
        data: data ?? _data,
      );

  bool? get status => _status;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
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
    _totalTransaksi = json['total_transaksi'];
    _sisaPoint = json['sisa_point'];
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
    map['total_transaksi'] = _totalTransaksi;
    map['sisa_point'] = _sisaPoint;
    return map;
  }
}
