class StickerLabelModel {
  StickerLabelModel({
    List<StickerLabel>? stickerLabel,
  }) {
    _stickerLabel = stickerLabel;
  }

  StickerLabelModel.fromJson(dynamic json) {
    if (json['sticker_label'] != null) {
      _stickerLabel = [];
      json['sticker_label'].forEach((v) {
        _stickerLabel?.add(StickerLabel.fromJson(v));
      });
    }
  }

  List<StickerLabel>? _stickerLabel;

  StickerLabelModel copyWith({
    List<StickerLabel>? stickerLabel,
  }) =>
      StickerLabelModel(
        stickerLabel: stickerLabel ?? _stickerLabel,
      );

  List<StickerLabel>? get stickerLabel => _stickerLabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_stickerLabel != null) {
      map['sticker_label'] = _stickerLabel?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class StickerLabel {
  StickerLabel({
    num? index,
    String? name,
    String? image,
  }) {
    _index = index;
    _name = name;
    _image = image;
  }

  StickerLabel.fromJson(dynamic json) {
    _index = json['index'];
    _name = json['name'];
    _image = json['image'];
  }

  num? _index;
  String? _name;
  String? _image;

  StickerLabel copyWith({
    num? index,
    String? name,
    String? image,
  }) =>
      StickerLabel(
        index: index ?? _index,
        name: name ?? _name,
        image: image ?? _image,
      );

  num? get index => _index;

  String? get name => _name;

  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['index'] = _index;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }
}
