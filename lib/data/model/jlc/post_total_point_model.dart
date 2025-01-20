class JLCTotalPointModel {
  JLCTotalPointModel({
    String? totalTransaksi,
    String? sisaPoint,
  }) {
    _totalTransaksi = totalTransaksi;
    _sisaPoint = sisaPoint;
  }

  JLCTotalPointModel.fromJson(dynamic json) {
    _totalTransaksi = json['totalTransaksi'];
    _sisaPoint = json['sisaPoint'];
  }

  String? _totalTransaksi;
  String? _sisaPoint;

  JLCTotalPointModel copyWith({
    String? totalTransaksi,
    String? sisaPoint,
  }) =>
      JLCTotalPointModel(
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
