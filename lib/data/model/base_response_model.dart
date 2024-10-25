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
    num? page,
    num? limit,
    num? rowCount,
    num? pageCount,
  }) {
    _page = page;
    _limit = limit;
    _rowCount = rowCount;
    _pageCount = pageCount;
  }

  Meta.fromJson(dynamic json) {
    _page = json['page'];
    _limit = json['limit'];
    _rowCount = json['rowCount'];
    _pageCount = json['pageCount'];
  }

  num? _page;
  num? _limit;
  num? _rowCount;
  num? _pageCount;

  Meta copyWith({
    num? page,
    num? limit,
    num? rowCount,
    num? pageCount,
  }) =>
      Meta(
        page: page ?? _page,
        limit: limit ?? _limit,
        rowCount: rowCount ?? _rowCount,
        pageCount: pageCount ?? _pageCount,
      );

  num? get page => _page;

  num? get limit => _limit;

  num? get rowCount => _rowCount;

  num? get pageCount => _pageCount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['limit'] = _limit;
    map['rowCount'] = _rowCount;
    map['pageCount'] = _pageCount;
    return map;
  }
}
