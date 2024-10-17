import 'dart:convert';

import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
GetOriginModel getOriginModelFromJson(String str) => GetOriginModel.fromJson(json.decode(str));

String getOriginModelToJson(GetOriginModel data) => json.encode(data.toJson());

class GetOriginModel {
  GetOriginModel({
    num? code,
    String? message,
    String? regId,
    List<Origin>? payload,
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
        _payload?.add(Origin.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  String? _regId;
  List<Origin>? _payload;

  GetOriginModel copyWith({
    num? code,
    String? message,
    String? regId,
    List<Origin>? payload,
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

  List<Origin>? get payload => _payload;

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

class Origin {
  Origin({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
    Region? region,
  }) {
    _originCode = originCode;
    _originName = originName;
    _branchCode = branchCode;
    _originStatus = originStatus;
    _region = region;
  }

  Origin.fromJson(dynamic json) {
    _originCode = json['origin_code'] ?? json['code'] ?? json['originCode'];
    _originName = json['origin_name'] ?? json['desc'] ?? json['label'] ?? json['originName'];
    _branchCode = json['branch_code'] ?? json['branch'] ?? json['branchCode'];
    _originStatus = json['originStatus'];
    if (json["region"] != null) {
      _region = Region.fromJson(json["region"]);
    }
  }

  String? _originCode;
  String? _originName;
  String? _branchCode;
  String? _originStatus;
  Region? _region;

  Origin copyWith({
    String? originCode,
    String? originName,
    String? branchCode,
    String? originStatus,
  }) =>
      Origin(
        originCode: originCode ?? _originCode,
        originName: originName ?? _originName,
        branchCode: branchCode ?? _branchCode,
        originStatus: originStatus ?? _originStatus
      );

  String? get originCode => _originCode;

  String? get originName => _originName;

  String? get branchCode => _branchCode;

  String? get originStatus => _originStatus;

  Region? get region => _region;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['origin_code'] = _originCode;
    map['origin_name'] = _originName;
    map['branch_code'] = _branchCode;
    map['code'] = _originCode;
    map['desc'] = _originName;
    map['label'] = _originName;
    map['branch'] = _branchCode;
    map['originStatus'] = _originStatus;
    map['originCode'] = _originCode;
    map['originName'] = _originName;
    map['branchCode'] = _branchCode;
    return map;
  }
}
