class TicketCategory {
  TicketCategory({
    String? categoryId,
    String? categoryDescription,
    String? categoryGroup,
  }) {
    _categoryId = categoryId;
    _categoryDescription = categoryDescription;
    _categoryGroup = categoryGroup;
  }

  TicketCategory.fromJson(dynamic json) {
    _categoryId = json['categoryId'];
    _categoryDescription = json['categoryDescription'];
    _categoryGroup = json['categoryGroup'];
  }

  String? _categoryId;
  String? _categoryDescription;
  String? _categoryGroup;

  TicketCategory copyWith({
    String? categoryId,
    String? categoryDescription,
    String? categoryGroup,
  }) =>
      TicketCategory(
        categoryId: categoryId ?? _categoryId,
        categoryDescription: categoryDescription ?? _categoryDescription,
        categoryGroup: categoryGroup ?? _categoryGroup,
      );

  String? get categoryId => _categoryId;

  String? get categoryDescription => _categoryDescription;

  String? get categoryGroup => _categoryGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['categoryId'] = _categoryId;
    map['categoryDescription'] = _categoryDescription;
    map['categoryGroup'] = _categoryGroup;
    return map;
  }
}
