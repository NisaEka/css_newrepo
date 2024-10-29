import 'meta_response_model.dart';

class BaseResponse<T> {
  BaseResponse({
    dynamic message,
    dynamic error,
    num? code,
    T? data,
    Meta? meta,
  }) {
    _message = message;
    _error = error;
    _code = code;
    _data = data;
    _meta = meta;
  }

  BaseResponse.fromJson(dynamic json, T Function(Object? json) fromJsonT) {
    _message = json['message'] ?? json['messages'];
    _error = json['error'] ?? json['errors'];
    _code = json['statusCode'];
    _data = _$nullableGenericFromJson(json['data'], fromJsonT);
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  T? _$nullableGenericFromJson<T>(
    Object? input,
    T Function(Object? json) fromJson,
  ) =>
      input == null ? null : fromJson(input);

  dynamic _message;
  dynamic _error;
  num? _code;
  T? _data;
  Meta? _meta;

  BaseResponse copyWith({
    dynamic message,
    dynamic error,
    num? code,
    T? data,
    Meta? meta,
  }) =>
      BaseResponse(
        message: message ?? _message,
        error: error ?? _error,
        code: code ?? _code,
        data: data ?? _data,
        meta: meta ?? _meta,
      );

  dynamic get message => _message;

  dynamic get error => _error;

  num? get code => _code;

  T? get data => _data;

  Meta? get meta => _meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['messages'] = _message;
    map['error'] = _error;
    map['errors'] = _error;
    map['statusCode'] = _code;
    map['data'] = _data;
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}
