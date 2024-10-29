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
    _message = json['message'];
    _error = json['error'];
    _code = json['statusCode'];
    _data = _nullableGenericFromJson(json['data'], fromJsonT);
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }

  /// Avoids shadowing the class-level T by renaming the generic parameter to U.
  U? _nullableGenericFromJson<U>(
    Object? input,
    U Function(Object? json) fromJson,
  ) =>
      input == null ? null : fromJson(input);

  dynamic _message;
  dynamic _error;
  num? _code;
  T? _data;
  Meta? _meta;

  BaseResponse<T> copyWith({
    dynamic message,
    dynamic error,
    num? code,
    T? data,
    Meta? meta,
  }) =>
      BaseResponse<T>(
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
    map['error'] = _error;
    map['statusCode'] = _code;
    map['data'] = _data;
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    return map;
  }
}

class Meta {
  Meta({
    num? total,
    num? limit,
    num? currentPage,
    num? lastPage,
    num? from,
    num? to,
  }) {
    _total = total;
    _limit = limit;
    _currentPage = currentPage;
    _lastPage = lastPage;
    _from = from;
    _to = to;
  }

  Meta.fromJson(dynamic json) {
    _total = json['total'];
    _limit = json['limit'];
    _currentPage = json['currentPage'];
    _lastPage = json['lastPage'];
    _from = json['from'];
    _to = json['to'];
  }

  num? _total;
  num? _limit;
  num? _currentPage;
  num? _lastPage;
  num? _from;
  num? _to;

  Meta copyWith({
    num? currentPage,
    num? limit,
    num? total,
    num? lastPage,
    num? from,
    num? to,
  }) =>
      Meta(
        total: total ?? _total,
        limit: limit ?? _limit,
        currentPage: currentPage ?? _currentPage,
        lastPage: lastPage ?? _lastPage,
        from: from ?? _from,
        to: to ?? _to,
      );

  num? get total => _total;
  num? get limit => _limit;
  num? get currentPage => _currentPage;
  num? get lastPage => _lastPage;
  num? get from => _from;
  num? get to => _to;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total;
    map['limit'] = _limit;
    map['currentPage'] = _currentPage;
    map['lastPage'] = _lastPage;
    map['from'] = _from;
    map['to'] = _to;
    return map;
  }
}
