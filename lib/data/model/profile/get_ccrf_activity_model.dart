class CcrfActivityModel {
  CcrfActivityModel({
    String? activityId,
    String? activityName,
    String? activityBy,
    String? activityStatus,
    String? activityDescription,
    String? activityNote,
    String? activityCreateDate,
    String? ccrfId,
    num? feedbackId,
  }) {
    _activityId = activityId;
    _activityName = activityName;
    _activityBy = activityBy;
    _activityStatus = activityStatus;
    _activityDescription = activityDescription;
    _activityNote = activityNote;
    _activityCreateDate = activityCreateDate;
    _ccrfId = ccrfId;
    _feedbackId = feedbackId;
  }

  CcrfActivityModel.fromJson(dynamic json) {
    _activityId = json['activityId'];
    _activityName = json['activityName'];
    _activityBy = json['activityBy'];
    _activityStatus = json['activityStatus'];
    _activityDescription = json['activityDescription'];
    _activityNote = json['activityNote'];
    _activityCreateDate = json['activityCreateDate'];
    _ccrfId = json['ccrfId'];
    _feedbackId = json['feedbackId'];
  }

  String? _activityId;
  String? _activityName;
  String? _activityBy;
  String? _activityStatus;
  String? _activityDescription;
  String? _activityNote;
  String? _activityCreateDate;
  String? _ccrfId;
  num? _feedbackId;

  CcrfActivityModel copyWith({
    String? activityId,
    String? activityName,
    String? activityBy,
    String? activityStatus,
    String? activityDescription,
    String? activityNote,
    String? activityCreateDate,
    String? ccrfId,
    num? feedbackId,
  }) =>
      CcrfActivityModel(
        activityId: activityId ?? _activityId,
        activityName: activityName ?? _activityName,
        activityBy: activityBy ?? _activityBy,
        activityStatus: activityStatus ?? _activityStatus,
        activityDescription: activityDescription ?? _activityDescription,
        activityNote: activityNote ?? _activityNote,
        activityCreateDate: activityCreateDate ?? _activityCreateDate,
        ccrfId: ccrfId ?? _ccrfId,
        feedbackId: feedbackId ?? _feedbackId,
      );

  String? get activityId => _activityId;

  String? get activityName => _activityName;

  String? get activityBy => _activityBy;

  String? get activityStatus => _activityStatus;

  String? get activityDescription => _activityDescription;

  String? get activityNote => _activityNote;

  String? get activityCreateDate => _activityCreateDate;

  String? get ccrfId => _ccrfId;

  num? get feedbackId => _feedbackId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['activityId'] = _activityId;
    map['activityName'] = _activityName;
    map['activityBy'] = _activityBy;
    map['activityStatus'] = _activityStatus;
    map['activityDescription'] = _activityDescription;
    map['activityNote'] = _activityNote;
    map['activityCreateDate'] = _activityCreateDate;
    map['ccrfId'] = _ccrfId;
    map['feedbackId'] = _feedbackId;
    return map;
  }
}
