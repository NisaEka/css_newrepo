import 'package:css_mobile/data/model/pengaturan/data_petugas_model.dart';

class GetPetugasByidModel {
  GetPetugasByidModel({
    num? code,
    String? message,
    DataPetugasModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetPetugasByidModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? DataPetugasModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  DataPetugasModel? _payload;

  GetPetugasByidModel copyWith({
    num? code,
    String? message,
    DataPetugasModel? payload,
  }) =>
      GetPetugasByidModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  DataPetugasModel? get payload => _payload;

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
