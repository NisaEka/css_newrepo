class CountQueryModel {
  CountQueryModel({
    this.trash = false,
    this.includeDeleted = false,
    this.where = const [],
    this.notEqual = const [],
    this.greaterThan = const [],
    this.lessThan = const [],
    this.like = const [],
    this.between = const [],
    this.inValues = const [],
    this.notInValues = const [],
    this.isNull = const [],
    this.isNotNull = const [],
    this.search,
    this.petugasEntry,
  });

  bool trash;
  bool includeDeleted;
  List<Map<String, dynamic>> where;
  List<Map<String, dynamic>> notEqual;
  List<Map<String, dynamic>> greaterThan;
  List<Map<String, dynamic>> lessThan;
  List<Map<String, dynamic>> like;
  List<Map<String, dynamic>> between;
  List<Map<String, dynamic>> inValues;
  List<Map<String, dynamic>> notInValues;
  List<String> isNull;
  List<String> isNotNull;
  String? search;
  String? petugasEntry;

  // Convert all fields to JSON, handling DateTime objects
  Map<String, dynamic> toJson() {
    return {
      'trash': trash.toString(),
      'includeDeleted': includeDeleted.toString(),
      'where': _toJsonStringIfNeeded(where),
      'notEqual': _toJsonStringIfNeeded(notEqual),
      'greaterThan': _toJsonStringIfNeeded(greaterThan),
      'lessThan': _toJsonStringIfNeeded(lessThan),
      'like': _toJsonStringIfNeeded(like),
      'between': _toJsonStringIfNeeded(between),
      'in': _toJsonStringIfNeeded(inValues),
      'notin': _toJsonStringIfNeeded(notInValues),
      'isNull': isNull,
      'isNotNull': isNotNull,
      'search': search,
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
  CountQueryModel.fromJson(Map<String, dynamic> json)
      : trash = json['trash'] ?? false,
        includeDeleted = json['includeDeleted'] ?? false,
        where = _convertConditionList(json['where']),
        notEqual = _convertConditionList(json['notEqual']),
        greaterThan = _convertConditionList(json['greaterThan']),
        lessThan = _convertConditionList(json['lessThan']),
        like = _convertConditionList(json['like']),
        between = _convertConditionList(json['between']),
        inValues = _convertConditionList(json['in']),
        notInValues = _convertConditionList(json['notin']),
        isNull = List<String>.from(json['isNull'] ?? []),
        isNotNull = List<String>.from(json['isNotNull'] ?? []),
        search = json['search'],
        petugasEntry = json['petugasEntry'];

  // Helper function to convert JSON list into List<Map<String, dynamic>>
  static List<Map<String, dynamic>> _convertConditionList(dynamic jsonList) {
    if (jsonList == null) return [];
    return List<Map<String, dynamic>>.from(
      (jsonList as List).map((e) => Map<String, dynamic>.from(e)),
    );
  }
}
