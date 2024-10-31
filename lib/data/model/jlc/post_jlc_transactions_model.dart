class PostJlcTransactionsModel {
  PostJlcTransactionsModel({
    List<JLCTransactions>? data,
  }) {
    _data = data;
  }

  PostJlcTransactionsModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JLCTransactions.fromJson(v));
      });
    }
  }

  List<JLCTransactions>? _data;

  PostJlcTransactionsModel copyWith({
    List<JLCTransactions>? data,
  }) =>
      PostJlcTransactionsModel(
        data: data ?? _data,
      );

  List<JLCTransactions>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class JLCTransactions {
  JLCTransactions({
    String? tglTransaksi,
    String? noConnote,
    String? jmlTransaksi,
    String? point,
    String? status,
  }) {
    _tglTransaksi = tglTransaksi;
    _noConnote = noConnote;
    _jmlTransaksi = jmlTransaksi;
    _point = point;
    _status = status;
  }

  JLCTransactions.fromJson(dynamic json) {
    _tglTransaksi = json['tglTransaksi'];
    _noConnote = json['noConnote'];
    _jmlTransaksi = json['jmlTransaksi'];
    _point = json['point'];
    _status = json['status'];
  }

  String? _tglTransaksi;
  String? _noConnote;
  String? _jmlTransaksi;
  String? _point;
  String? _status;

  JLCTransactions copyWith({
    String? tglTransaksi,
    String? noConnote,
    String? jmlTransaksi,
    String? point,
    String? status,
  }) =>
      JLCTransactions(
        tglTransaksi: tglTransaksi ?? _tglTransaksi,
        noConnote: noConnote ?? _noConnote,
        jmlTransaksi: jmlTransaksi ?? _jmlTransaksi,
        point: point ?? _point,
        status: status ?? _status,
      );

  String? get tglTransaksi => _tglTransaksi;

  String? get noConnote => _noConnote;

  String? get jmlTransaksi => _jmlTransaksi;

  String? get point => _point;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['tglTransaksi'] = _tglTransaksi;
    map['noConnote'] = _noConnote;
    map['jmlTransaksi'] = _jmlTransaksi;
    map['point'] = _point;
    map['status'] = _status;
    return map;
  }
}
