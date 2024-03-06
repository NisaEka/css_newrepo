class GetAgentModel {
  GetAgentModel({
    num? code,
    String? message,
    List<AgentModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetAgentModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(AgentModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<AgentModel>? _payload;

  GetAgentModel copyWith({
    num? code,
    String? message,
    List<AgentModel>? payload,
  }) =>
      GetAgentModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<AgentModel>? get payload => _payload;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['message'] = _message;
    if (_payload != null) {
      map['payload'] = _payload?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AgentModel {
  AgentModel({
    bool? status,
    String? branch,
    String? custNo,
    String? custName,
    String? custAddr1,
    String? custAddr2,
    String? custAddr3,
    String? custCity,
    String? custZip,
    String? custCountry,
    String? custPhone,
    String? custTaxName,
  }) {
    _status = status;
    _branch = branch;
    _custNo = custNo;
    _custName = custName;
    _custAddr1 = custAddr1;
    _custAddr2 = custAddr2;
    _custAddr3 = custAddr3;
    _custCity = custCity;
    _custZip = custZip;
    _custCountry = custCountry;
    _custPhone = custPhone;
    _custTaxName = custTaxName;
  }

  AgentModel.fromJson(dynamic json) {
    _status = json['status'];
    _branch = json['branch'];
    _custNo = json['cust_no'];
    _custName = json['cust_name'];
    _custAddr1 = json['cust_addr1'];
    _custAddr2 = json['cust_addr2'];
    _custAddr3 = json['cust_addr3'];
    _custCity = json['cust_city'];
    _custZip = json['cust_zip'];
    _custCountry = json['cust_country'];
    _custPhone = json['cust_phone'];
    _custTaxName = json['cust_tax_name'];
  }

  bool? _status;
  String? _branch;
  String? _custNo;
  String? _custName;
  String? _custAddr1;
  String? _custAddr2;
  String? _custAddr3;
  String? _custCity;
  String? _custZip;
  String? _custCountry;
  String? _custPhone;
  String? _custTaxName;

  AgentModel copyWith({
    bool? status,
    String? branch,
    String? custNo,
    String? custName,
    String? custAddr1,
    String? custAddr2,
    String? custAddr3,
    String? custCity,
    String? custZip,
    String? custCountry,
    String? custPhone,
    String? custTaxName,
  }) =>
      AgentModel(
        status: status ?? _status,
        branch: branch ?? _branch,
        custNo: custNo ?? _custNo,
        custName: custName ?? _custName,
        custAddr1: custAddr1 ?? _custAddr1,
        custAddr2: custAddr2 ?? _custAddr2,
        custAddr3: custAddr3 ?? _custAddr3,
        custCity: custCity ?? _custCity,
        custZip: custZip ?? _custZip,
        custCountry: custCountry ?? _custCountry,
        custPhone: custPhone ?? _custPhone,
        custTaxName: custTaxName ?? _custTaxName,
      );

  bool? get status => _status;

  String? get branch => _branch;

  String? get custNo => _custNo;

  String? get custName => _custName;

  String? get custAddr1 => _custAddr1;

  String? get custAddr2 => _custAddr2;

  String? get custAddr3 => _custAddr3;

  String? get custCity => _custCity;

  String? get custZip => _custZip;

  String? get custCountry => _custCountry;

  String? get custPhone => _custPhone;

  String? get custTaxName => _custTaxName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['branch'] = _branch;
    map['cust_no'] = _custNo;
    map['cust_name'] = _custName;
    map['cust_addr1'] = _custAddr1;
    map['cust_addr2'] = _custAddr2;
    map['cust_addr3'] = _custAddr3;
    map['cust_city'] = _custCity;
    map['cust_zip'] = _custZip;
    map['cust_country'] = _custCountry;
    map['cust_phone'] = _custPhone;
    map['cust_tax_name'] = _custTaxName;
    return map;
  }
}
