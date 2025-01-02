class StickerLabelModel {
  StickerLabelModel({
    int? copyLabel,
    String? priceLabel,
    String? hideShipperphoneLabel,
    List<SettingLabelsModel>? labels,
  }) {
    _copyLabel = copyLabel;
    _priceLabel = priceLabel;
    _hideShipperphoneLabel = hideShipperphoneLabel;
    _labels = labels;
  }

  StickerLabelModel.fromJson(dynamic json) {
    _copyLabel = json['copyLabel'];
    _priceLabel = json['priceLabel'];
    _hideShipperphoneLabel = json['hideShipperphoneLabel'];
    if (json['labels'] != null) {
      _labels = <SettingLabelsModel>[];
      json['labels'].forEach((v) {
        _labels!.add(SettingLabelsModel.fromJson(v));
      });
    }
  }

  int? _copyLabel;
  String? _priceLabel;
  String? _hideShipperphoneLabel;
  List<SettingLabelsModel>? _labels;

  StickerLabelModel copyWith({
    int? copyLabel,
    String? priceLabel,
    String? hideShipperphoneLabel,
    List<SettingLabelsModel>? labels,
  }) =>
      StickerLabelModel(
        copyLabel: copyLabel ?? _copyLabel,
        priceLabel: priceLabel ?? _priceLabel,
        hideShipperphoneLabel: hideShipperphoneLabel ?? _hideShipperphoneLabel,
        labels: labels ?? _labels,
      );

  int? get copyLabel => _copyLabel;

  String? get priceLabel => _priceLabel;

  String? get hideShipperphoneLabel => _hideShipperphoneLabel;

  List<SettingLabelsModel>? get labels => _labels;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['copyLabel'] = _copyLabel;
    map['priceLabel'] = _priceLabel;
    map['hideShipperphoneLabel'] = _hideShipperphoneLabel;
    if (_labels != null) {
      map['labels'] = _labels!.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class SettingLabelsModel {
  SettingLabelsModel({
    int? id,
    String? name,
    bool? enabled,
    String? image,
  }) {
    _id = id;
    _name = name;
    _enabled = enabled;
    _image = image;
  }

  SettingLabelsModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _enabled = json['enabled'];
    _image = json['image'];
  }

  int? _id;
  String? _name;
  bool? _enabled;
  String? _image;

  SettingLabelsModel copyWith({
    int? id,
    String? name,
    bool? enabled,
    String? image,
  }) =>
      SettingLabelsModel(
        id: id ?? _id,
        name: name ?? _name,
        enabled: enabled ?? _enabled,
        image: image ?? _image,
      );

  int? get id => _id;

  String? get name => _name;

  bool? get enabled => _enabled;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['enabled'] = _enabled;
    map['image'] = _image;
    return map;
  }
}
