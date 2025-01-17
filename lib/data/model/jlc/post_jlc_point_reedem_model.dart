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
    _noPenukaran = json['noPenukaran'];
    _tglPenukaran = json['tglPenukaran'];
    _jmlHadiah = json['jmlHadiah'];
    _penukaranPoint = json['penukaranPoint'];
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
    map['noPenukaran'] = _noPenukaran;
    map['tglPenukaran'] = _tglPenukaran;
    map['jmlHadiah'] = _jmlHadiah;
    map['penukaranPoint'] = _penukaranPoint;
    map['status'] = _status;
    return map;
  }
}
