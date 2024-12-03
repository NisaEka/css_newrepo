class QueryModel {
  QueryModel({
    this.table = false,
    this.trash = false,
    this.includeDeleted = false,
    this.relation = false,
    this.page = 1,
    this.limit = 10,
    this.search,
    this.where = const [],
    this.notEqual = const [],
    this.greaterThan = const [],
    this.lessThan = const [],
    this.like = const [],
    this.sort = const [],
    this.between = const [],
    this.inValues = const [],
    this.notInValues = const [],
    this.isNull = const [],
    this.isNotNull = const [],
    this.select = const [],
    this.entity,
    this.type,
    this.petugasEntry,
  });

  bool table;
  bool trash;
  bool includeDeleted;
  bool relation;
  int page;
  int limit;
  String? search;
  List<Map<String, dynamic>> where;
  List<Map<String, dynamic>> notEqual;
  List<Map<String, dynamic>> greaterThan;
  List<Map<String, dynamic>> lessThan;
  List<Map<String, dynamic>> like;
  List<Map<String, dynamic>> sort;
  List<Map<String, dynamic>> between;
  List<Map<String, dynamic>> inValues;
  List<Map<String, dynamic>> notInValues;
  List<String> isNull;
  List<String> isNotNull;
  List<String> select;
  String? entity;
  String? type;
  String? petugasEntry;

  // Convert all fields to JSON, handling DateTime objects
  Map<String, dynamic> toJson() {
    return {
      'table': table.toString(),
      'trash': trash.toString(),
      'includeDeleted': includeDeleted.toString(),
      'relation': relation.toString(),
      'page': page.toString(),
      'limit': limit.toString(),
      'search': search,
      'where': _toJsonStringIfNeeded(where),
      'notEqual': _toJsonStringIfNeeded(notEqual),
      'greaterThan': _toJsonStringIfNeeded(greaterThan),
      'lessThan': _toJsonStringIfNeeded(lessThan),
      'like': _toJsonStringIfNeeded(like),
      'sort': _toJsonStringIfNeeded(sort),
      'between': _toJsonStringIfNeeded(between),
      'in': _toJsonStringIfNeeded(inValues),
      'notin': _toJsonStringIfNeeded(notInValues),
      'isNull': isNull,
      'isNotNull': isNotNull,
      'select': select,
      'entity': entity,
      'type': type,
      'petugasEntry': petugasEntry,
    }..removeWhere((key, value) => value == null);
  }

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

  // Deserialize from JSON
  QueryModel.fromJson(Map<String, dynamic> json)
      : table = json['table'] ?? false,
        trash = json['trash'] ?? false,
        includeDeleted = json['includeDeleted'] ?? false,
        relation = json['relation'] ?? false,
        page = json['page'] ?? 1,
        limit = json['limit'] ?? 10,
        search = json['search'],
        where = _convertConditionList(json['where']),
        notEqual = _convertConditionList(json['notEqual']),
        greaterThan = _convertConditionList(json['greaterThan']),
        lessThan = _convertConditionList(json['lessThan']),
        like = _convertConditionList(json['like']),
        sort = _convertConditionList(json['sort']),
        between = _convertConditionList(json['between']),
        inValues = _convertConditionList(json['in']),
        notInValues = _convertConditionList(json['notin']),
        isNull = List<String>.from(json['isNull'] ?? []),
        isNotNull = List<String>.from(json['isNotNull'] ?? []),
        select = List<String>.from(json['select'] ?? []),
        entity = json['entity'],
        type = json['type'],
        petugasEntry = json['petugasEntry'];

  // Helper function to convert JSON list into List<Map<String, dynamic>>
  static List<Map<String, dynamic>> _convertConditionList(dynamic jsonList) {
    if (jsonList == null) return [];
    return List<Map<String, dynamic>>.from(
      (jsonList as List).map((e) => Map<String, dynamic>.from(e)),
    );
  }
}
