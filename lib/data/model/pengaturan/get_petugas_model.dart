import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';

class GetPetugasModel {
  GetPetugasModel({
    num? code,
    String? message,
    List<PetugasModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetPetugasModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(PetugasModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<PetugasModel>? _payload;

  GetPetugasModel copyWith({
    num? code,
    String? message,
    List<PetugasModel>? payload,
  }) =>
      GetPetugasModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<PetugasModel>? get payload => _payload;

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


