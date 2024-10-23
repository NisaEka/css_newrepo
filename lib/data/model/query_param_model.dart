class QueryParamModel {
  QueryParamModel({
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
    _in = isIn;
    _notin = notin;
    _isNull = isNull;
    _isNotNull = isNotNull;
    _select = select;
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
      );

  bool? get table => _table;

  bool? get trash => _trash;

  bool? get includeDeleted => _includeDeleted;

  bool? get relation => _relation;

  num? get page => _page;

  num? get limit => _limit;

  String? get search => _search;

  String? get where => _where;

  String? get notEqual => _notEqual;

  String? get greaterThan => _greaterThan;

  String? get lessThan => _lessThan;

  String? get like => _like;

  String? get sort => _sort;

  String? get between => _between;

  String? get isIn => _in;

  String? get notin => _notin;

  String? get isNull => _isNull;

  String? get isNotNull => _isNotNull;

  String? get select => _select;

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
      map['where'] = _where;
    }

    if (_page != null) {
      map['page'] = _page;
    } else {
      map['page'] = 1;
    }

    if (_limit != null) {
      map['limit'] = _limit;
    }
    if (_notEqual != null) {
      map['notEqual'] = _notEqual;
    }

    if (greaterThan != null) {
      map['greaterThan'] = _greaterThan;
    }

    if (greaterThan != null) {
      map['lessThan'] = _greaterThan;
    }

    if (greaterThan != null) {
      map['like'] = _like;
    }

    if (greaterThan != null) {
      map['sort'] = _like;
    }

    if (greaterThan != null) {
      map['between'] = _like;
    }

    if (greaterThan != null) {
      map['in'] = _in;
    }

    if (greaterThan != null) {
      map['notin'] = _notin;
    }

    if (greaterThan != null) {
      map['isNull'] = _isNull;
    }

    if (greaterThan != null) {
      map['isNotNull'] = _isNotNull;
    }

    if (greaterThan != null) {
      map['select'] = _select;
    }

    return map;
  }
}
