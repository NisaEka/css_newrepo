class PostJlcTotalPointModel {
  PostJlcTotalPointModel({
      bool? status, 
      String? error, 
      List<Data>? data,}){
    _status = status;
    _error = error;
    _data = data;
}

  PostJlcTotalPointModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _error;
  List<Data>? _data;
PostJlcTotalPointModel copyWith({  bool? status,
  String? error,
  List<Data>? data,
}) => PostJlcTotalPointModel(  status: status ?? _status,
  error: error ?? _error,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get error => _error;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error'] = _error;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data {
  Data({
      String? totalTransaksi, 
      String? sisaPoint,}){
    _totalTransaksi = totalTransaksi;
    _sisaPoint = sisaPoint;
}

  Data.fromJson(dynamic json) {
    _totalTransaksi = json['total_transaksi'];
    _sisaPoint = json['sisa_point'];
  }
  String? _totalTransaksi;
  String? _sisaPoint;
Data copyWith({  String? totalTransaksi,
  String? sisaPoint,
}) => Data(  totalTransaksi: totalTransaksi ?? _totalTransaksi,
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