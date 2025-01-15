import 'get_branch_model.dart';

class OriginModel {
  OriginModel({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    BranchModel? branch,
  }) {
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
    _originStatus = originStatus;
    _branch = branch;
  }

  OriginModel.fromJson(dynamic json) {
    _originCode = json['originCode'] ?? json['code'];
    _originName = json['originName'];
    _branchCode = json['branchCode'];
    _originStatus = json['originStatus'];
    _branch = json['branch'] != null
        ? BranchModel.fromJson(json['branch'])
        : BranchModel();
  }

  String? _originCode;
  String? _originName;
  String? _branchCode;
  String? _originStatus;
  BranchModel? _branch;

  OriginModel copyWith({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    BranchModel? branch,
  }) =>
      OriginModel(
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

  BranchModel? get branch => _branch;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['originCode'] = _originCode;
    map['code'] = _originCode;
    map['originName'] = _originName;
    map['branchCode'] = _branchCode;
    map['originStatus'] = _originStatus;
    if (_branch != null) {
      map['branch'] = _branch?.toJson();
    }

    return map;
  }
}
