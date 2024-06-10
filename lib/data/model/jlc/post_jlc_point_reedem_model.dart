class PostJlcPointReedemModel {
  PostJlcPointReedemModel({
    List<JlcPointReedem>? data,
  }) {
    _data = data;
  }

  PostJlcPointReedemModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(JlcPointReedem.fromJson(v));
      });
    }
  }

  List<JlcPointReedem>? _data;

  PostJlcPointReedemModel copyWith({
    List<JlcPointReedem>? data,
  }) =>
      PostJlcPointReedemModel(
        data: data ?? _data,
      );

  List<JlcPointReedem>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class JlcPointReedem {
  JlcPointReedem({
    String? noPenukaran,
    String? tglPenukaran,
    dynamic jmlHadiah,
    String? penukaranPoint,
    String? status,
  }) {
    _noPenukaran = noPenukaran;
    _tglPenukaran = tglPenukaran;
    _jmlHadiah = jmlHadiah;
    _penukaranPoint = penukaranPoint;
    _status = status;
  }

  JlcPointReedem.fromJson(dynamic json) {
    _noPenukaran = json['no_penukaran'];
    _tglPenukaran = json['tgl_penukaran'];
    _jmlHadiah = json['jml_hadiah'];
    _penukaranPoint = json['penukaran_point'];
    _status = json['status'];
  }

  String? _noPenukaran;
  String? _tglPenukaran;
  dynamic _jmlHadiah;
  String? _penukaranPoint;
  String? _status;

  JlcPointReedem copyWith({
    String? noPenukaran,
    String? tglPenukaran,
    dynamic jmlHadiah,
    String? penukaranPoint,
    String? status,
  }) =>
      JlcPointReedem(
        noPenukaran: noPenukaran ?? _noPenukaran,
        tglPenukaran: tglPenukaran ?? _tglPenukaran,
        jmlHadiah: jmlHadiah ?? _jmlHadiah,
        penukaranPoint: penukaranPoint ?? _penukaranPoint,
        status: status ?? _status,
      );

  String? get noPenukaran => _noPenukaran;

  String? get tglPenukaran => _tglPenukaran;

  dynamic get jmlHadiah => _jmlHadiah;

  String? get penukaranPoint => _penukaranPoint;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['no_penukaran'] = _noPenukaran;
    map['tgl_penukaran'] = _tglPenukaran;
    map['jml_hadiah'] = _jmlHadiah;
    map['penukaran_point'] = _penukaranPoint;
    map['status'] = _status;
    return map;
  }
}
