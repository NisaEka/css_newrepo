class StickerLabelModel {
  StickerLabelModel({
    num? index,
    String? name,
    String? image,
    bool? enable,
    bool? showPrice,
  }) {
    _index = index;
    _name = name;
    _image = image;
    _enable = enable;
    _showPrice = showPrice;
  }

  StickerLabelModel.fromJson(dynamic json) {
    _index = json['index'];
    _name = json['name'];
    _image = json['image'];
    _enable = json['enabled'];
    _showPrice = json['show_price'];
  }

  num? _index;
  String? _name;
  String? _image;
  bool? _enable;
  bool? _showPrice;

  StickerLabelModel copyWith({
    num? index,
    String? name,
    String? image,
    bool? enable,
    bool? showPrice,
  }) =>
      StickerLabelModel(
        index: index ?? _index,
        name: name ?? _name,
        image: image ?? _image,
        enable: enable ?? _enable,
        showPrice: showPrice ?? _showPrice,
      );

  num? get index => _index;

  String? get name => _name;

  String? get image => _image;

  bool? get enable => _enable;

  bool? get showPrice => _showPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['name'] = _name;
    map['image'] = _image;
    map['enabled'] = _enable;
    map['showPrice'] = _showPrice;
    return map;
  }
}
