class RequestPickupAddressCreateRequestModel {
  final String pickupDataName;
  final String pickupDataPhone;
  final String pickupDataAddress;
  final String pickupDataZipCode;
  final String pickupDataCity;
  final String pickupDataDistrict;
  final String pickupDataSubdistrict;
  final String pickupDataRegion;
  final String? pickupDataLatitude;
  final String? pickupDataLongitude;

  RequestPickupAddressCreateRequestModel({
    required this.pickupDataName,
    required this.pickupDataPhone,
    required this.pickupDataAddress,
    required this.pickupDataZipCode,
    required this.pickupDataCity,
    required this.pickupDataDistrict,
    required this.pickupDataSubdistrict,
    required this.pickupDataRegion,
    required this.pickupDataLatitude,
    required this.pickupDataLongitude,
  });

  factory RequestPickupAddressCreateRequestModel.fromJson(
          Map<String, dynamic> json) =>
      RequestPickupAddressCreateRequestModel(
        pickupDataName: json['pickupDataName'] as String,
        pickupDataPhone: json['pickupDataPhone'] as String,
        pickupDataAddress: json['pickupDataAddress'] as String,
        pickupDataZipCode: json['pickupDataZipCode'] as String,
        pickupDataCity: json['pickupDataCity'] as String,
        pickupDataDistrict: json['pickupDataDistrict'] as String,
        pickupDataSubdistrict: json['pickupDataSubdistrict'] as String,
        pickupDataRegion: json['pickupDataRegion'] as String,
        pickupDataLatitude: json['pickupDataLatitude'] as String,
        pickupDataLongitude: json['pickupDataLongitude'] as String,
      );

  Map<String, dynamic> toJson() => {
        'pickupDataName': pickupDataName,
        'pickupDataPhone': pickupDataPhone,
        'pickupDataAddress': pickupDataAddress,
        'pickupDataZipCode': pickupDataZipCode,
        'pickupDataCity': pickupDataCity,
        'pickupDataDistrict': pickupDataDistrict,
        'pickupDataSubdistrict': pickupDataSubdistrict,
        'pickupDataRegion': pickupDataRegion,
        'pickupDataLatitude': pickupDataLatitude,
        'pickupDataLongitude': pickupDataLongitude,
      };
}
