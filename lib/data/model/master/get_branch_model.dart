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
    _regional = regional;
  }

  BranchModel.fromJson(dynamic json) {
    _branchCode = json['branchCode'];
    _branchDesc = json['branchDesc'];
    _regionalCode = json['regionalCode'];
    _regional = json['regional'] != null
        ? RegionModel.fromJson(json['regional'])
        : null;
  }

  String? _branchCode;
  String? _branchDesc;
  String? _regionalCode;
  RegionModel? _regional;

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
        region: regional ?? _regional,
      );

  String? get branchCode => _branchCode;

  String? get branchDesc => _branchDesc;

  String? get regionalCode => _regionalCode;

  RegionModel? get regional => _regional;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['branchCode'] = _branchCode;
    map['branchDesc'] = _branchDesc;
    map['regionalCode'] = _regionalCode;
    if (_regional != null) {
      map['regional'] = _regional?.toJson();
    }
    return map;
  }
}
