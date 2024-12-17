class TicketMessageModel {
  TicketMessageModel({
    num? id,
    String? ticketId,
    String? subject,
    String? message,
    String? image,
    String? createdDate,
    String? type,
    String? user,
    String? branchCode,
    String? read,
  }) {
    _id = id;
    _ticketId = ticketId;
    _subject = subject;
    _message = message;
    _image = image;
    _createdDate = createdDate;
    _type = type;
    _user = user;
    _branchCode = branchCode;
    _read = read;
  }

  TicketMessageModel.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticketId'];
    _subject = json['subject'];
    _message = json['message'];
    _image = json['image'];
    _createdDate = json['createdDate'];
    _type = json['type'];
    _user = json['user'];
    _branchCode = json['branchCode'];
    _read = json['read'];
  }

  num? _id;
  String? _ticketId;
  String? _subject;
  String? _message;
  String? _image;
  String? _createdDate;
  String? _type;
  String? _user;
  String? _branchCode;
  String? _read;

  TicketMessageModel copyWith({
    num? id,
    String? ticketId,
    String? subject,
    String? message,
    String? image,
    String? createdDate,
    String? type,
    String? user,
    String? branchCode,
    String? read,
  }) =>
      TicketMessageModel(
        id: id ?? _id,
        ticketId: ticketId ?? _ticketId,
        subject: subject ?? _subject,
        message: message ?? _message,
        image: image ?? _image,
        createdDate: createdDate ?? _createdDate,
        type: type ?? _type,
        user: user ?? _user,
        branchCode: branchCode ?? _branchCode,
        read: read ?? _read,
      );

  num? get id => _id;

  String? get ticketId => _ticketId;

  String? get subject => _subject;

  String? get message => _message;

  String? get image => _image;

  String? get createdDate => _createdDate;

  String? get type => _type;

  String? get user => _user;

  String? get branchCode => _branchCode;

  String? get read => _read;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticketId'] = _ticketId;
    map['subject'] = _subject;
    map['message'] = _message;
    map['image'] = _image;
    map['createdDate'] = _createdDate;
    map['type'] = _type;
    map['user'] = _user;
    map['branchCode'] = _branchCode;
    map['read'] = _read;
    return map;
  }
}
