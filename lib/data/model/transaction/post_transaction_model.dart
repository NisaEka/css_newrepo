import 'dart:convert';

PostTransactionModel postTransactionModelFromJson(String str) => PostTransactionModel.fromJson(json.decode(str));

String postTransactionModelToJson(PostTransactionModel data) => json.encode(data.toJson());

class PostTransactionModel {
  PostTransactionModel({
    String? code,
    String? message,
  }) {
    _code = code;
    _message = message;
  }

  PostTransactionModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
  }

  String? _code;
  String? _message;

  PostTransactionModel copyWith({
    String? code,
    String? message,
  }) =>
      PostTransactionModel(
        code: code ?? _code,
        message: message ?? _message,
      );

  String? get code => _code;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }
}
