import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/get_region_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_branch_model.dart';

class UserProfileModel {
  UserProfileModel({
    UserModel? user,
    MenuModel? menu,
  }) {
    _user = user;
    _menu = menu;
  }

  UserProfileModel.fromJson(dynamic json) {
    _user = json['me'] != null ? UserModel.fromJson(json['me']) : null;
    _menu = json['menu'] != null ? MenuModel.fromJson(json['menu']) : null;
  }

  UserModel? _user;
  MenuModel? _menu;

  UserProfileModel copyWith({
    UserModel? user,
    MenuModel? menu,
  }) =>
      UserProfileModel(
        user: user ?? _user,
        menu: menu ?? _menu,
      );

  UserModel? get user => _user;

  MenuModel? get menu => _menu;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_user != null) {
      map['me'] = _user?.toJson();
    }
    if (_menu != null) {
      map['menu'] = _menu?.toJson();
    }
    return map;
  }
}

class UserModel {
  UserModel({
    String? id,
    Region? region,
    BranchModel? branch,
    OriginModel? origin,
    String? zipCode,
    String? name,
    String? brand,
    String? phone,
    String? address,
    String? username,
    String? email,
    String? userType,
    String? emailRecovery,
  }) {
    _id = id;
    _region = region;
    _branch = branch;
    _origin = origin;
    _zipCode = zipCode;
    _name = name;
    _brand = brand;
    _phone = phone;
    _address = address;
    _username = username;
    _email = email;
    _userType = userType;
    _emailRecovery = emailRecovery;
  }

  UserModel.fromJson(dynamic json) {
    _id = json['id'];
    _region = json['region'] != null ? Region.fromJson(json['region']) : null;
    _branch =
        json['branch'] != null ? BranchModel.fromJson(json['branch']) : null;
    _origin =
        json['origin'] != null ? OriginModel.fromJson(json['origin']) : null;
    _zipCode = json['zipCode'];
    _name = json['name'];
    _brand = json['brand'];
    _phone = json['phone'];
    _address = json['address'];
    _username = json['username'];
    _email = json['email'];
    _userType = json['userType'];
    _emailRecovery = json['emailRecovery'];
  }

  String? _id;
  Region? _region;
  BranchModel? _branch;
  OriginModel? _origin;
  String? _zipCode;
  String? _name;
  String? _brand;
  String? _phone;
  String? _address;
  String? _username;
  String? _email;
  String? _userType;
  String? _emailRecovery;

  UserModel copyWith({
    String? id,
    Region? region,
    BranchModel? branch,
    OriginModel? origin,
    String? zipCode,
    String? name,
    String? brand,
    String? phone,
    String? address,
    String? username,
    String? email,
    String? userType,
    String? emailRecovery,
  }) =>
      UserModel(
        id: id ?? _id,
        region: region ?? _region,
        branch: branch ?? _branch,
        origin: origin ?? _origin,
        zipCode: zipCode ?? _zipCode,
        name: name ?? _name,
        brand: brand ?? _brand,
        phone: phone ?? _phone,
        address: address ?? _address,
        username: username ?? _username,
        email: email ?? _email,
        userType: userType ?? _userType,
        emailRecovery: emailRecovery ?? _emailRecovery,
      );

  String? get id => _id;

  Region? get region => _region;

  BranchModel? get branch => _branch;

  OriginModel? get origin => _origin;

  String? get zipCode => _zipCode;

  String? get name => _name;

  String? get brand => _brand;

  String? get phone => _phone;

  String? get address => _address;

  String? get username => _username;

  String? get email => _email;

  String? get userType => _userType;

  String? get emailRecovery => _emailRecovery;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_region != null) {
      map['region'] = _region?.toJson();
    }
    if (_branch != null) {
      map['branch'] = _branch?.toJson();
    }
    if (_origin != null) {
      map['origin'] = _origin?.toJson();
    }
    map['zipCode'] = _zipCode;
    map['name'] = _name;
    map['brand'] = _brand;
    map['phone'] = _phone;
    map['address'] = _address;
    map['username'] = _username;
    map['email'] = _email;
    map['userType'] = _userType;
    map['emailRecovery'] = _emailRecovery;
    return map;
  }
}
