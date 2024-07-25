class GetTicketCategoryModel {
  GetTicketCategoryModel({
    num? code,
    String? message,
    List<TicketCategory>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTicketCategoryModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(TicketCategory.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<TicketCategory>? _payload;

  GetTicketCategoryModel copyWith({
    num? code,
    String? message,
    List<TicketCategory>? payload,
  }) =>
      GetTicketCategoryModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<TicketCategory>? get payload => _payload;

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

class TicketCategory {
  TicketCategory({
    String? id,
    String? description,
    String? group,
  }) {
    _id = id;
    _description = description;
    _group = group;
  }

  TicketCategory.fromJson(dynamic json) {
    _id = json['id'];
    _description = json['description'];
    _group = json['group'];
  }

  String? _id;
  String? _description;
  String? _group;

  TicketCategory copyWith({
    String? id,
    String? description,
    String? group,
  }) =>
      TicketCategory(
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
