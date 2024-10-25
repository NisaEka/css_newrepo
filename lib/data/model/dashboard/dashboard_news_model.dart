class DashboardNewsModel {
  DashboardNewsModel({
    num? status,
    bool? error,
    List<NewsModel>? message,
  }) {
    _status = status;
    _error = error;
    _message = message;
  }

  DashboardNewsModel.fromJson(dynamic json) {
    _status = json['status'];
    _error = json['error'];
    if (json['message'] != null) {
      _message = [];
      json['message'].forEach((v) {
        _message?.add(NewsModel.fromJson(v));
      });
    }
  }
  num? _status;
  bool? _error;
  List<NewsModel>? _message;
  DashboardNewsModel copyWith({
    num? status,
    bool? error,
    List<NewsModel>? message,
  }) =>
      DashboardNewsModel(
        status: status ?? _status,
        error: error ?? _error,
        message: message ?? _message,
      );
  num? get status => _status;
  bool? get error => _error;
  List<NewsModel>? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['error'] = _error;
    if (_message != null) {
      map['message'] = _message?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class NewsModel {
  NewsModel({
    String? id,
    String? date,
    String? thumbnail,
    String? createdAt,
    String? updatedAt,
    List<Detail>? detail,
  }) {
    _id = id;
    _date = date;
    _thumbnail = thumbnail;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _detail = detail;
  }

  NewsModel.fromJson(dynamic json) {
    _id = json['id'];
    _date = json['date'];
    _thumbnail = json['thumbnail'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    if (json['detail'] != null) {
      _detail = [];
      json['detail'].forEach((v) {
        _detail?.add(Detail.fromJson(v));
      });
    }
  }
  String? _id;
  String? _date;
  String? _thumbnail;
  String? _createdAt;
  String? _updatedAt;
  List<Detail>? _detail;
  NewsModel copyWith({
    String? id,
    String? date,
    String? thumbnail,
    String? createdAt,
    String? updatedAt,
    List<Detail>? detail,
  }) =>
      NewsModel(
        id: id ?? _id,
        date: date ?? _date,
        thumbnail: thumbnail ?? _thumbnail,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        detail: detail ?? _detail,
      );
  String? get id => _id;
  String? get date => _date;
  String? get thumbnail => _thumbnail;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  List<Detail>? get detail => _detail;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['date'] = _date;
    map['thumbnail'] = _thumbnail;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_detail != null) {
      map['detail'] = _detail?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Detail {
  Detail({
    String? baseId,
    String? lang,
    String? title,
    dynamic intro,
    dynamic description,
    String? externalLink,
  }) {
    _baseId = baseId;
    _lang = lang;
    _title = title;
    _intro = intro;
    _description = description;
    _externalLink = externalLink;
  }

  Detail.fromJson(dynamic json) {
    _baseId = json['base_id'];
    _lang = json['lang'];
    _title = json['title'];
    _intro = json['intro'];
    _description = json['description'];
    _externalLink = json['external_link'];
  }
  String? _baseId;
  String? _lang;
  String? _title;
  dynamic _intro;
  dynamic _description;
  String? _externalLink;
  Detail copyWith({
    String? baseId,
    String? lang,
    String? title,
    dynamic intro,
    dynamic description,
    String? externalLink,
  }) =>
      Detail(
        baseId: baseId ?? _baseId,
        lang: lang ?? _lang,
        title: title ?? _title,
        intro: intro ?? _intro,
        description: description ?? _description,
        externalLink: externalLink ?? _externalLink,
      );
  String? get baseId => _baseId;
  String? get lang => _lang;
  String? get title => _title;
  dynamic get intro => _intro;
  dynamic get description => _description;
  String? get externalLink => _externalLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['base_id'] = _baseId;
    map['lang'] = _lang;
    map['title'] = _title;
    map['intro'] = _intro;
    map['description'] = _description;
    map['external_link'] = _externalLink;
    return map;
  }
}
