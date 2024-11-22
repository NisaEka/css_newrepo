class EclaimModel {
  EclaimModel({
    String? awb,
    String? kategori,
    String? valueclaim,
    String? statusClaim,
    String? isipesan,
    String? fileClaim,
    String? id,
    String? createDate,
  }) {
    _awb = awb;
    _kategori = kategori;
    _valueclaim = valueclaim;
    _statusClaim = statusClaim;
    _isipesan = isipesan;
    _fileClaim = fileClaim;
    _id = id;
    _createDate = createDate;
  }

  EclaimModel.fromJson(dynamic json) {
    _awb = json['awb'];
    _kategori = json['kategori'];
    _valueclaim = json['valueclaim'];
    _statusClaim = json['statusClaim'];
    _isipesan = json['isipesan'];
    _fileClaim = json['fileClaim'];
    _id = json['id'];
    _createDate = json['createDate'];
  }

  String? _awb;
  String? _kategori;
  String? _valueclaim;
  String? _statusClaim;
  String? _isipesan;
  String? _fileClaim;
  String? _id;
  String? _createDate;

  EclaimModel copyWith({
    String? awb,
    String? kategori,
    String? valueclaim,
    String? statusClaim,
    String? isipesan,
    String? fileClaim,
    String? id,
    String? createDate,
  }) =>
      EclaimModel(
        awb: awb ?? _awb,
        kategori: kategori ?? _kategori,
        valueclaim: valueclaim ?? _valueclaim,
        statusClaim: statusClaim ?? _statusClaim,
        isipesan: isipesan ?? _isipesan,
        fileClaim: fileClaim ?? _fileClaim,
        id: id ?? _id,
        createDate: createDate ?? _createDate,
      );

  String? get awb => _awb;

  String? get kategori => _kategori;

  String? get valueclaim => _valueclaim;

  String? get statusClaim => _statusClaim;

  String? get isipesan => _isipesan;

  String? get fileClaim => _fileClaim;

  String? get id => _id;

  String? get createDate => _createDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awb'] = _awb;
    map['kategori'] = _kategori;
    map['valueclaim'] = _valueclaim;
    map['statusClaim'] = _statusClaim;
    map['isipesan'] = _isipesan;
    map['fileClaim'] = _fileClaim;
    map['id'] = _id;
    map['createDate'] = _createDate;
    return map;
  }
}
