class DataPostTicketModel {
  DataPostTicketModel(
      {String? cnote, String? categoryId, String? subject, String? message, String? priority, String? image, String? type, String? id}) {
    _cnote = cnote;
    _categoryId = categoryId;
    _subject = subject;
    _message = message;
    _priority = priority;
    _image = image;
    _type = type;
    _id = id;
  }

  DataPostTicketModel.fromJson(dynamic json) {
    _cnote = json['cnote'];
    _categoryId = json['category_id'];
    _subject = json['subject'];
    _message = json['message'];
    _priority = json['priority'];
    _image = json['image'];
    _type = json['type'];
    _id = json['id'];
  }

  String? _cnote;
  String? _categoryId;
  String? _subject;
  String? _message;
  String? _priority;
  String? _image;
  String? _type;
  String? _id;

  DataPostTicketModel copyWith({
    String? cnote,
    String? categoryId,
    String? subject,
    String? message,
    String? priority,
    String? image,
    String? type,
    String? id,
  }) =>
      DataPostTicketModel(
        cnote: cnote ?? _cnote,
        categoryId: categoryId ?? _categoryId,
        subject: subject ?? _subject,
        message: message ?? _message,
        priority: priority ?? _priority,
        image: image ?? _image,
        type: type ?? _type,
        id: id ?? _id,
      );

  String? get cnote => _cnote;

  String? get categoryId => _categoryId;

  String? get subject => _subject;

  String? get message => _message;

  String? get priority => _priority;

  String? get image => _image;

  String? get type => _type;

  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cnote'] = _cnote;
    map['category_id'] = _categoryId;
    map['subject'] = _subject;
    map['message'] = _message;
    map['priority'] = _priority;
    map['image'] = _image;
    map['type'] = _type;
    map['id'] = _id;
    return map;
  }
}
