class BannerModel {
  BannerModel({
    String? namaBanner,
    String? picture,
    String? link,
  }) {
    _namaBanner = namaBanner;
    _picture = picture;
    _link = link;
  }

  BannerModel.fromJson(dynamic json) {
    _namaBanner = json['namaBanner'];
    _picture = json['picture'];
    _link = json['link'];
  }

  String? _namaBanner;
  String? _picture;
  String? _link;

  BannerModel copyWith({
    String? namaBanner,
    String? picture,
    String? link,
  }) =>
      BannerModel(
        namaBanner: namaBanner ?? _namaBanner,
        picture: picture ?? _picture,
        link: link ?? _link,
      );

  String? get namaBanner => _namaBanner;

  String? get picture => _picture;

  String? get link => _link;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['namaBanner'] = _namaBanner;
    map['picture'] = _picture;
    map['link'] = _link;
    return map;
  }
}
