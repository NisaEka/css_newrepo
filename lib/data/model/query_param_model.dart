class QueryParamModel {
  QueryParamModel(
      {bool? table,
      bool? trash,
      bool? includeDeleted,
      bool? relation,
      num? page,
      num? limit,
      String? search,
      String? where,
      String? notEqual,
      String? greaterThan,
      String? lessThan,
      String? like,
      String? sort,
      String? between,
      String? isIn,
      String? notin,
      String? isNull,
      String? isNotNull,
      String? select,
      String? soundex,
      String? status,
      String? type}) {
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
    _in = isIn;
    _notin = notin;
    _isNull = isNull;
    _isNotNull = isNotNull;
    _select = select;
    _soundex = soundex;
    _status = status;
    _type = type;
  }

  QueryParamModel.fromJson(dynamic json) {
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
    _in = json['in'];
    _notin = json['notin'];
    _isNull = json['isNull'];
    _isNotNull = json['isNotNull'];
    _select = json['select'];
    _soundex = json['soundex'];
    _status = json['status'];
    _type = json['type'];
  }

  bool? _table;
  bool? _trash;
  bool? _includeDeleted;
  bool? _relation;
  num? _page;
  num? _limit;
  String? _search;
  String? _where;
  String? _notEqual;
  String? _greaterThan;
  String? _lessThan;
  String? _like;
  String? _sort;
  String? _between;
  String? _in;
  String? _notin;
  String? _isNull;
  String? _isNotNull;
  String? _select;
  String? _soundex;
  String? _status;
  String? _type;

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

  String? get where => _where;

  void setWhere(String? value) => _where = value;

  String? get notEqual => _notEqual;

  void setNotEqual(String? value) => _notEqual = value;

  String? get greaterThan => _greaterThan;

  void setGreaterThan(String? value) => _greaterThan = value;

  String? get lessThan => _lessThan;

  void setLessThan(String? value) => _lessThan = value;

  String? get like => _like;

  void setLike(String? value) => _like = value;

  String? get sort => _sort;

  void setSort(String? value) => _sort = value;

  String? get between => _between;

  void setBetween(String? value) => _between = value;

  String? get isIn => _in;

  void setIsIn(String? value) => _in = value;

  String? get notin => _notin;

  void setNotin(String? value) => _notin = value;

  String? get isNull => _isNull;

  void setIsNull(String? value) => _isNull = value;

  String? get isNotNull => _isNotNull;

  void setIsNotNull(String? value) => _isNotNull = value;

  String? get select => _select;

  void setSelect(String? value) => _select = value;

  String? get soundex => _soundex;

  void setSoundex(String? value) => _soundex = value;

  String? get status => _status;

  String? get type => _type;

  // CopyWith method
  QueryParamModel copyWith({
    bool? table,
    bool? trash,
    bool? includeDeleted,
    bool? relation,
    num? page,
    num? limit,
    String? search,
    String? where,
    String? notEqual,
    String? greaterThan,
    String? lessThan,
    String? like,
    String? sort,
    String? between,
    String? isIn,
    String? notin,
    String? isNull,
    String? isNotNull,
    String? select,
    String? soundex,
    String? status,
    String? type,
  }) =>
      QueryParamModel(
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
        isIn: isIn ?? _in,
        notin: notin ?? _notin,
        isNull: isNull ?? _isNull,
        isNotNull: isNotNull ?? _isNotNull,
        select: select ?? _select,
        soundex: soundex ?? _soundex,
        status: status ?? _status,
        type: type ?? _type,
      );

  // toJson method
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_table != null) map['table'] = _table;
    if (_trash != null) map['trash'] = _trash;
    if (_includeDeleted != null) map['includeDeleted'] = _includeDeleted;
    if (_relation != null) map['relation'] = _relation;
    if (_search != null) map['search'] = _search;
    if (_where != null) map['where'] = _where;
    if (_page != null) map['page'] = _page;
    if (_limit != null) map['limit'] = _limit;
    if (_notEqual != null) map['notEqual'] = _notEqual;
    if (_greaterThan != null) map['greaterThan'] = _greaterThan;
    if (_lessThan != null) map['lessThan'] = _lessThan;
    if (_like != null) map['like'] = _like;
    if (_sort != null) map['sort'] = _sort;
    if (_between != null) map['between'] = _between;
    if (_in != null) map['in'] = _in;
    if (_notin != null) map['notin'] = _notin;
    if (_isNull != null) map['isNull'] = _isNull;
    if (_isNotNull != null) map['isNotNull'] = _isNotNull;
    if (_select != null) map['select'] = _select;
    if (_soundex != null) map['soundex'] = _soundex;
    if (_status != null || (_status?.isNotEmpty ?? false)) {
      map['status'] = _status;
    }
    if (_type != null || (_type?.isNotEmpty ?? false)) map['type'] = _type;

    return map;
  }
}
