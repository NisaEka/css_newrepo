import 'dart:convert';

DropshipperModel dropshipperFromJson(String str) =>
    DropshipperModel.fromJson(json.decode(str));

String dropshipperToJson(DropshipperModel data) => json.encode(data.toJson());

class DropshipperModel {
  DropshipperModel({
    this.id,
    this.name,
    this.phone,
    this.zipCode,
    this.city,
    this.address,
    this.registrationId,
    this.createdDate,
    this.originCode,
  });

  factory DropshipperModel.fromJson(Map<String, dynamic> json) {
    return DropshipperModel(
      id: json['id'] ?? json['dropshipperId'],
      name: json['name'] ?? json['dropshipperName'],
      phone: json['phone'] ?? json['dropshipperPhone'],
      zipCode: json['zip_code'] ?? json['dropshipperZip'],
      city: json['city'] ?? json['dropshipperCity'],
      address: json['address'] ?? json['dropshipperAddress'],
      registrationId: json['registrationId'],
      createdDate: json['createdDate'],
      originCode:
          json['origin_code'] ?? json['dropshipperOrigin'] ?? json['origin'],
    );
  }

  final String? id;
  final String? name;
  final String? phone;
  final String? zipCode;
  final String? city;
  final String? address;
  final String? registrationId;
  final String? createdDate;
  final String? originCode;

  /// CopyWith Method
  DropshipperModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? zipCode,
    String? city,
    String? address,
    String? registrationId,
    String? createdDate,
    String? originCode,
  }) {
    return DropshipperModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      zipCode: zipCode ?? this.zipCode,
      city: city ?? this.city,
      address: address ?? this.address,
      registrationId: registrationId ?? this.registrationId,
      createdDate: createdDate ?? this.createdDate,
      originCode: originCode ?? this.originCode,
    );
  }

  /// Convert object to JSON map
  Map<String, dynamic> toJson() => {
        'dropshipperId': id,
        'dropshipperName': name,
        'dropshipperPhone': phone,
        'dropshipperZip': zipCode,
        'dropshipperCity': city,
        'dropshipperAddress': address,
        'registrationId': registrationId,
        'createdDate': createdDate,
        'dropshipperOrigin': originCode,
      };
}
