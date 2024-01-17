import 'dart:convert';

GetOriginModel getOriginModelFromJson(String str) => GetOriginModel.fromJson(json.decode(str));

String getOriginModelToJson(GetOriginModel data) => json.encode(data.toJson());

class GetOriginModel {
  GetOriginModel({
    num? code,
    String? message,
    String? regId,
    List<OriginModel>? payload,
  }) {
    _code = code;
    _message = message;
    _regId = regId;
    _payload = payload;
  }

  GetOriginModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _regId = json['reg_id'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(OriginModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  String? _regId;
  List<OriginModel>? _payload;

  GetOriginModel copyWith({
    num? code,
    String? message,
    String? regId,
    List<OriginModel>? payload,
  }) =>
      GetOriginModel(
        code: code ?? _code,
        message: message ?? _message,
        regId: regId ?? _regId,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  String? get regId => _regId;

  List<OriginModel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    map['reg_id'] = _regId;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

OriginModel payloadFromJson(String str) => OriginModel.fromJson(json.decode(str));

String payloadToJson(OriginModel data) => json.encode(data.toJson());

class OriginModel {
  OriginModel({
    String? originCode,
    String? originName,
    String? branchCode,
  }) {
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
  }

  OriginModel.fromJson(dynamic json) {
    _originCode = json['origin_code'];
    _originName = json['origin_name'];
    _branchCode = json['branch_code'];
  }

  String? _originCode;
  String? _originName;
  String? _branchCode;

  OriginModel copyWith({
    String? originCode,
    String? originName,
    String? branchCode,
  }) =>
      OriginModel(
        originCode: originCode ?? _originCode,
        originName: originName ?? _originName,
        branchCode: branchCode ?? _branchCode,
      );

  String? get originCode => _originCode;

  String? get originName => _originName;

  String? get branchCode => _branchCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_code'] = _originCode;
    map['origin_name'] = _originName;
    map['branch_code'] = _branchCode;
    return map;
  }
}
