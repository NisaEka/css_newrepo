import 'dart:convert';

import 'package:css_mobile/data/model/response_model.dart';

PostTransactionModel postTransactionModelFromJson(String str) =>
    PostTransactionModel.fromJson(json.decode(str));

String postTransactionModelToJson(PostTransactionModel data) =>
    json.encode(data.toJson());

class PostTransactionModel {
  PostTransactionModel({
    num? code,
    String? message,
    List<ErrorResponse>? error,
    Payload? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  PostTransactionModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['error'] != null) {
      _error = [];
      json['error'].forEach((v) {
        _error?.add(ErrorResponse.fromJson(v));
      });
    }
    _payload =
        json['payload'] != null ? Payload.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  List<ErrorResponse>? _error;
  Payload? _payload;

  PostTransactionModel copyWith({
    num? code,
    String? message,
    List<ErrorResponse>? error,
    Payload? payload,
  }) =>
      PostTransactionModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
        error: error ?? _error,
      );

  num? get code => _code;

  String? get message => _message;

  List<ErrorResponse>? get error => _error;

  Payload? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_error != null) {
      map['error'] = _error?.map((v) => v.toJson()).toList();
    }
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  Payload({
    String? awb,
  }) {
    _awb = awb;
  }

  Payload.fromJson(dynamic json) {
    _awb = json['awb'];
  }

  String? _awb;

  Payload copyWith({
    String? awb,
  }) =>
      Payload(
        awb: awb ?? _awb,
      );

  String? get awb => _awb;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['awb'] = _awb;
    return map;
  }
}
