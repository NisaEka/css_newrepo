class RequestPickupAddressCreateRequestModel {
  final String name;
  final String phone;
  final String address;
  final String zipCode;
  final String city;
  final String district;
  final String subDistrict;
  final String region;
  final double? lat;
  final double? lng;

  RequestPickupAddressCreateRequestModel({
    required this.name,
    required this.phone,
    required this.address,
    required this.zipCode,
    required this.city,
    required this.district,
    required this.subDistrict,
    required this.region,
    required this.lat,
    required this.lng,
  });

  factory RequestPickupAddressCreateRequestModel.fromJson(
          Map<String, dynamic> json) =>
      RequestPickupAddressCreateRequestModel(
        name: json['name'] as String,
        phone: json['phone'] as String,
        address: json['address'] as String,
        zipCode: json['zip_code'] as String,
        city: json['city'] as String,
        district: json['district'] as String,
        subDistrict: json['sub_district'] as String,
        region: json['region'] as String,
        lat: json['lat'] as double,
        lng: json['lng'] as double,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'address': address,
        'zip_code': zipCode,
        'city': city,
        'district': district,
        'sub_district': subDistrict,
        'region': region,
        'lat': lat,
        'lng': lng,
      };
}
