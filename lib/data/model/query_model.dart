class QueryModel {
  QueryModel({
    bool? table,
    bool? trash,
    bool? includeDeleted,
    bool? relation,
    num? page,
    num? limit,
    String? search,
    List<Map<String, dynamic>>? where,
    List<Map<String, dynamic>>? notEqual,
    List<Map<String, dynamic>>? greaterThan,
    List<Map<String, dynamic>>? lessThan,
    List<Map<String, dynamic>>? like,
    List<Map<String, dynamic>>? sort,
    List<Map<String, dynamic>>? between,
    List<Map<String, dynamic>>? inValues,
    List<Map<String, dynamic>>? notInValues,
    List<String>? isNull,
    List<String>? isNotNull,
    List<String>? select,
    List<Map<String, dynamic>>? soundex,
    String? status,
    String? type,
    String? entity,
    String? petugasEntry,
  }) {
    _table = table;
    _trash = trash;
    _includeDeleted = includeDeleted;
    _relation = relation;
    _page = page;
    _limit = limit;
    _search = search;
    _where = where;
    _notEqual = notEqual;
    _greaterThan = greaterThan;
    _lessThan = lessThan;
    _like = like;
    _sort = sort;
    _between = between;
    _inValues = inValues;
    _notInValues = notInValues;
    _isNull = isNull;
    _isNotNull = isNotNull;
    _select = select;
    _soundex = soundex;
    _status = status;
    _type = type;
  }

  QueryModel.fromJson(dynamic json) {
    _table = json['table'];
    _trash = json['trash'];
    _includeDeleted = json['includeDeleted'];
    _relation = json['relation'];
    _page = json['page'];
    _limit = json['limit'];
    _search = json['search'];
    _where = json['where'];
    _notEqual = json['notEqual'];
    _greaterThan = json['greaterThan'];
    _lessThan = json['lessThan'];
    _like = json['like'];
    _sort = json['sort'];
    _between = json['between'];
    _inValues = json['in'];
    _notInValues = json['notin'];
    _isNull = json['isNull'];
    _isNotNull = json['isNotNull'];
    _select = json['select'];
    _soundex = json['soundex'];
    _status = json['status'];
    _type = json['type'];
    _entity = json['entity'];
    _petugasEntry = json['petugasEntry'];
  }

  bool? _table;
  bool? _trash;
  bool? _includeDeleted;
  bool? _relation;
  num? _page;
  num? _limit;
  String? _search;
  List<Map<String, dynamic>>? _where;
  List<Map<String, dynamic>>? _notEqual;
  List<Map<String, dynamic>>? _greaterThan;
  List<Map<String, dynamic>>? _lessThan;
  List<Map<String, dynamic>>? _like;
  List<Map<String, dynamic>>? _sort;
  List<Map<String, dynamic>>? _between;
  List<Map<String, dynamic>>? _inValues;
  List<Map<String, dynamic>>? _notInValues;
  List<String>? _isNull;
  List<String>? _isNotNull;
  List<String>? _select;
  List<Map<String, dynamic>>? _soundex;
  String? _status;
  String? _type;
  String? _entity;
  String? _petugasEntry;

  // Getters
  bool? get table => _table;

  void setTable(bool? value) => _table = value;

  bool? get trash => _trash;

  void setTrash(bool? value) => _trash = value;

  bool? get includeDeleted => _includeDeleted;

  void setIncludeDeleted(bool? value) => _includeDeleted = value;

  bool? get relation => _relation;

  void setRelation(bool? value) => _relation = value;

  num? get page => _page;

  void setPage(num? value) => _page = value;

  num? get limit => _limit;

  void setLimit(num? value) => _limit = value;

  String? get search => _search;

  void setSearch(String? value) => _search = value;

  List<Map<String, dynamic>>? get where => _where;

  void setWhere(List<Map<String, dynamic>>? value) => _where = value;

  List<Map<String, dynamic>>? get notEqual => _notEqual;

  void setNotEqual(List<Map<String, dynamic>>? value) => _notEqual = value;

  List<Map<String, dynamic>>? get greaterThan => _greaterThan;

  void setGreaterThan(List<Map<String, dynamic>>? value) =>
      _greaterThan = value;

  List<Map<String, dynamic>>? get lessThan => _lessThan;

  void setLessThan(List<Map<String, dynamic>>? value) => _lessThan = value;

  List<Map<String, dynamic>>? get like => _like;

  void setLike(List<Map<String, dynamic>>? value) => _like = value;

  List<Map<String, dynamic>>? get sort => _sort;

  void setSort(List<Map<String, dynamic>>? value) => _sort = value;

  List<Map<String, dynamic>>? get between => _between;

  void setBetween(List<Map<String, dynamic>>? value) => _between = value;

  List<Map<String, dynamic>>? get inValues => _inValues;

  void setInValues(List<Map<String, dynamic>>? value) => _inValues = value;

  List<Map<String, dynamic>>? get notInValues => _notInValues;

  void setNotInValues(List<Map<String, dynamic>>? value) =>
      _notInValues = value;

  List<String>? get isNull => _isNull;

  void setIsNull(List<String>? value) => _isNull = value;

  List<String>? get isNotNull => _isNotNull;

  void setIsNotNull(List<String>? value) => _isNotNull = value;

  List<String>? get select => _select;

  void setSelect(List<String>? value) => _select = value;

  List<Map<String, dynamic>>? get soundex => _soundex;

  void setSoundex(List<Map<String, dynamic>>? value) => _soundex = value;

  String? get status => _status;

  String? get type => _type;

  String? get entity => _entity;

  String? get petugasEntry => _petugasEntry;

  // CopyWith method
  QueryModel copyWith({
    bool? table,
    bool? trash,
    bool? includeDeleted,
    bool? relation,
    num? page,
    num? limit,
    String? search,
    List<Map<String, dynamic>>? where,
    List<Map<String, dynamic>>? notEqual,
    List<Map<String, dynamic>>? greaterThan,
    List<Map<String, dynamic>>? lessThan,
    List<Map<String, dynamic>>? like,
    List<Map<String, dynamic>>? sort,
    List<Map<String, dynamic>>? between,
    List<Map<String, dynamic>>? inValues,
    List<Map<String, dynamic>>? notInValues,
    List<String>? isNull,
    List<String>? isNotNull,
    List<String>? select,
    List<Map<String, dynamic>>? soundex,
    String? status,
    String? type,
    String? entity,
    String? petugasEntry,
  }) =>
      QueryModel(
        table: table ?? _table,
        trash: trash ?? _trash,
        includeDeleted: includeDeleted ?? _includeDeleted,
        relation: relation ?? _relation,
        page: page ?? _page,
        limit: limit ?? _limit,
        search: search ?? _search,
        where: where ?? _where,
        notEqual: notEqual ?? _notEqual,
        greaterThan: greaterThan ?? _greaterThan,
        lessThan: lessThan ?? _lessThan,
        like: like ?? _like,
        sort: sort ?? _sort,
        between: between ?? _between,
        inValues: inValues ?? _inValues,
        notInValues: notInValues ?? _notInValues,
        isNull: isNull ?? _isNull,
        isNotNull: isNotNull ?? _isNotNull,
        select: select ?? _select,
        soundex: soundex ?? _soundex,
        status: status ?? _status,
        type: type ?? _type,
      );

  // Helper function to handle DateTime conversion recursively
  dynamic _toJsonStringIfNeeded(dynamic value) {
    if (value is DateTime) {
      return '"${value.toIso8601String()}"';
    } else if (value is List) {
      return value.map(_toJsonStringIfNeeded).toList().toString();
    } else if (value is Map) {
      return value.map((key, val) =>
          MapEntry(_toJsonStringIfNeeded(key), _toJsonStringIfNeeded(val)));
    }
    return '"$value"';
  }

  // toJson method
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_table != null) {
      map['table'] = _table;
    }
    if (_trash != null) {
      map['trash'] = _trash;
    }
    if (_includeDeleted != null) {
      map['includeDeleted'] = _includeDeleted;
    }
    if (_relation != null) {
      map['relation'] = _relation;
    }
    if (_search != null) {
      map['search'] = _search;
    }
    if (_where != null) {
      map['where'] = _toJsonStringIfNeeded(_where);
    }
    if (_page != null) {
      map['page'] = _page;
    }
    if (_limit != null) {
      map['limit'] = _limit;
    }
    if (_notEqual != null) {
      map['notEqual'] = _toJsonStringIfNeeded(_notEqual);
    }
    if (_greaterThan != null) {
      map['greaterThan'] = _toJsonStringIfNeeded(_greaterThan);
    }
    if (_lessThan != null) {
      map['lessThan'] = _toJsonStringIfNeeded(_lessThan);
    }
    if (_like != null) {
      map['like'] = _toJsonStringIfNeeded(_like);
    }
    if (_sort != null) {
      map['sort'] = _toJsonStringIfNeeded(_sort);
    }
    if (_between != null) {
      map['between'] = _toJsonStringIfNeeded(_between);
    }
    if (_inValues != null) {
      map['in'] = _toJsonStringIfNeeded(_inValues);
    }
    if (_notInValues != null) {
      map['notin'] = _toJsonStringIfNeeded(_notInValues);
    }
    if (_isNull != null) {
      map['isNull'] = _isNull;
    }
    if (_isNotNull != null) {
      map['isNotNull'] = _isNotNull;
    }
    if (_select != null) {
      map['select'] = _select;
    }
    if (_soundex != null) {
      map['soundex'] = _soundex;
    }
    if (_status != null || (_status?.isNotEmpty ?? false)) {
      map['status'] = _status;
    }
    if (_type != null || (_type?.isNotEmpty ?? false)) {
      map['type'] = _type;
    }
    if (_entity != null || (_entity?.isNotEmpty ?? false)) {
      map['entity'] = _entity;
    }
    if (_petugasEntry != null || (_petugasEntry?.isNotEmpty ?? false)) {
      map['petugasEntry'] = _petugasEntry;
    }

    return map;
  }
}
