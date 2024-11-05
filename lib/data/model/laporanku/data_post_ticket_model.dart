class DataPostTicketModel {
  DataPostTicketModel(
      {String? cnote,
      String? categoryId,
      String? subject,
      String? message,
      String? priority,
      String? image,
      String? type,
      String? ticketId}) {
    _cnote = cnote;
    _categoryId = categoryId;
    _subject = subject;
    _message = message;
    _priority = priority;
    _image = image;
    _type = type;
    _ticketId = ticketId;
  }

  DataPostTicketModel.fromJson(dynamic json) {
    _cnote = json['cnote'];
    _categoryId = json['categoryId'];
    _subject = json['subject'];
    _message = json['message'];
    _priority = json['priority'];
    _image = json['image'];
    _type = json['type'];
    _ticketId = json['ticketId'];
  }

  String? _cnote;
  String? _categoryId;
  String? _subject;
  String? _message;
  String? _priority;
  String? _image;
  String? _type;
  String? _ticketId;

  DataPostTicketModel copyWith({
    String? cnote,
    String? categoryId,
    String? subject,
    String? message,
    String? priority,
    String? image,
    String? type,
    String? ticketId,
  }) =>
      DataPostTicketModel(
        cnote: cnote ?? _cnote,
        categoryId: categoryId ?? _categoryId,
        subject: subject ?? _subject,
        message: message ?? _message,
        priority: priority ?? _priority,
        image: image ?? _image,
        type: type ?? _type,
        ticketId: ticketId ?? _ticketId,
      );

  String? get cnote => _cnote;

  String? get categoryId => _categoryId;

  String? get subject => _subject;

  String? get message => _message;

  String? get priority => _priority;

  String? get image => _image;

  String? get type => _type;

  String? get ticketId => _ticketId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cnote'] = _cnote;
    map['categoryId'] = _categoryId;
    map['subject'] = _subject;
    map['message'] = _message;
    map['priority'] = _priority;
    map['image'] = _image;
    map['type'] = _type;
    map['ticketId'] = _ticketId;
    return map;
  }
}
