class GetTicketMessageModel {
  GetTicketMessageModel({
    num? code,
    String? message,
    List<TicketMessageModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTicketMessageModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(TicketMessageModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<TicketMessageModel>? _payload;

  GetTicketMessageModel copyWith({
    num? code,
    String? message,
    List<TicketMessageModel>? payload,
  }) =>
      GetTicketMessageModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<TicketMessageModel>? get payload => _payload;

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
  }

  TicketMessageModel.fromJson(dynamic json) {
    _id = json['id'];
    _ticketId = json['ticket_id'];
    _subject = json['subject'];
    _message = json['message'];
    _image = json['image'];
    _createdDate = json['created_date'];
    _type = json['type'];
    _user = json['user'];
    _branchCode = json['branch_code'];
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

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['ticket_id'] = _ticketId;
    map['subject'] = _subject;
    map['message'] = _message;
    map['image'] = _image;
    map['created_date'] = _createdDate;
    map['type'] = _type;
    map['user'] = _user;
    map['branch_code'] = _branchCode;
    return map;
  }
}
