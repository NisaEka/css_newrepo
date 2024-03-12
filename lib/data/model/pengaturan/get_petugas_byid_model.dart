import 'package:css_mobile/data/model/pengaturan/get_petugas_model.dart';

class GetPetugasByidModel {
  GetPetugasByidModel({
    num? code,
    String? message,
    PetugasModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetPetugasByidModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? PetugasModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  PetugasModel? _payload;

  GetPetugasByidModel copyWith({
    num? code,
    String? message,
    PetugasModel? payload,
  }) =>
      GetPetugasByidModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  PetugasModel? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}
