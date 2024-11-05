class GetTicketCategoryModel {
  GetTicketCategoryModel({
    num? statusCode,
    String? message,
    List<TicketCategory>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GetTicketCategoryModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(TicketCategory.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<TicketCategory>? _data;

  GetTicketCategoryModel copyWith({
    num? statusCode,
    String? message,
    List<TicketCategory>? data,
  }) =>
      GetTicketCategoryModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<TicketCategory>? get data => _data;

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

class TicketCategory {
  TicketCategory({
    String? categoryId,
    String? categoryDescription,
    String? categoryGroup,
  }) {
    _categoryId = categoryId;
    _categoryDescription = categoryDescription;
    _categoryGroup = categoryGroup;
  }

  TicketCategory.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _categoryDescription = json['categoryDescription'];
    _categoryGroup = json['categoryGroup'];
  }

  String? _categoryId;
  String? _categoryDescription;
  String? _categoryGroup;

  TicketCategory copyWith({
    String? categoryId,
    String? categoryDescription,
    String? categoryGroup,
  }) =>
      TicketCategory(
        categoryId: categoryId ?? _categoryId,
        categoryDescription: categoryDescription ?? _categoryDescription,
        categoryGroup: categoryGroup ?? _categoryGroup,
      );

  String? get categoryId => _categoryId;

  String? get categoryDescription => _categoryDescription;

  String? get categoryGroup => _categoryGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['categoryDescription'] = _categoryDescription;
    map['categoryGroup'] = _categoryGroup;
    return map;
  }
}
