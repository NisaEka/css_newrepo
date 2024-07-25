class DataPostTicketModel {
  DataPostTicketModel({
    String? cnote,
    String? categoryId,
    String? subject,
    String? message,
    String? priority,
  }) {
    _cnote = cnote;
    _categoryId = categoryId;
    _subject = subject;
    _message = message;
    _priority = priority;
  }

  DataPostTicketModel.fromJson(dynamic json) {
    _cnote = json['cnote'];
    _categoryId = json['category_id'];
    _subject = json['subject'];
    _message = json['message'];
    _priority = json['priority'];
  }

  String? _cnote;
  String? _categoryId;
  String? _subject;
  String? _message;
  String? _priority;

  DataPostTicketModel copyWith({
    String? cnote,
    String? categoryId,
    String? subject,
    String? message,
    String? priority,
  }) =>
      DataPostTicketModel(
        cnote: cnote ?? _cnote,
        categoryId: categoryId ?? _categoryId,
        subject: subject ?? _subject,
        message: message ?? _message,
        priority: priority ?? _priority,
      );

  String? get cnote => _cnote;

  String? get categoryId => _categoryId;

  String? get subject => _subject;

  String? get message => _message;

  String? get priority => _priority;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cnote'] = _cnote;
    map['category_id'] = _categoryId;
    map['subject'] = _subject;
    map['message'] = _message;
    map['priority'] = _priority;
    return map;
  }
}
