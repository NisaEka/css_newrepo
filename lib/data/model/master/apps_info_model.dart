class AppsInfoModel {
  AppsInfoModel({
    String? id,
    String? region,
    String? branch,
    String? origin,
    String? category,
    String? text,
    String? startDate,
    String? endDate,
    String? status,
    String? createdBy,
    String? createdDate,
    String? img,
    String? title,
    String? segmen,
  }) {
    _id = id;
    _region = region;
    _branch = branch;
    _origin = origin;
    _category = category;
    _text = text;
    _startDate = startDate;
    _endDate = endDate;
    _status = status;
    _createdBy = createdBy;
    _createdDate = createdDate;
    _img = img;
    _title = title;
    _segment = segmen;
  }

  AppsInfoModel.fromJson(dynamic json) {
    _id = json['infoId'];
    _region = json['infoRegion'];
    _branch = json['infoBranch'];
    _origin = json['infoOrigin'];
    _category = json['infoCategory'];
    _text = json['infoText'];
    _startDate = json['infoStartdate'];
    _endDate = json['infoEnddate'];
    _status = json['infoStatus'];
    _createdBy = json['infoCreatedby'];
    _createdDate = json['infoCreateddate'];
    _img = json['infoImg'];
    _title = json['infoTitle'];
    _segment = json['infoSegment'];
  }

  String? _id;
  String? _region;
  String? _branch;
  String? _origin;
  String? _category;
  String? _text;
  String? _startDate;
  String? _endDate;
  String? _status;
  String? _createdBy;
  String? _createdDate;
  String? _img;
  String? _title;
  String? _segment;

  AppsInfoModel copyWith({
    String? id,
    String? region,
    String? branch,
    String? origin,
    String? category,
    String? text,
    String? startDate,
    String? endDate,
    String? status,
    String? createdBy,
    String? createdDate,
    String? img,
    String? title,
    String? segmen,
  }) =>
      AppsInfoModel(
        id: id ?? _id,
        region: region ?? _region,
        branch: branch ?? _branch,
        origin: origin ?? _origin,
        category: category ?? _category,
        text: text ?? _text,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        status: status ?? _status,
        createdBy: createdBy ?? _createdBy,
        createdDate: createdDate ?? _createdDate,
        img: img ?? _img,
        title: title ?? _title,
        segmen: segmen ?? _segment,
      );

  String? get id => _id;

  String? get region => _region;

  String? get branch => _branch;

  String? get origin => _origin;

  String? get category => _category;

  String? get text => _text;

  String? get startDate => _startDate;

  String? get endDate => _endDate;

  String? get status => _status;

  String? get createdBy => _createdBy;

  String? get createdDate => _createdDate;

  String? get img => _img;

  String? get title => _title;

  String? get segment => _segment;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['infoId'] = _id;
    map['infoRegion'] = _region;
    map['infoBranch'] = _branch;
    map['infoOrigin'] = _origin;
    map['infoCategory'] = _category;
    map['infoText'] = _text;
    map['infoStartdate'] = _startDate;
    map['infoEnddate'] = _endDate;
    map['infoStatus'] = _status;
    map['infoCreatedby'] = _createdBy;
    map['infoCreateddate'] = _createdDate;
    map['infoImg'] = _img;
    map['infoTitle'] = _title;
    map['infoSegment'] = _segment;
    return map;
  }
}
