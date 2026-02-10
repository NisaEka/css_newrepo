import 'get_device_info_model.dart';

class AuthBodyModel {
  AuthBodyModel({
    String? email,
    String? password,
    String? refreshToken,
    DeviceInfoModel? device,
    Coordinate? coordinate,
  }) {
    _email = email;
    _password = password;
    _refreshToken = refreshToken;
    _device = device;
    _coordinate = coordinate;
  }

  AuthBodyModel.fromJson(dynamic json) {
    _email = json['email'];
    _password = json['password'];
    _refreshToken = json['refreshToken'];
    _device = json['device'] != null
        ? DeviceInfoModel.fromJson(json['device'])
        : json['deviceInfo'] != null
            ? DeviceInfoModel.fromJson(json['deviceInfo'])
            : null;
    _coordinate = json['coordinate'] != null
        ? Coordinate.fromJson(json['coordinate'])
        : json['longlat'] != null
            ? Coordinate.fromString(json['longlat'])
            : null;
  }

  String? _email;
  String? _password;
  String? _refreshToken;
  DeviceInfoModel? _device;
  Coordinate? _coordinate;

  AuthBodyModel copyWith({
    String? email,
    String? password,
    String? refreshToken,
    DeviceInfoModel? device,
    Coordinate? coordinate,
  }) =>
      AuthBodyModel(
        email: email ?? _email,
        password: password ?? _password,
        refreshToken: refreshToken ?? _refreshToken,
        device: device ?? _device,
        coordinate: coordinate ?? _coordinate,
      );

  String? get email => _email;

  String? get password => _password;

  String? get refreshToken => _refreshToken;

  DeviceInfoModel? get device => _device;

  Coordinate? get coordinate => _coordinate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_email != null) {
      map['email'] = _email;
    }
    if (_password != null) {
      map['password'] = _password;
    }
    if (_refreshToken != null) {
      map['refreshToken'] = _refreshToken;
    }
    if (_device != null) {
      map['device'] = _device?.toJson();
      map['deviceInfo'] = _device?.toJson();
    }
    if (_coordinate != null) {
      map['coordinate'] = _coordinate?.toJson();
      map['longlat'] = _coordinate?.toLongLatString();
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

  factory Coordinate.fromString(String value) {
    final parts = value.split(",");
    return Coordinate(
      lat: double.parse(parts[0].trim()),
      lng: double.parse(parts[1].trim()),
    );
  }

  /// convert dari model ke string "lat,long"
  String toLongLatString() {
    return "$_lat,$_lng";
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
