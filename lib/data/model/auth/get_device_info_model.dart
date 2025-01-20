class DeviceInfoModel {
  DeviceInfoModel({
    int? id,
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

  DeviceInfoModel.fromJson(dynamic json) {
    _id = json['id'];
    _registrationId = json['registrationId'];
    _fcmToken = json['fcmToken'];
    _deviceId = json['deviceId'];
    _versionOs = json['versionOs'];
    _createdDate = json['createdDate'];
  }

  int? _id;
  String? _registrationId;
  String? _fcmToken;
  String? _deviceId;
  String? _versionOs;
  String? _createdDate;

  DeviceInfoModel copyWith({
    int? id,
    String? registrationId,
    String? fcmToken,
    String? deviceId,
    String? versionOs,
    String? createdDate,
  }) =>
      DeviceInfoModel(
        id: id ?? _id,
        registrationId: registrationId ?? _registrationId,
        fcmToken: fcmToken ?? _fcmToken,
        deviceId: deviceId ?? _deviceId,
        versionOs: versionOs ?? _versionOs,
        createdDate: createdDate ?? _createdDate,
      );

  int? get id => _id;

  String? get registrationId => _registrationId;

  String? get fcmToken => _fcmToken;

  String? get deviceId => _deviceId;

  String? get versionOs => _versionOs;

  String? get createdDate => _createdDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_id != null) {
      map['id'] = _id;
    }
    map['registrationId'] = _registrationId;
    map['fcmToken'] = _fcmToken;
    map['deviceId'] = _deviceId;
    map['versionOs'] = _versionOs;
    map['createdDate'] = _createdDate;
    return map;
  }
}
