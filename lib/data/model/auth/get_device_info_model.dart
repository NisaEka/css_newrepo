class DeviceModel {
  DeviceModel({
    num? id,
    String? registrationId,
    String? fcmToken,
    String? deviceId,
    String? versionOs,
    String? createdDate,
  }) {
    _id = id;
    _registrationId = registrationId;
    _fcmToken = fcmToken;
    _deviceId = deviceId;
    _versionOs = versionOs;
    _createdDate = createdDate;
  }

  DeviceModel.fromJson(dynamic json) {
    _id = json['id'];
    _registrationId = json['registrationId'];
    _fcmToken = json['fcmToken'];
    _deviceId = json['deviceId'];
    _versionOs = json['versionOs'];
    _createdDate = json['createdDate'];
  }

  num? _id;
  String? _registrationId;
  String? _fcmToken;
  String? _deviceId;
  String? _versionOs;
  String? _createdDate;

  DeviceModel copyWith({
    num? id,
    String? registrationId,
    String? fcmToken,
    String? deviceId,
    String? versionOs,
    String? createdDate,
  }) =>
      DeviceModel(
        id: id ?? _id,
        registrationId: registrationId ?? _registrationId,
        fcmToken: fcmToken ?? _fcmToken,
        deviceId: deviceId ?? _deviceId,
        versionOs: versionOs ?? _versionOs,
        createdDate: createdDate ?? _createdDate,
      );

  num? get id => _id;

  String? get registrationId => _registrationId;

  String? get fcmToken => _fcmToken;

  String? get deviceId => _deviceId;

  String? get versionOs => _versionOs;

  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['registrationId'] = _registrationId;
    map['fcmToken'] = _fcmToken;
    map['deviceId'] = _deviceId;
    map['versionOs'] = _versionOs;
    map['createdDate'] = _createdDate;
    return map;
  }
}
