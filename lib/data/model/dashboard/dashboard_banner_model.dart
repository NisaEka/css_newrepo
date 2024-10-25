class DashboardBannerModel {
  DashboardBannerModel({
    bool? status,
    List<BannerModel>? data,
  }) {
    _status = status;
    _data = data;
  }

  DashboardBannerModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(BannerModel.fromJson(v));
      });
    }
  }
  bool? _status;
  List<BannerModel>? _data;
  DashboardBannerModel copyWith({
    bool? status,
    List<BannerModel>? data,
  }) =>
      DashboardBannerModel(
        status: status ?? _status,
        data: data ?? _data,
      );
  bool? get status => _status;
  List<BannerModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

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
    _namaBanner = json['nama_banner'];
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
    map['nama_banner'] = _namaBanner;
    map['picture'] = _picture;
    map['link'] = _link;
    return map;
  }
}
