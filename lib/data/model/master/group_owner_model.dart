class GroupOwnerModel {
  GroupOwnerModel({
    String? groupownerId,
    String? groupownerName,
    String? groupownerDefaultorigin,
    String? groupownerOrigin,
    String? groupownerCreateddate,
    String? groupownerCounter,
  }) {
    _groupownerId = groupownerId;
    _groupownerName = groupownerName;
    _groupownerDefaultorigin = groupownerDefaultorigin;
    _groupownerOrigin = groupownerOrigin;
    _groupownerCreateddate = groupownerCreateddate;
    _groupownerCounter = groupownerCounter;
  }

  GroupOwnerModel.fromJson(dynamic json) {
    _groupownerId = json['groupownerId'];
    _groupownerName = json['groupownerName'];
    _groupownerDefaultorigin = json['groupownerDefaultorigin'];
    _groupownerOrigin = json['groupownerOrigin'];
    _groupownerCreateddate = json['groupownerCreateddate'];
    _groupownerCounter = json['groupownerCounter'];
  }

  String? _groupownerId;
  String? _groupownerName;
  String? _groupownerDefaultorigin;
  String? _groupownerOrigin;
  String? _groupownerCreateddate;
  String? _groupownerCounter;

  GroupOwnerModel copyWith({
    String? groupownerId,
    String? groupownerName,
    String? groupownerDefaultorigin,
    String? groupownerOrigin,
    String? groupownerCreateddate,
    String? groupownerCounter,
  }) =>
      GroupOwnerModel(
        groupownerId: groupownerId ?? _groupownerId,
        groupownerName: groupownerName ?? _groupownerName,
        groupownerDefaultorigin: groupownerDefaultorigin ?? _groupownerDefaultorigin,
        groupownerOrigin: groupownerOrigin ?? _groupownerOrigin,
        groupownerCreateddate: groupownerCreateddate ?? _groupownerCreateddate,
        groupownerCounter: groupownerCounter ?? _groupownerCounter,
      );

  String? get groupownerId => _groupownerId;

  String? get groupownerName => _groupownerName;

  String? get groupownerDefaultorigin => _groupownerDefaultorigin;

  String? get groupownerOrigin => _groupownerOrigin;

  String? get groupownerCreateddate => _groupownerCreateddate;

  String? get groupownerCounter => _groupownerCounter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['groupownerId'] = _groupownerId;
    map['groupownerName'] = _groupownerName;
    map['groupownerDefaultorigin'] = _groupownerDefaultorigin;
    map['groupownerOrigin'] = _groupownerOrigin;
    map['groupownerCreateddate'] = _groupownerCreateddate;
    map['groupownerCounter'] = _groupownerCounter;
    return map;
  }
}
