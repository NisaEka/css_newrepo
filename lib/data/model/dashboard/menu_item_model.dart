class MenuItemModel {
  MenuItemModel({
    List<Items>? items,
  }) {
    _items = items;
  }

  MenuItemModel.fromJson(dynamic json) {
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
  }

  List<Items>? _items;

  MenuItemModel copyWith({
    List<Items>? items,
  }) =>
      MenuItemModel(
        items: items ?? _items,
      );

  List<Items>? get items => _items;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Items {
  Items({
    String? title,
    String? icon,
    String? route,
    bool? isFavorite,
    bool? isEdit,
    bool? isAuth,
  }) {
    _title = title;
    _icon = icon;
    _route = route;
    _isFavorite = isFavorite;
    _isEdit = isEdit;
    _isAuth = isAuth;
  }

  set isFavorite(bool value) {
    _isFavorite = value;
  }

  Items.fromJson(dynamic json) {
    _title = json['title'];
    _icon = json['icon'];
    _route = json['route'];
    _isFavorite = json['isFavorite'];
    _isEdit = json['isEdit'];
    _isAuth = json['isAuth'];
  }

  String? _title;
  String? _icon;
  String? _route;
  bool? _isFavorite;
  bool? _isEdit;
  bool? _isAuth;

  Items copyWith({
    String? title,
    String? icon,
    String? route,
    bool? isFavorite,
    bool? isEdit,
    bool? isAuth,
  }) =>
      Items(
        title: title ?? _title,
        icon: icon ?? _icon,
        route: route ?? _route,
        isFavorite: isFavorite ?? _isFavorite,
        isEdit: isEdit ?? _isEdit,
        isAuth: isAuth ?? _isAuth,
      );

  String? get title => _title;

  String? get icon => _icon;

  String? get route => _route;

  bool get isFavorite => _isFavorite ?? false;

  bool? get isEdit => _isEdit;

  bool? get isAuth => _isAuth;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['icon'] = _icon;
    map['route'] = _route;
    map['isFavorite'] = _isFavorite;
    map['isEdit'] = _isEdit;
    map['isAuth'] = _isAuth;
    return map;
  }
}
