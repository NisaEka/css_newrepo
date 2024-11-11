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
