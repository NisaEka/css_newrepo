import 'get_region_model.dart';

class Origin {
  Origin({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    Region? region,
  }) {
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
    _originStatus = originStatus;
    _region = region;
  }

  Origin.fromJson(dynamic json) {
    _originCode = json['origin_code'] ?? json['code'] ?? json['originCode'];
    _originName = json['origin_name'] ??
        json['desc'] ??
        json['label'] ??
        json['originName'];
    _branchCode = json['branch_code'] ?? json['branch'] ?? json['branchCode'];
    _originStatus = json['originStatus'];
    if (json["region"] != null) {
      _region = Region.fromJson(json["region"]);
    }
  }

  String? _originCode;
  String? _originName;
  String? _branchCode;
  String? _originStatus;
  Region? _region;

  Origin copyWith({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
  }) =>
      Origin(
          originCode: originCode ?? _originCode,
          originName: originName ?? _originName,
          branchCode: branchCode ?? _branchCode,
          originStatus: originStatus ?? _originStatus);

  String? get originCode => _originCode;

  String? get originName => _originName;

  String? get branchCode => _branchCode;

  String? get originStatus => _originStatus;

  Region? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_code'] = _originCode;
    map['origin_name'] = _originName;
    map['branch_code'] = _branchCode;
    map['code'] = _originCode;
    map['desc'] = _originName;
    map['label'] = _originName;
    map['branch'] = _branchCode;
    map['originStatus'] = _originStatus;
    map['originCode'] = _originCode;
    map['originName'] = _originName;
    map['branchCode'] = _branchCode;
    return map;
  }
}
