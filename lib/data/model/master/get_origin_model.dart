import 'get_region_model.dart';

class Origin {
  Origin({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    OriginBranch? branch,
  }) {
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
    _originStatus = originStatus;
    _branch = branch;
  }

  Origin.fromJson(dynamic json) {
    _originCode = json['originCode'] ?? json['code'];
    _originName = json['originName'];
    _branchCode = json['branchCode'] ?? json['branch'];
    _originStatus = json['originStatus'];
    _branch = json['branch'] != null ? OriginBranch.fromJson(json['branch']) : null;
  }

  String? _originCode;
  String? _originName;
  String? _branchCode;
  String? _originStatus;
  OriginBranch? _branch;

  Origin copyWith({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    OriginBranch? branch,
  }) =>
      Origin(
        originCode: originCode ?? _originCode,
        originName: originName ?? _originName,
        branchCode: branchCode ?? _branchCode,
        originStatus: originStatus ?? _originStatus,
        branch: branch ?? _branch,
      );

  String? get originCode => _originCode;

  String? get originName => _originName;

  String? get branchCode => _branchCode;

  String? get originStatus => _originStatus;

  OriginBranch? get branch => _branch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originCode'] = _originCode;
    map['code'] = _originCode;
    map['originName'] = _originName;
    map['branchCode'] = _branchCode;
    map['branch'] = _branchCode;
    map['originStatus'] = _originStatus;
    if (_branch != null) {
      map['branch'] = _branch?.toJson();
    }
    return map;
  }
}

class OriginBranch {
  OriginBranch({
    String? branchDesc,
    String? regionalCode,
    Region? region,
  }) {
    _branchDesc = branchDesc;
    _regionalCode = regionalCode;
    _regional = regional;
  }

  OriginBranch.fromJson(dynamic json) {
    _branchDesc = json['branchDesc'];
    _regionalCode = json['regionalCode'];
    _regional = json['regional'] != null ? Region.fromJson(json['regional']) : null;
  }

  String? _branchDesc;
  String? _regionalCode;
  Region? _regional;

  OriginBranch copyWith({
    String? branchDesc,
    String? regionalCode,
    Region? region,
  }) =>
      OriginBranch(
        branchDesc: branchDesc ?? _branchDesc,
        regionalCode: regionalCode ?? _regionalCode,
        region: regional ?? _regional,
      );

  String? get branchDesc => _branchDesc;

  String? get regionalCode => _regionalCode;

  Region? get regional => _regional;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branchDesc'] = _branchDesc;
    map['regionalCode'] = _regionalCode;
    if (_regional != null) {
      map['regional'] = _regional?.toJson();
    }
    return map;
  }
}
