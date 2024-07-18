class GetNotificationModel {
  GetNotificationModel({
    num? code,
    String? message,
    List<NotificationModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetNotificationModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(NotificationModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<NotificationModel>? _payload;

  GetNotificationModel copyWith({
    num? code,
    String? message,
    List<NotificationModel>? payload,
  }) =>
      GetNotificationModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<NotificationModel>? get payload => _payload;

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

class NotificationModel {
  NotificationModel({
    String? id,
    String? region,
    String? branch,
    String? origin,
    String? category,
    String? text,
    String? startDate,
    String? endDate,
    String? status,
    String? createBy,
    String? createDate,
    String? img,
    String? title,
    bool? isRead,
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
    _createBy = createBy;
    _createDate = createDate;
    _img = img;
    _title = title;
    _isRead = isRead;
  }

  NotificationModel.fromJson(dynamic json) {
    _id = json['id'];
    _region = json['region'];
    _branch = json['branch'];
    _origin = json['origin'];
    _category = json['category'];
    _text = json['text'];
    _startDate = json['start_date'];
    _endDate = json['end_date'];
    _status = json['status'];
    _createBy = json['create_by'];
    _createDate = json['create_date'];
    _img = json['img'];
    _title = json['title'];
    _isRead = json['is_read'] ?? false;
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
  String? _createBy;
  String? _createDate;
  String? _img;
  String? _title;
  bool? _isRead;

  NotificationModel copyWith({
    String? id,
    String? region,
    String? branch,
    String? origin,
    String? category,
    String? text,
    String? startDate,
    String? endDate,
    String? status,
    String? createBy,
    String? createDate,
    String? img,
    String? title,
    bool? isRead,
  }) =>
      NotificationModel(
        id: id ?? _id,
        region: region ?? _region,
        branch: branch ?? _branch,
        origin: origin ?? _origin,
        category: category ?? _category,
        text: text ?? _text,
        startDate: startDate ?? _startDate,
        endDate: endDate ?? _endDate,
        status: status ?? _status,
        createBy: createBy ?? _createBy,
        createDate: createDate ?? _createDate,
        img: img ?? _img,
        title: title ?? _title,
        isRead: isRead ?? _isRead,
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

  String? get createBy => _createBy;

  String? get createDate => _createDate;

  String? get img => _img;

  String? get title => _title;

  bool? get isRead => _isRead;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['region'] = _region;
    map['branch'] = _branch;
    map['origin'] = _origin;
    map['category'] = _category;
    map['text'] = _text;
    map['start_date'] = _startDate;
    map['end_date'] = _endDate;
    map['status'] = _status;
    map['create_by'] = _createBy;
    map['create_date'] = _createDate;
    map['img'] = _img;
    map['title'] = _title;
    map['isRead'] = _isRead;
    return map;
  }
}
