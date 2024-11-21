class ReceiverModel {
  ReceiverModel({
    String? name,
    String? address,
    String? city,
    String? zipCode,
    String? region,
    String? country,
    String? contact,
    String? phone,
    String? destinationCode,
    String? destinationDescription,
    String? idDestination,
    String? idReceive,
    String? district,
    String? subDistrict,
    String? registrationId,
  }) {
    _name = name;
    _address = address;
    _city = city;
    _zipCode = zipCode;
    _region = region;
    _country = country;
    _contact = contact;
    _phone = phone;
    _destinationCode = destinationCode;
    _destinationDescription = destinationDescription;
    _idDestination = idDestination;
    _idReceive = idReceive;
    _receiverDistrict = district;
    _receiverSubDistrict = subDistrict;
    _registrationId = registrationId;
  }

  ReceiverModel.fromJson(dynamic json) {
    _name = json['name'] ?? json['receiverName'];
    _address = json['address'] ?? json['receiverAddr'];
    _city = json['city'] ?? json['receiverCity'];
    _zipCode = json['zip_code'] ?? json['receiverZip'];
    _region = json['region'] ?? json['receiverRegion'];
    _country = json['country'] ?? json['receiverCountry'];
    _contact = json['contact'] ?? json['receiverContact'];
    _phone = json['phone'] ?? json['receiverPhone'];
    _destinationCode = json['destination_code'] ?? json['destinationCode'];
    _destinationDescription = json['destination_description'] ??
        json['destinationDesc'] ??
        json['destination_desc'];
    _idDestination = json['idDest'];
    _idReceive = json['id_receive'] ?? json['idReceive'];
    _receiverDistrict = json['receiver_district'] ?? json['receiverDistrict'];
    _receiverSubDistrict =
        json['receiver_sub_district'] ?? json['receiverSubdistrict'];
    _registrationId = json['registration_id'] ?? json['registrationId'];
  }

  String? _name;
  String? _address;
  String? _city;
  String? _zipCode;
  String? _region;
  String? _country;
  String? _contact;
  String? _phone;
  String? _destinationCode;
  String? _destinationDescription;
  String? _idDestination;
  String? _idReceive;
  String? _receiverDistrict;
  String? _receiverSubDistrict;
  String? _registrationId;

  ReceiverModel copyWith({
    String? name,
    String? address,
    String? city,
    String? zipCode,
    String? region,
    String? country,
    String? contact,
    String? phone,
    String? destinationCode,
    String? destinationDescription,
    String? idDestination,
    String? idReceive,
    String? receiverDistrict,
    String? receiverSubDistrict,
    String? registrationId,
  }) =>
      ReceiverModel(
        name: name ?? _name,
        address: address ?? _address,
        city: city ?? _city,
        zipCode: zipCode ?? _zipCode,
        region: region ?? _region,
        country: country ?? _country,
        contact: contact ?? _contact,
        phone: phone ?? _phone,
        destinationCode: destinationCode ?? _destinationCode,
        destinationDescription:
            destinationDescription ?? _destinationDescription,
        idDestination: idDestination ?? _idDestination,
        idReceive: idReceive ?? _idReceive,
        district: receiverDistrict ?? _receiverDistrict,
        subDistrict: receiverSubDistrict ?? _receiverSubDistrict,
        registrationId: registrationId ?? _registrationId,
      );

  String? get name => _name;

  String? get address => _address;

  String? get city => _city;

  String? get zipCode => _zipCode;

  String? get region => _region;

  String? get country => _country;

  String? get contact => _contact;

  String? get phone => _phone;

  String? get destinationCode => _destinationCode;

  String? get destinationDescription => _destinationDescription;

  String? get idDestination => _idDestination;

  String? get idReceive => _idReceive;

  String? get district => _receiverDistrict;

  String? get subDistrict => _receiverSubDistrict;

  String? get registrationId => _registrationId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['address'] = _address;
    map['city'] = _city;
    map['zip_code'] = _zipCode;
    map['region'] = _region;
    map['country'] = _country;
    map['contact'] = _contact;
    map['phone'] = _phone;
    map['destination_code'] = _destinationCode;
    map['destination_description'] = _destinationDescription;
    map['destination_desc'] = _destinationDescription;
    map['id_destination'] = _idDestination;
    map['destination_id'] = _idDestination;
    map['id_receive'] = _idReceive;
    map['receiver_district'] = _receiverDistrict;
    map['receiver_sub_district'] = _receiverSubDistrict;
    map['registration_id'] = _registrationId;

    map['receiverName'] = _name;
    map['receiverAddr'] = _address;
    map['receiverCity'] = _city;
    map['receiverZip'] = _zipCode;
    map['receiverRegion'] = _region;
    map['receiverCountry'] = _country;
    map['receiverContact'] = _contact;
    map['receiverPhone'] = _phone;
    map['destinationCode'] = _destinationCode;
    map['destinationDesc'] = _destinationDescription;
    map['idDest'] = _destinationDescription;
    map['idReceive'] = _idReceive;
    map['receiverDistrict'] = _receiverDistrict;
    map['receiverSubdistrict'] = _receiverSubDistrict;
    map['registrationId'] = _registrationId;

    return map;
  }
}
