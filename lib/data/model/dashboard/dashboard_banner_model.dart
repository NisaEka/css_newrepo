class BannerModel {
  BannerModel({
    String? name,
    String? picture,
    String? link,
  }) {
    _name = name;
    _picture = picture;
    _link = link;
  }

  BannerModel.fromJson(dynamic json) {
    _name = json['namaBanner'];
    _picture = json['picture'];
    _link = json['link'];
  }

  String? _name;
  String? _picture;
  String? _link;

  BannerModel copyWith({
    String? name,
    String? picture,
    String? link,
  }) =>
      BannerModel(
        name: name ?? _name,
        picture: picture ?? _picture,
        link: link ?? _link,
      );

  String? get namaBanner => _name;

  String? get picture => _picture;

  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['namaBanner'] = _name;
    map['picture'] = _picture;
    map['link'] = _link;
    return map;
  }
}
