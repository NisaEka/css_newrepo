class VehicleModel {
  VehicleModel({
      String? vehicleId, 
      String? vehicleName, 
      String? vehicleStatus, 
      String? vehicleCreatedBy, 
      String? vehicleCreatedDate,}){
    _vehicleId = vehicleId;
    _vehicleName = vehicleName;
    _vehicleStatus = vehicleStatus;
    _vehicleCreatedBy = vehicleCreatedBy;
    _vehicleCreatedDate = vehicleCreatedDate;
}

  VehicleModel.fromJson(dynamic json) {
    _vehicleId = json['vehicleId'];
    _vehicleName = json['vehicleName'];
    _vehicleStatus = json['vehicleStatus'];
    _vehicleCreatedBy = json['vehicleCreatedBy'];
    _vehicleCreatedDate = json['vehicleCreatedDate'];
  }
  String? _vehicleId;
  String? _vehicleName;
  String? _vehicleStatus;
  String? _vehicleCreatedBy;
  String? _vehicleCreatedDate;
VehicleModel copyWith({  String? vehicleId,
  String? vehicleName,
  String? vehicleStatus,
  String? vehicleCreatedBy,
  String? vehicleCreatedDate,
}) => VehicleModel(  vehicleId: vehicleId ?? _vehicleId,
  vehicleName: vehicleName ?? _vehicleName,
  vehicleStatus: vehicleStatus ?? _vehicleStatus,
  vehicleCreatedBy: vehicleCreatedBy ?? _vehicleCreatedBy,
  vehicleCreatedDate: vehicleCreatedDate ?? _vehicleCreatedDate,
);
  String? get vehicleId => _vehicleId;
  String? get vehicleName => _vehicleName;
  String? get vehicleStatus => _vehicleStatus;
  String? get vehicleCreatedBy => _vehicleCreatedBy;
  String? get vehicleCreatedDate => _vehicleCreatedDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['vehicleId'] = _vehicleId;
    map['vehicleName'] = _vehicleName;
    map['vehicleStatus'] = _vehicleStatus;
    map['vehicleCreatedBy'] = _vehicleCreatedBy;
    map['vehicleCreatedDate'] = _vehicleCreatedDate;
    return map;
  }

}