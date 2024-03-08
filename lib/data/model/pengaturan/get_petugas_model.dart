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

class PetugasModel {
  PetugasModel({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? branch,
    String? origin,
    String? status,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _branch = branch;
    _origin = origin;
    _status = status;
  }

  PetugasModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _branch = json['branch'];
    _origin = json['origin'];
    _status = json['status'];
  }

  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _branch;
  String? _origin;
  String? _status;

  PetugasModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? branch,
    String? origin,
    String? status,
  }) =>
      PetugasModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        branch: branch ?? _branch,
        origin: origin ?? _origin,
        status: status ?? _status,
      );

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get branch => _branch;

  String? get origin => _origin;

  String? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['branch'] = _branch;
    map['origin'] = _origin;
    map['status'] = _status;
    return map;
  }
}
