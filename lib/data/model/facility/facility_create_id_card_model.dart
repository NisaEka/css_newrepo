class FacilityCreateIdCardModel {
  String _number = "";

  String get number => _number;

  String _imageUrl = "";

  String get imageUrl => _imageUrl;

  FacilityCreateIdCardModel({
    String? number,
    String? imageUrl,
  }) {
    _number = number ?? '';
    _imageUrl = imageUrl ?? '';
  }

  setNumber(String number) {
    _number = number;
  }

  setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['idCardNumber'] = _number;
    json['idCardImageUrl'] = _imageUrl;

    return json;
  }

  FacilityCreateIdCardModel.fromJson(dynamic json) {
    _number = json['idCardNumber'];
    _imageUrl = json['idCardImageUrl'];
  }
}
