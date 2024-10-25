import 'dart:convert';

ProfilListModel profilListModelFromJson(String str) =>
    ProfilListModel.fromJson(json.decode(str));

String profilListModelToJson(ProfilListModel data) =>
    json.encode(data.toJson());

class ProfilListModel {
  ProfilListModel({
    String? leading,
    String? title,
    String? trailing,
    bool? isShow,
  }) {
    _leading = leading;
    _title = title;
    _trailing = trailing;
    _isShow = isShow;
  }

  bool? get isShow => _isShow;

  set isShow(bool? value) {
    _isShow = value;
  }

  ProfilListModel.fromJson(dynamic json) {
    _leading = json['leading'];
    _title = json['title'];
    _trailing = json['trailing'];
    _isShow = json['isShow'];
  }

  String? _leading;
  String? _title;
  String? _trailing;
  bool? _isShow;

  ProfilListModel copyWith({
    String? leading,
    String? title,
    String? trailing,
    bool? isShow,
  }) =>
      ProfilListModel(
        leading: leading ?? _leading,
        title: title ?? _title,
        trailing: trailing ?? _trailing,
        isShow: isShow ?? _isShow,
      );

  String? get leading => _leading;

  String? get title => _title;

  String? get trailing => _trailing;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['leading'] = _leading;
    map['title'] = _title;
    map['trailing'] = _trailing;
    map['isShow'] = _isShow;
    return map;
  }
}
