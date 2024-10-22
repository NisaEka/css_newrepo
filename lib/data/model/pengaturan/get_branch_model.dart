class GetBranchModel {
  GetBranchModel({
    num? code,
    String? message,
    List<Branch>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetBranchModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(Branch.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<Branch>? _payload;

  GetBranchModel copyWith({
    num? code,
    String? message,
    List<Branch>? payload,
  }) =>
      GetBranchModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<Branch>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Branch {
  Branch({
    String? code,
    String? desc,
    String? regionalCode,
  }) {
    _code = code;
    _desc = desc;
    _regionalCode = regionalCode;
  }

  Branch.fromJson(dynamic json) {
    _code = json['code'] ?? json['branchCode'];
    _desc = json['desc'] ?? json['branchDesc'];
    _regionalCode = json['regional_code'] ?? json['regionalCode'];
  }

  String? _code;
  String? _desc;
  String? _regionalCode;

  Branch copyWith({
    String? code,
    String? desc,
    String? regionalCode,
  }) =>
      Branch(
        code: code ?? _code,
        desc: desc ?? _desc,
        regionalCode: regionalCode ?? _regionalCode,
      );

  String? get code => _code;

  String? get desc => _desc;

  String? get regionalCode => _regionalCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['desc'] = _desc;
    map['regional_code'] = _regionalCode;
    map['branchCode'] = _code;
    map['branchDesc'] = _desc;
    map['regionalCode'] = _regionalCode;
    return map;
  }
}
