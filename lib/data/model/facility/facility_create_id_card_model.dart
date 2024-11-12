class FacilityCreateIdCardModel {
  String _number = "";
  String get number => _number;

  String _imageUrl = "";
  String get imageUrl => _imageUrl;

  setNumber(String number) {
    _number = number;
  }

  setImageUrl(String imageUrl) {
    _imageUrl = imageUrl;
  }

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['id_card_number'] = _number;
    json['id_card_image_url'] = _imageUrl;

    return json;
  }
}
