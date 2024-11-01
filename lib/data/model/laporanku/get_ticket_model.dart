class GetTicketModel {
  GetTicketModel({
    num? statusCode,
    String? message,
    List<TicketModel>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GetTicketModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TicketModel.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<TicketModel>? _data;

  GetTicketModel copyWith({
    num? statusCode,
    String? message,
    List<TicketModel>? data,
  }) =>
      GetTicketModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<TicketModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
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
    String? createdDate,
    String? updatedDate,
    Category? category,
  }) {
    _id = id;
    _cnote = cnote;
    _priority = priority;
    _status = status;
    _createdBy = createdBy;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _category = category;
  }

  TicketModel.fromJson(dynamic json) {
    _id = json['id'];
    _cnote = json['cnote'];
    _priority = json['priority'];
    _status = json['status'];
    _createdBy = json['createdBy'];
    _createdDate = json['createdDate'];
    _updatedDate = json['updatedDate'];
    _category =
        json['category'] != null ? Category.fromJson(json['category']) : null;
  }

  String? _id;
  String? _cnote;
  String? _priority;
  String? _status;
  String? _createdBy;
  String? _createdDate;
  String? _updatedDate;
  Category? _category;

  TicketModel copyWith({
    String? id,
    String? cnote,
    String? priority,
    String? status,
    String? createdBy,
    String? createdDate,
    String? updatedDate,
    Category? category,
  }) =>
      TicketModel(
        id: id ?? _id,
        cnote: cnote ?? _cnote,
        priority: priority ?? _priority,
        status: status ?? _status,
        createdBy: createdBy ?? _createdBy,
        createdDate: createdDate ?? _createdDate,
        updatedDate: updatedDate ?? _updatedDate,
        category: category ?? _category,
      );

  String? get id => _id;

  String? get cnote => _cnote;

  String? get priority => _priority;

  String? get status => _status;

  String? get createdBy => _createdBy;

  String? get createdDate => _createdDate;

  String? get updatedDate => _updatedDate;

  Category? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['cnote'] = _cnote;
    map['priority'] = _priority;
    map['status'] = _status;
    map['createdBy'] = _createdBy;
    map['createdDate'] = _createdDate;
    map['updatedDate'] = _updatedDate;
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
