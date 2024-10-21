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
    _custNo = json['custNo'];
    _custName = json['custName'];
    _custAddr1 = json['custAddr1'];
    _custAddr2 = json['custAddr2'];
    _custAddr3 = json['custAddr3'];
    _custCity = json['custCity'];
    _custZip = json['custZip'];
    _custCountry = json['custCountry'];
    _custPhone = json['custPhone'];
    _custTaxName = json['custTaxName'];
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
    map['custNo'] = _custNo;
    map['custName'] = _custName;
    map['custAddr1'] = _custAddr1;
    map['custAddr2'] = _custAddr2;
    map['custAddr3'] = _custAddr3;
    map['custCity'] = _custCity;
    map['custZip'] = _custZip;
    map['custCountry'] = _custCountry;
    map['custPhone'] = _custPhone;
    map['custTaxName'] = _custTaxName;
    return map;
  }
}
