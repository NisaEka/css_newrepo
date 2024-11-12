class BankModel {
  String _id = '';
  String get id => _id;

  String _name = '';
  String get name => _name;

  BankModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
}
