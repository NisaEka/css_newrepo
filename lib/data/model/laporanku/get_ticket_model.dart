class GetTicketModel {
  GetTicketModel({
    num? code,
    String? message,
    List<TicketModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTicketModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(TicketModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<TicketModel>? _payload;

  GetTicketModel copyWith({
    num? code,
    String? message,
    List<TicketModel>? payload,
  }) =>
      GetTicketModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<TicketModel>? get payload => _payload;

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

class TicketModel {
  TicketModel({
    String? id,
    String? cnote,
    String? priority,
    String? status,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    Category? category,
  }) {
    _id = id;
    _cnote = cnote;
    _priority = priority;
    _status = status;
    _createdBy = createdBy;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _category = category;
  }

  TicketModel.fromJson(dynamic json) {
    _id = json['id'];
    _cnote = json['cnote'];
    _priority = json['priority'];
    _status = json['status'];
    _createdBy = json['created_by'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  String? _id;
  String? _cnote;
  String? _priority;
  String? _status;
  String? _createdBy;
  String? _createdAt;
  String? _updatedAt;
  Category? _category;

  TicketModel copyWith({
    String? id,
    String? cnote,
    String? priority,
    String? status,
    String? createdBy,
    String? createdAt,
    String? updatedAt,
    Category? category,
  }) =>
      TicketModel(
        id: id ?? _id,
        cnote: cnote ?? _cnote,
        priority: priority ?? _priority,
        status: status ?? _status,
        createdBy: createdBy ?? _createdBy,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        category: category ?? _category,
      );

  String? get id => _id;

  String? get cnote => _cnote;

  String? get priority => _priority;

  String? get status => _status;

  String? get createdBy => _createdBy;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cnote'] = _cnote;
    map['priority'] = _priority;
    map['status'] = _status;
    map['created_by'] = _createdBy;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

class Category {
  Category({
    String? id,
    String? description,
    String? group,
  }) {
    _id = id;
    _description = description;
    _group = group;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _group = json['group'];
  }

  String? _id;
  String? _description;
  String? _group;

  Category copyWith({
    String? id,
    String? description,
    String? group,
  }) =>
      Category(
        id: id ?? _id,
        description: description ?? _description,
        group: group ?? _group,
      );

  String? get id => _id;

  String? get description => _description;

  String? get group => _group;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['description'] = _description;
    map['group'] = _group;
    return map;
  }
}
