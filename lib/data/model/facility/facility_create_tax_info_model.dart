class FacilityCreateTaxInfoModel {
  String _type = '';

  String get type => _type;

  String _name = '';

  String get name => _name;

  String _number = '';

  String get number => _number;

  String _address = '';

  String get address => _address;

  String _imageUrl = '';

  String get imageUrl => _imageUrl;

  FacilityCreateTaxInfoModel({
    String? type,
    String? name,
    String? number,
    String? address,
    String? imageUrl,
  }) {
    _type = type ?? '';
    _name = name ?? '';
    _number = number ?? '';
    _address = address ?? '';
    _imageUrl = imageUrl ?? '';
  }

  setType(String type) {
    _type = type;
  }

  setName(String name) {
    _name = name;
  }

  setNumber(String number) {
    _number = number;
  }

  setAddress(String address) {
    _address = address;
  }

  setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['type'] = _type;
    json['name'] = _name;
    json['number'] = _number;
    json['address'] = _address;
    json['imageUrl'] = _imageUrl;

    return json;
  }

  FacilityCreateTaxInfoModel.fromJson(dynamic json) {
    _type = json['type'];
    _name = json['name'];
    _number = json['number'];
    _address = json['address'];
    _imageUrl = json['imageUrl'];
  }
}
