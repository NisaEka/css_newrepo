import 'package:css_mobile/data/model/master/get_region_model.dart';

class BranchModel {
  BranchModel({
    String? branchCode,
    String? branchDesc,
    String? regionalCode,
    RegionModel? region,
  }) {
    _branchCode = branchCode;
    _branchDesc = branchDesc;
    _regionalCode = regionalCode;
    _region = region;
  }

  BranchModel.fromJson(dynamic json) {
    _branchCode = json['branchCode'];
    _branchDesc = json['branchDesc'];
    _regionalCode = json['regionalCode'];
    _region = json['regional'] != null
        ? RegionModel.fromJson(json['regional'])
        : null;
  }

  String? _branchCode;
  String? _branchDesc;
  String? _regionalCode;
  RegionModel? _region;

  BranchModel copyWith({
    String? branchCode,
    String? branchDesc,
    String? regionalCode,
    RegionModel? region,
  }) =>
      BranchModel(
        branchCode: branchCode ?? _branchCode,
        branchDesc: branchDesc ?? _branchDesc,
        regionalCode: regionalCode ?? _regionalCode,
        region: region ?? _region,
      );

  String? get branchCode => _branchCode;

  String? get branchDesc => _branchDesc;

  String? get regionalCode => _regionalCode;

  RegionModel? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branchCode'] = _branchCode;
    map['branchDesc'] = _branchDesc;
    map['regionalCode'] = _regionalCode;
    if (_region != null) {
      map['regional'] = _region?.toJson();
    }
    return map;
  }
}
