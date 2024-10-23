import 'package:css_mobile/data/model/auth/get_login_model.dart';
import 'package:css_mobile/data/model/master/get_accounts_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';

import 'package:css_mobile/data/model/master/get_origin_model.dart';

class GetPetugasByidModel {
  GetPetugasByidModel({
    num? code,
    String? message,
    PetugasModel? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetPetugasByidModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null ? PetugasModel.fromJson(json['payload']) : null;
  }

  num? _code;
  String? _message;
  PetugasModel? _payload;

  GetPetugasByidModel copyWith({
    num? code,
    String? message,
    PetugasModel? payload,
  }) =>
      GetPetugasByidModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  PetugasModel? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.toJson();
    }
    return map;
  }
}

class PetugasModel {
  PetugasModel({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? branch,
    String? zipCode,
    String? origin,
    String? status,
    AllowedMenu? menu,
    List<Account>? accounts,
    List<Origin>? origins,
    List<Branch>? branches,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _phone = phone;
    _branch = branch;
    _zipCode = zipCode;
    _origin = origin;

    _status = status;
    _menu = menu;
    _accounts = accounts;
    _origins = origins;
    _branches = branches;
  }

  PetugasModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _phone = json['phone'];
    _branch = json['branch'];
    _zipCode = json['zip_code'];
    _origin = json['origin'];

    _status = json['status'];
    _menu = json['menu'] != null ? AllowedMenu.fromJson(json['menu']) : null;
    if (json['accounts'] != null) {
      _accounts = [];
      json['accounts'].forEach((v) {
        _accounts?.add(Account.fromJson(v));
      });
    }
    if (json['origins'] != null) {
      _origins = [];
      json['origins'].forEach((v) {
        _origins?.add(Origin.fromJson(v));
      });
    }
    if (json['branches'] != null) {
      _branches = [];
      json['branches'].forEach((v) {
        _branches?.add(Branch.fromJson(v));
      });
    }
  }

  String? _id;
  String? _name;
  String? _email;
  String? _phone;
  String? _branch;
  String? _zipCode;
  String? _origin;

  String? _status;
  AllowedMenu? _menu;
  List<Account>? _accounts;
  List<Origin>? _origins;
  List<Branch>? _branches;

  PetugasModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? branch,
    String? zipCode,
    String? origin,
    String? status,
    AllowedMenu? menu,
    List<Account>? accounts,
    List<Origin>? origins,
    List<Branch>? branches,
  }) =>
      PetugasModel(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        phone: phone ?? _phone,
        branch: branch ?? _branch,
        zipCode: zipCode ?? _zipCode,
        origin: origin ?? _origin,
        status: status ?? _status,
        menu: menu ?? _menu,
        accounts: accounts ?? _accounts,
        origins: origins ?? _origins,
        branches: branches ?? _branches,
      );

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  String? get phone => _phone;

  String? get branch => _branch;

  String? get zipCode => _zipCode;

  String? get origin => _origin;

  String? get status => _status;

  AllowedMenu? get menu => _menu;

  List<Account>? get accounts => _accounts;

  List<Origin>? get origins => _origins;

  List<Branch>? get branches => _branches;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['phone'] = _phone;
    map['branch'] = _branch;
    map['zip_code'] = _zipCode;
    map['origin'] = _origin;
    map['status'] = _status;
    if (_menu != null) {
      map['menu'] = _menu?.toJson();
    }
    if (_accounts != null) {
      map['accounts'] = _accounts?.map((v) => v.toJson()).toList();
    }
    if (_origins != null) {
      map['origins'] = _origins?.map((v) => v.toJson()).toList();
    }
    if (_branches != null) {
      map['branches'] = _branches?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AvailableService {
  AvailableService({
    String? ss,
    String? yes,
    String? reg,
    String? oke,
    String? jtr,
    String? intl,
  }) {
    _ss = ss;
    _yes = yes;
    _reg = reg;
    _oke = oke;
    _jtr = jtr;
    _intl = intl;
  }

  AvailableService.fromJson(dynamic json) {
    _ss = json['ss'];
    _yes = json['yes'];
    _reg = json['reg'];
    _oke = json['oke'];
    _jtr = json['jtr'];
    _intl = json['intl'];
  }

  String? _ss;
  String? _yes;
  String? _reg;
  String? _oke;
  String? _jtr;
  String? _intl;

  AvailableService copyWith({
    String? ss,
    String? yes,
    String? reg,
    String? oke,
    String? jtr,
    String? intl,
  }) =>
      AvailableService(
        ss: ss ?? _ss,
        yes: yes ?? _yes,
        reg: reg ?? _reg,
        oke: oke ?? _oke,
        jtr: jtr ?? _jtr,
        intl: intl ?? _intl,
      );

  String? get ss => _ss;

  String? get yes => _yes;

  String? get reg => _reg;

  String? get oke => _oke;

  String? get jtr => _jtr;

  String? get intl => _intl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ss'] = _ss;
    map['yes'] = _yes;
    map['reg'] = _reg;
    map['oke'] = _oke;
    map['jtr'] = _jtr;
    map['intl'] = _intl;
    return map;
  }
}


