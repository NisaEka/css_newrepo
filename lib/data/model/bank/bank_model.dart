class BankModel {
  BankModel({
    String? id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  BankModel.fromJson(dynamic json) {
    _id = json['bankId'];
    _name = json['bankName'];
  }

  String? _id;
  String? _name;

  BankModel copyWith({
    String? id,
    String? name,
  }) =>
      BankModel(
        id: id ?? _id,
        name: name ?? _name,
      );

  String? get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['bankId'] = _id;
    map['bankName'] = _name;

    return map;
  }
}
