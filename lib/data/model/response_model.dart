class ResponseModel<T> {
  ResponseModel({
    num? statusCode,
    String? message,
    List<ErrorResponse>? error,
    T? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _error = error;
    _data = data;
  }

  ResponseModel.fromJson(
    dynamic json,
    T Function(Object? json) fromJsonT,
  ) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['error'] != null) {
      _error = [];
      json['error'].forEach((v) {
        _error?.add(ErrorResponse.fromJson(v));
      });
    }
    _data = _nullableGenericFromJson(json['data'], fromJsonT);
  }

  // Renamed the type parameter from T to U to avoid shadowing.
  U? _nullableGenericFromJson<U>(
    Object? input,
    U Function(Object? json) fromJson,
  ) =>
      input == null ? null : fromJson(input);

  num? _statusCode;
  String? _message;
  List<ErrorResponse>? _error;
  T? _data;

  ResponseModel<T> copyWith({
    num? statusCode,
    String? message,
    List<ErrorResponse>? error,
    T? data,
  }) =>
      ResponseModel<T>(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        error: error ?? _error,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;
  String? get message => _message;
  List<ErrorResponse>? get error => _error;
  T? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_error != null) {
      map['error'] = _error?.map((v) => v.toJson()).toList();
    }
    map['data'] = _data;
    return map;
  }
}

class ErrorResponse {
  ErrorResponse({
    String? property,
    num? statusCode,
    String? message,
  }) {
    _property = property;
    _statusCode = statusCode;
    _message = message;
  }

  ErrorResponse.fromJson(dynamic json) {
    _property = json['property'];
    _statusCode = json['statusCode'];
    _message = json['message'];
  }

  String? _property;
  num? _statusCode;
  String? _message;

  ErrorResponse copyWith({
    String? property,
    num? statusCode,
    String? message,
  }) =>
      ErrorResponse(
        property: property ?? _property,
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
      );

  String? get property => _property;
  num? get statusCode => _statusCode;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property'] = _property;
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    return map;
  }
}
