import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';

class DataPetugasModel {
  DataPetugasModel({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? zipCode,
    Menu? menu,
    Transaction? transaction,
    List<Account>? accounts,
    List<String>? origins,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _password = password;
    _address = address;
    _zipCode = zipCode;
    _menu = menu;
    _transaction = transaction;
    _accounts = accounts;
    _origins = origins;
  }

  DataPetugasModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _password = json['password'];
    _address = json['address'];
    _zipCode = json['zip_code'];
    _menu = json['menu'] != null ? Menu.fromJson(json['menu']) : null;
    _transaction = json['transaction'] != null ? Transaction.fromJson(json['transaction']) : null;
    if (json['accounts'] != null) {
      _accounts = [];
      json['accounts'].forEach((v) {
        _accounts?.add(Account.fromJson(v));
      });
    }
    _origins = json['origins'] != null ? json['origins'].cast<String>() : [];
  }

  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _password;
  String? _address;
  String? _zipCode;
  Menu? _menu;
  Transaction? _transaction;
  List<Account>? _accounts;
  List<String>? _origins;

  DataPetugasModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? address,
    String? zipCode,
    Menu? menu,
    Transaction? transaction,
    List<Account>? accounts,
    List<String>? origins,
  }) =>
      DataPetugasModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        password: password ?? _password,
        address: address ?? _address,
        zipCode: zipCode ?? _zipCode,
        menu: menu ?? _menu,
        transaction: transaction ?? _transaction,
        accounts: accounts ?? _accounts,
        origins: origins ?? _origins,
      );

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get password => _password;

  String? get address => _address;

  String? get zipCode => _zipCode;

  Menu? get menu => _menu;

  Transaction? get transaction => _transaction;

  List<Account>? get accounts => _accounts;

  List<String>? get origins => _origins;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['password'] = _password;
    map['address'] = _address;
    map['zip_code'] = _zipCode;
    if (_menu != null) {
      map['menu'] = _menu?.toJson();
    }
    if (_transaction != null) {
      map['transaction'] = _transaction?.toJson();
    }
    if (_accounts != null) {
      map['accounts'] = _accounts?.map((v) => v.toJson()).toList();
    }
    map['origins'] = _origins;
    return map;
  }
}

class Transaction {
  Transaction({
    String? show,
    String? delete,
  }) {
    _show = show;
    _delete = delete;
  }

  Transaction.fromJson(dynamic json) {
    _show = json['show'];
    _delete = json['delete'];
  }

  String? _show;
  String? _delete;

  Transaction copyWith({
    String? show,
    String? delete,
  }) =>
      Transaction(
        show: show ?? _show,
        delete: delete ?? _delete,
      );

  String? get show => _show;

  String? get delete => _delete;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['show'] = _show;
    map['delete'] = _delete;
    return map;
  }
}


