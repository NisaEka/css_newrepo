import 'get_device_info_model.dart';

class InputLoginModel {
  InputLoginModel({
    String? email,
    String? password,
    DeviceModel? device,
    Coordinate? coordinate,
  }) {
    _email = email;
    _password = password;
    _device = device;
    _coordinate = coordinate;
  }

  InputLoginModel.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _device = json['device'] != null ? DeviceModel.fromJson(json['device']) : null;
    _coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : null;
  }

  String? _email;
  String? _password;
  DeviceModel? _device;
  Coordinate? _coordinate;

  InputLoginModel copyWith({
    String? email,
    String? password,
    DeviceModel? device,
    Coordinate? coordinate,
  }) =>
      InputLoginModel(
        email: email ?? _email,
        password: password ?? _password,
        device: device ?? _device,
        coordinate: coordinate ?? _coordinate,
      );

  String? get email => _email;

  String? get password => _password;

  DeviceModel? get device => _device;

  Coordinate? get coordinate => _coordinate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    map['password'] = _password;
    if (_device != null) {
      map['device'] = _device?.toJson();
    }
    if (_coordinate != null) {
      map['coordinate'] = _coordinate?.toJson();
    }
    return map;
  }
}

class Coordinate {
  Coordinate({
    num? lat,
    num? lng,
  }) {
    _lat = lat;
    _lng = lng;
  }

  Coordinate.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }

  num? _lat;
  num? _lng;

  Coordinate copyWith({
    num? lat,
    num? lng,
  }) =>
      Coordinate(
        lat: lat ?? _lat,
        lng: lng ?? _lng,
      );

  num? get lat => _lat;

  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }
}


