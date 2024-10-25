class ResponseModel<T> {
  ResponseModel(
      {num? code, String? message, List<ErrorResponse>? error, T? payload}) {
    _code = code;
    _message = message;
    _error = error;
    _payload = payload;
  }

  ResponseModel.fromJson(dynamic json, T Function(Object? json) fromJsonT) {
    _code = json['code'];
    _message = json['message'];
    if (json['error'] != null) {
      _error = [];
      json['error'].forEach((v) {
        _error?.add(ErrorResponse.fromJson(v));
      });
    }
    _payload = _$nullableGenericFromJson(json['payload'], fromJsonT);
  }

  T? _$nullableGenericFromJson<T>(
    Object? input,
    T Function(Object? json) fromJson,
  ) =>
      input == null ? null : fromJson(input);

  num? _code;
  String? _message;
  List<ErrorResponse>? _error;
  T? _payload;

  ResponseModel copyWith(
          {num? code,
          String? message,
          List<ErrorResponse>? error,
          T? payload}) =>
      ResponseModel(
        code: code ?? _code,
        message: message ?? _message,
        error: error ?? _error,
        payload: payload ?? payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<ErrorResponse>? get error => _error;

  T? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_error != null) {
      map['error'] = _error?.map((v) => v.toJson()).toList();
    }
    map['payload'] = _payload;
    return map;
  }
}

class ErrorResponse {
  ErrorResponse({
    String? property,
    num? code,
    String? message,
  }) {
    _property = property;
    _code = code;
    _message = message;
  }

  ErrorResponse.fromJson(dynamic json) {
    _property = json['property'];
    _code = json['code'];
    _message = json['message'];
  }

  String? _property;
  num? _code;
  String? _message;

  ErrorResponse copyWith({
    String? property,
    num? code,
    String? message,
  }) =>
      ErrorResponse(
        property: property ?? _property,
        code: code ?? _code,
        message: message ?? _message,
      );

  String? get property => _property;

  num? get code => _code;

  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['property'] = _property;
    map['code'] = _code;
    map['message'] = _message;
    return map;
  }
}
