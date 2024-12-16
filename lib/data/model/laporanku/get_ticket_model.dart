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
    bool? isUnread,
  }) {
    _id = id;
    _cnote = cnote;
    _priority = priority;
    _status = status;
    _createdBy = createdBy;
    _createdDate = createdDate;
    _updatedDate = updatedDate;
    _category = category;
    _isUnread = isUnread;
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
    _isUnread = json['isUnread'];
  }

  String? _id;
  String? _cnote;
  String? _priority;
  String? _status;
  String? _createdBy;
  String? _createdDate;
  String? _updatedDate;
  Category? _category;
  bool? _isUnread;

  TicketModel copyWith({
    String? id,
    String? cnote,
    String? priority,
    String? status,
    String? createdBy,
    String? createdDate,
    String? updatedDate,
    Category? category,
    bool? isUnread,
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
        isUnread: isUnread ?? _isUnread,
      );

  String? get id => _id;

  String? get cnote => _cnote;

  String? get priority => _priority;

  String? get status => _status;

  String? get createdBy => _createdBy;

  String? get createdDate => _createdDate;

  String? get updatedDate => _updatedDate;

  Category? get category => _category;

  bool? get isUnread => _isUnread;

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
    map['isUnread'] = _isUnread;
    return map;
  }
}

class Category {
  Category({
    String? categoryId,
    String? categoryGroup,
    String? categoryDescription,
  }) {
    _categoryId = categoryId;
    _categoryGroup = categoryGroup;
    _categoryDescription = categoryDescription;
  }

  Category.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _categoryGroup = json['categoryGroup'];
    _categoryDescription = json['categoryDescription'];
  }

  String? _categoryId;
  String? _categoryGroup;
  String? _categoryDescription;

  Category copyWith({
    String? categoryId,
    String? categoryGroup,
    String? categoryDescription,
  }) =>
      Category(
        categoryId: categoryId ?? _categoryId,
        categoryGroup: categoryGroup ?? _categoryGroup,
        categoryDescription: categoryDescription ?? _categoryDescription,
      );

  String? get categoryId => _categoryId;

  String? get categoryGroup => _categoryGroup;

  String? get categoryDescription => _categoryDescription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['categoryGroup'] = _categoryGroup;
    map['categoryDescription'] = _categoryDescription;
    return map;
  }
}
