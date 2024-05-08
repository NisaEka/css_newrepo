class FacilityCreateIdCardModel {

  String _number = "";
  String get number => _number;

  String _imageUrl = "";
  String get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};

    json['id_card_number'] = _number;
    json['id_card_image_url'] = _imageUrl;

    return json;
  }

}