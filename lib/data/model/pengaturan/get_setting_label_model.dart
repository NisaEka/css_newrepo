import 'package:css_mobile/data/model/dashboard/sticker_label_model.dart';

class GetSettingLabelModel {
  GetSettingLabelModel({
    num? code,
    String? message,
    List<StickerLabel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetSettingLabelModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(StickerLabel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<StickerLabel>? _payload;

  GetSettingLabelModel copyWith({
    num? code,
    String? message,
    List<StickerLabel>? payload,
  }) =>
      GetSettingLabelModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<StickerLabel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
