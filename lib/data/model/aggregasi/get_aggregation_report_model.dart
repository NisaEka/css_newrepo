class GetAggregationReportModel {
  GetAggregationReportModel({
    num? code,
    String? message,
    List<AggregationModel>? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetAggregationReportModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    if (json['payload'] != null) {
      _payload = [];
      json['payload'].forEach((v) {
        _payload?.add(AggregationModel.fromJson(v));
      });
    }
  }

  num? _code;
  String? _message;
  List<AggregationModel>? _payload;

  GetAggregationReportModel copyWith({
    num? code,
    String? message,
    List<AggregationModel>? payload,
  }) =>
      GetAggregationReportModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  List<AggregationModel>? get payload => _payload;

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

class AggregationModel {
  AggregationModel({
    String? aggDocNo,
    String? aggDocDate,
    String? custGroup,
    String? custId,
    String? custName,
    num? codAmt,
    num? codFee,
    num? netAmt,
    num? paidAmt,
    String? paidDate,
    String? paidReffNo,
    String? createDdtm,
    String? createdBy,
    String? remarks,
    String? statusGv,
    String? codType,
    String? cssCreateDate,
    String? transferLog,
    String? aggOrigin,
  }) {
    _aggDocNo = aggDocNo;
    _aggDocDate = aggDocDate;
    _custGroup = custGroup;
    _custId = custId;
    _custName = custName;
    _codAmt = codAmt;
    _codFee = codFee;
    _netAmt = netAmt;
    _paidAmt = paidAmt;
    _paidDate = paidDate;
    _paidReffNo = paidReffNo;
    _createDdtm = createDdtm;
    _createdBy = createdBy;
    _remarks = remarks;
    _statusGv = statusGv;
    _codType = codType;
    _cssCreateDate = cssCreateDate;
    _transferLog = transferLog;
    _aggOrigin = aggOrigin;
  }

  AggregationModel.fromJson(dynamic json) {
    _aggDocNo = json['agg_doc_no'];
    _aggDocDate = json['agg_doc_date'];
    _custGroup = json['cust_group'];
    _custId = json['cust_id'];
    _custName = json['cust_name'];
    _codAmt = json['cod_amt'];
    _codFee = json['cod_fee'];
    _netAmt = json['net_amt'];
    _paidAmt = json['paid_amt'];
    _paidDate = json['paid_date'];
    _paidReffNo = json['paid_reff_no'];
    _createDdtm = json['create_ddtm'];
    _createdBy = json['created_by'];
    _remarks = json['remarks'];
    _statusGv = json['status_gv'];
    _codType = json['cod_type'];
    _cssCreateDate = json['css_create_date'];
    _transferLog = json['transfer_log'];
    _aggOrigin = json['agg_origin'];
  }

  String? _aggDocNo;
  String? _aggDocDate;
  String? _custGroup;
  String? _custId;
  String? _custName;
  num? _codAmt;
  num? _codFee;
  num? _netAmt;
  num? _paidAmt;
  String? _paidDate;
  String? _paidReffNo;
  String? _createDdtm;
  String? _createdBy;
  String? _remarks;
  String? _statusGv;
  String? _codType;
  String? _cssCreateDate;
  String? _transferLog;
  String? _aggOrigin;

  AggregationModel copyWith({
    String? aggDocNo,
    String? aggDocDate,
    String? custGroup,
    String? custId,
    String? custName,
    num? codAmt,
    num? codFee,
    num? netAmt,
    num? paidAmt,
    String? paidDate,
    String? paidReffNo,
    String? createDdtm,
    String? createdBy,
    String? remarks,
    String? statusGv,
    String? codType,
    String? cssCreateDate,
    String? transferLog,
    String? aggOrigin,
  }) =>
      AggregationModel(
        aggDocNo: aggDocNo ?? _aggDocNo,
        aggDocDate: aggDocDate ?? _aggDocDate,
        custGroup: custGroup ?? _custGroup,
        custId: custId ?? _custId,
        custName: custName ?? _custName,
        codAmt: codAmt ?? _codAmt,
        codFee: codFee ?? _codFee,
        netAmt: netAmt ?? _netAmt,
        paidAmt: paidAmt ?? _paidAmt,
        paidDate: paidDate ?? _paidDate,
        paidReffNo: paidReffNo ?? _paidReffNo,
        createDdtm: createDdtm ?? _createDdtm,
        createdBy: createdBy ?? _createdBy,
        remarks: remarks ?? _remarks,
        statusGv: statusGv ?? _statusGv,
        codType: codType ?? _codType,
        cssCreateDate: cssCreateDate ?? _cssCreateDate,
        transferLog: transferLog ?? _transferLog,
        aggOrigin: aggOrigin ?? _aggOrigin,
      );

  String? get aggDocNo => _aggDocNo;

  String? get aggDocDate => _aggDocDate;

  String? get custGroup => _custGroup;

  String? get custId => _custId;

  String? get custName => _custName;

  num? get codAmt => _codAmt;

  num? get codFee => _codFee;

  num? get netAmt => _netAmt;

  num? get paidAmt => _paidAmt;

  String? get paidDate => _paidDate;

  String? get paidReffNo => _paidReffNo;

  String? get createDdtm => _createDdtm;

  String? get createdBy => _createdBy;

  String? get remarks => _remarks;

  String? get statusGv => _statusGv;

  String? get codType => _codType;

  String? get cssCreateDate => _cssCreateDate;

  String? get transferLog => _transferLog;

  String? get aggOrigin => _aggOrigin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['agg_doc_no'] = _aggDocNo;
    map['agg_doc_date'] = _aggDocDate;
    map['cust_group'] = _custGroup;
    map['cust_id'] = _custId;
    map['cust_name'] = _custName;
    map['cod_amt'] = _codAmt;
    map['cod_fee'] = _codFee;
    map['net_amt'] = _netAmt;
    map['paid_amt'] = _paidAmt;
    map['paid_date'] = _paidDate;
    map['paid_reff_no'] = _paidReffNo;
    map['create_ddtm'] = _createDdtm;
    map['created_by'] = _createdBy;
    map['remarks'] = _remarks;
    map['status_gv'] = _statusGv;
    map['cod_type'] = _codType;
    map['css_create_date'] = _cssCreateDate;
    map['transfer_log'] = _transferLog;
    map['agg_origin'] = _aggOrigin;
    return map;
  }
}
