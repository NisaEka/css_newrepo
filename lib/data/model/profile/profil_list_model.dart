import 'dart:convert';

ProfilListModel profilListModelFromJson(String str) =>
    ProfilListModel.fromJson(json.decode(str));

String profilListModelToJson(ProfilListModel data) =>
    json.encode(data.toJson());

class ProfilListModel {
  String? leading;
  String? title;
  String? trailing;
  bool? isShow;

  ProfilListModel({
    this.leading,
    this.title,
    this.trailing,
    this.isShow,
  });

  ProfilListModel.fromJson(Map<String, dynamic> json)
      : leading = json['leading'],
        title = json['title'],
        trailing = json['trailing'],
        isShow = json['isShow'];

  ProfilListModel copyWith({
    String? leading,
    String? title,
    String? trailing,
    bool? isShow,
  }) {
    return ProfilListModel(
      leading: leading ?? this.leading,
      title: title ?? this.title,
      trailing: trailing ?? this.trailing,
      isShow: isShow ?? this.isShow,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leading': leading,
      'title': title,
      'trailing': trailing,
      'isShow': isShow,
    };
  }
}
