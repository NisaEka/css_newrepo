class Meta {
  Meta({
    num? currentPage,
    num? lastPage,
    String? firstPageURL,
    String? lastPageURL,
    List<String>? links,
    String? path,
    String? prevPageURL,
    String? nextPageURL,
    num? limit,
    num? from,
    num? to,
    num? total,
  }) {
    _currentPage = currentPage;
    _lastPage = lastPage;
    _firstPageURL = firstPageURL;
    _lastPageURL = lastPageURL;
    _links = links;
    _path = path;
    _prevPageURL = prevPageURL;
    _nextPageURL = nextPageURL;
    _limit = limit;
    _from = from;
    _to = to;
    _total = total;
  }

  Meta.fromJson(dynamic json) {
    _currentPage = json['currentPage'];
    _lastPage = json['lastPage'];
    _firstPageURL = json['firstPageURL'];
    _lastPageURL = json['lastPageURL'];
    _links = json['links'] != null ? json['links'].cast<String>() : [];
    _path = json['path'];
    _prevPageURL = json['prevPageURL'];
    _nextPageURL = json['nextPageURL'];
    _limit = json['limit'];
    _from = json['from'];
    _to = json['to'];
    _total = json['total'];
  }

  num? _currentPage;
  num? _lastPage;
  String? _firstPageURL;
  String? _lastPageURL;
  List<String>? _links;
  String? _path;
  String? _prevPageURL;
  String? _nextPageURL;
  num? _limit;
  num? _from;
  num? _to;
  num? _total;

  Meta copyWith({
    num? currentPage,
    num? lastPage,
    String? firstPageURL,
    String? lastPageURL,
    List<String>? links,
    String? path,
    String? prevPageURL,
    String? nextPageURL,
    num? limit,
    num? from,
    num? to,
    num? total,
  }) =>
      Meta(
        currentPage: currentPage ?? _currentPage,
        lastPage: lastPage ?? _lastPage,
        firstPageURL: firstPageURL ?? _firstPageURL,
        lastPageURL: lastPageURL ?? _lastPageURL,
        links: links ?? _links,
        path: path ?? _path,
        prevPageURL: prevPageURL ?? _prevPageURL,
        nextPageURL: nextPageURL ?? _nextPageURL,
        limit: limit ?? _limit,
        from: from ?? _from,
        to: to ?? _to,
        total: total ?? _total,
      );

  num? get currentPage => _currentPage;

  num? get lastPage => _lastPage;

  String? get firstPageURL => _firstPageURL;

  String? get lastPageURL => _lastPageURL;

  List<String>? get links => _links;

  String? get path => _path;

  String? get prevPageURL => _prevPageURL;

  String? get nextPageURL => _nextPageURL;

  num? get limit => _limit;

  num? get from => _from;

  num? get to => _to;

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['currentPage'] = _currentPage;
    map['lastPage'] = _lastPage;
    map['firstPageURL'] = _firstPageURL;
    map['lastPageURL'] = _lastPageURL;
    map['links'] = _links;
    map['path'] = _path;
    map['prevPageURL'] = _prevPageURL;
    map['nextPageURL'] = _nextPageURL;
    map['limit'] = _limit;
    map['from'] = _from;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}
