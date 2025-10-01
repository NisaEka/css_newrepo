class DeviceInfoModel {
  DeviceInfoModel({
    int? id,
    String? registrationId,
    String? fcmToken,
    String? deviceId,
    String? deviceOS,
    String? createdDate,
    String? deviceName,
    String? deviceModel,
    String? deviceBrand,
  }) {
    _id = id;
    _registrationId = registrationId;
    _fcmToken = fcmToken;
    _deviceId = deviceId;
    _deviceOs = deviceOS;
    _createdDate = createdDate;
    _deviceName = deviceName;
    _deviceModel = deviceModel;
    _deviceBrand = deviceBrand;
  }

  DeviceInfoModel.fromJson(dynamic json) {
    _id = json['id'];
    _registrationId = json['registrationId'];
    _fcmToken = json['fcmToken'];
    _deviceId = json['deviceId'];
    _deviceOs = json['versionOs'] ?? json['deviceOs'];
    _createdDate = json['createdDate'];
    _deviceName = json['deviceName'];
    _deviceModel = json['deviceModel'];
    _deviceBrand = json['deviceBrand'];
  }

  int? _id;
  String? _registrationId;
  String? _fcmToken;
  String? _deviceId;
  String? _deviceOs;
  String? _createdDate;
  String? _deviceName;
  String? _deviceModel;
  String? _deviceBrand;

  DeviceInfoModel copyWith({
    int? id,
    String? registrationId,
    String? fcmToken,
    String? deviceId,
    String? versionOs,
    String? createdDate,
    String? deviceName,
    String? deviceModel,
    String? deviceBrand,
  }) =>
      DeviceInfoModel(
        id: id ?? _id,
        registrationId: registrationId ?? _registrationId,
        fcmToken: fcmToken ?? _fcmToken,
        deviceId: deviceId ?? _deviceId,
        deviceOS: versionOs ?? _deviceOs,
        createdDate: createdDate ?? _createdDate,
        deviceName: deviceName ?? _deviceName,
        deviceModel: deviceModel ?? _deviceModel,
        deviceBrand: deviceBrand ?? _deviceBrand,
      );

  int? get id => _id;

  String? get registrationId => _registrationId;

  String? get fcmToken => _fcmToken;

  String? get deviceId => _deviceId;

  String? get deviceOs => _deviceOs;

  String? get createdDate => _createdDate;

  String? get deviceName => _deviceName;

  String? get deviceModel => _deviceModel;

  String? get deviceBrand => _deviceBrand;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }
    map['registrationId'] = _registrationId;
    map['fcmToken'] = _fcmToken;
    map['deviceId'] = _deviceId;
    if (_deviceOs != null) {
      map['versionOs'] = _deviceOs;
      map['deviceOs'] = _deviceOs;
    }
    map['createdDate'] = _createdDate;
    if (_deviceName != null) {
      map['deviceName'] = _deviceName;
    }
    if (_deviceModel != null) {
      map['deviceModel'] = _deviceModel;
    }
    if (_deviceBrand != null) {
      map['deviceBrand'] = _deviceBrand;
    }
    return map;
  }
}
