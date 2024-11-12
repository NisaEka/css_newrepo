class GetAggregationReportModel {
  GetAggregationReportModel({
    num? statusCode,
    String? message,
    List<AggregationModel>? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GetAggregationReportModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(AggregationModel.fromJson(v));
      });
    }
  }

  num? _statusCode;
  String? _message;
  List<AggregationModel>? _data;

  GetAggregationReportModel copyWith({
    num? statusCode,
    String? message,
    List<AggregationModel>? data,
  }) =>
      GetAggregationReportModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  List<AggregationModel>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class AggregationModel {
  AggregationModel({
    String? mpayWdrGrpPayNo,
    String? mpayWdrGrpPayDate,
    String? mpayWdrGrpPayGroup,
    String? mpayWdrGrpPayCode,
    String? mpayWdrGrpPayName,
    num? mpayWdrGrpPayCodAmt,
    num? mpayWdrGrpPayCodFee,
    num? mpayWdrGrpPayNetAmt,
    num? mpayWdrGrpPayPaidAmt,
    String? mpayWdrGrpPayDatePaid,
    String? mpayWdrGrpPayReffPaid,
    String? createddtm,
    String? createdby,
    String? remarks,
    String? statusGv,
    String? mpayWdrGrpCodType,
    String? oggcreateddtm,
    String? transferLog,
    String? mpayWdrGrpPayOrgMain,
  }) {
    _mpayWdrGrpPayNo = mpayWdrGrpPayNo;
    _mpayWdrGrpPayDate = mpayWdrGrpPayDate;
    _mpayWdrGrpPayGroup = mpayWdrGrpPayGroup;
    _mpayWdrGrpPayCode = mpayWdrGrpPayCode;
    _mpayWdrGrpPayName = mpayWdrGrpPayName;
    _mpayWdrGrpPayCodAmt = mpayWdrGrpPayCodAmt;
    _mpayWdrGrpPayCodFee = mpayWdrGrpPayCodFee;
    _mpayWdrGrpPayNetAmt = mpayWdrGrpPayNetAmt;
    _mpayWdrGrpPayPaidAmt = mpayWdrGrpPayPaidAmt;
    _mpayWdrGrpPayDatePaid = mpayWdrGrpPayDatePaid;
    _mpayWdrGrpPayReffPaid = mpayWdrGrpPayReffPaid;
    _createddtm = createddtm;
    _createdby = createdby;
    _remarks = remarks;
    _statusGv = statusGv;
    _mpayWdrGrpCodType = mpayWdrGrpCodType;
    _oggcreateddtm = oggcreateddtm;
    _transferLog = transferLog;
    _mpayWdrGrpPayOrgMain = mpayWdrGrpPayOrgMain;
  }

  AggregationModel.fromJson(dynamic json) {
    _mpayWdrGrpPayNo = json['mpayWdrGrpPayNo'];
    _mpayWdrGrpPayDate = json['mpayWdrGrpPayDate'];
    _mpayWdrGrpPayGroup = json['mpayWdrGrpPayGroup'];
    _mpayWdrGrpPayCode = json['mpayWdrGrpPayCode'];
    _mpayWdrGrpPayName = json['mpayWdrGrpPayName'];
    _mpayWdrGrpPayCodAmt = json['mpayWdrGrpPayCodAmt'];
    _mpayWdrGrpPayCodFee = json['mpayWdrGrpPayCodFee'];
    _mpayWdrGrpPayNetAmt = json['mpayWdrGrpPayNetAmt'];
    _mpayWdrGrpPayPaidAmt = json['mpayWdrGrpPayPaidAmt'];
    _mpayWdrGrpPayDatePaid = json['mpayWdrGrpPayDatePaid'];
    _mpayWdrGrpPayReffPaid = json['mpayWdrGrpPayReffPaid'];
    _createddtm = json['createddtm'];
    _createdby = json['createdby'];
    _remarks = json['remarks'];
    _statusGv = json['statusGv'];
    _mpayWdrGrpCodType = json['mpayWdrGrpCodType'];
    _oggcreateddtm = json['oggcreateddtm'];
    _transferLog = json['transferLog'];
    _mpayWdrGrpPayOrgMain = json['mpayWdrGrpPayOrgMain'];
  }

  String? _mpayWdrGrpPayNo;
  String? _mpayWdrGrpPayDate;
  String? _mpayWdrGrpPayGroup;
  String? _mpayWdrGrpPayCode;
  String? _mpayWdrGrpPayName;
  num? _mpayWdrGrpPayCodAmt;
  num? _mpayWdrGrpPayCodFee;
  num? _mpayWdrGrpPayNetAmt;
  num? _mpayWdrGrpPayPaidAmt;
  String? _mpayWdrGrpPayDatePaid;
  String? _mpayWdrGrpPayReffPaid;
  String? _createddtm;
  String? _createdby;
  String? _remarks;
  String? _statusGv;
  String? _mpayWdrGrpCodType;
  String? _oggcreateddtm;
  String? _transferLog;
  String? _mpayWdrGrpPayOrgMain;

  AggregationModel copyWith({
    String? mpayWdrGrpPayNo,
    String? mpayWdrGrpPayDate,
    String? mpayWdrGrpPayGroup,
    String? mpayWdrGrpPayCode,
    String? mpayWdrGrpPayName,
    num? mpayWdrGrpPayCodAmt,
    num? mpayWdrGrpPayCodFee,
    num? mpayWdrGrpPayNetAmt,
    num? mpayWdrGrpPayPaidAmt,
    String? mpayWdrGrpPayDatePaid,
    String? mpayWdrGrpPayReffPaid,
    String? createddtm,
    String? createdby,
    String? remarks,
    String? statusGv,
    String? mpayWdrGrpCodType,
    String? oggcreateddtm,
    String? transferLog,
    String? mpayWdrGrpPayOrgMain,
  }) =>
      AggregationModel(
        mpayWdrGrpPayNo: mpayWdrGrpPayNo ?? _mpayWdrGrpPayNo,
        mpayWdrGrpPayDate: mpayWdrGrpPayDate ?? _mpayWdrGrpPayDate,
        mpayWdrGrpPayGroup: mpayWdrGrpPayGroup ?? _mpayWdrGrpPayGroup,
        mpayWdrGrpPayCode: mpayWdrGrpPayCode ?? _mpayWdrGrpPayCode,
        mpayWdrGrpPayName: mpayWdrGrpPayName ?? _mpayWdrGrpPayName,
        mpayWdrGrpPayCodAmt: mpayWdrGrpPayCodAmt ?? _mpayWdrGrpPayCodAmt,
        mpayWdrGrpPayCodFee: mpayWdrGrpPayCodFee ?? _mpayWdrGrpPayCodFee,
        mpayWdrGrpPayNetAmt: mpayWdrGrpPayNetAmt ?? _mpayWdrGrpPayNetAmt,
        mpayWdrGrpPayPaidAmt: mpayWdrGrpPayPaidAmt ?? _mpayWdrGrpPayPaidAmt,
        mpayWdrGrpPayDatePaid: mpayWdrGrpPayDatePaid ?? _mpayWdrGrpPayDatePaid,
        mpayWdrGrpPayReffPaid: mpayWdrGrpPayReffPaid ?? _mpayWdrGrpPayReffPaid,
        createddtm: createddtm ?? _createddtm,
        createdby: createdby ?? _createdby,
        remarks: remarks ?? _remarks,
        statusGv: statusGv ?? _statusGv,
        mpayWdrGrpCodType: mpayWdrGrpCodType ?? _mpayWdrGrpCodType,
        oggcreateddtm: oggcreateddtm ?? _oggcreateddtm,
        transferLog: transferLog ?? _transferLog,
        mpayWdrGrpPayOrgMain: mpayWdrGrpPayOrgMain ?? _mpayWdrGrpPayOrgMain,
      );

  String? get mpayWdrGrpPayNo => _mpayWdrGrpPayNo;

  String? get mpayWdrGrpPayDate => _mpayWdrGrpPayDate;

  String? get mpayWdrGrpPayGroup => _mpayWdrGrpPayGroup;

  String? get mpayWdrGrpPayCode => _mpayWdrGrpPayCode;

  String? get mpayWdrGrpPayName => _mpayWdrGrpPayName;

  num? get mpayWdrGrpPayCodAmt => _mpayWdrGrpPayCodAmt;

  num? get mpayWdrGrpPayCodFee => _mpayWdrGrpPayCodFee;

  num? get mpayWdrGrpPayNetAmt => _mpayWdrGrpPayNetAmt;

  num? get mpayWdrGrpPayPaidAmt => _mpayWdrGrpPayPaidAmt;

  String? get mpayWdrGrpPayDatePaid => _mpayWdrGrpPayDatePaid;

  String? get mpayWdrGrpPayReffPaid => _mpayWdrGrpPayReffPaid;

  String? get createddtm => _createddtm;

  String? get createdby => _createdby;

  String? get remarks => _remarks;

  String? get statusGv => _statusGv;

  String? get mpayWdrGrpCodType => _mpayWdrGrpCodType;

  String? get oggcreateddtm => _oggcreateddtm;

  String? get transferLog => _transferLog;

  String? get mpayWdrGrpPayOrgMain => _mpayWdrGrpPayOrgMain;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['mpayWdrGrpPayNo'] = _mpayWdrGrpPayNo;
    map['mpayWdrGrpPayDate'] = _mpayWdrGrpPayDate;
    map['mpayWdrGrpPayGroup'] = _mpayWdrGrpPayGroup;
    map['mpayWdrGrpPayCode'] = _mpayWdrGrpPayCode;
    map['mpayWdrGrpPayName'] = _mpayWdrGrpPayName;
    map['mpayWdrGrpPayCodAmt'] = _mpayWdrGrpPayCodAmt;
    map['mpayWdrGrpPayCodFee'] = _mpayWdrGrpPayCodFee;
    map['mpayWdrGrpPayNetAmt'] = _mpayWdrGrpPayNetAmt;
    map['mpayWdrGrpPayPaidAmt'] = _mpayWdrGrpPayPaidAmt;
    map['mpayWdrGrpPayDatePaid'] = _mpayWdrGrpPayDatePaid;
    map['mpayWdrGrpPayReffPaid'] = _mpayWdrGrpPayReffPaid;
    map['createddtm'] = _createddtm;
    map['createdby'] = _createdby;
    map['remarks'] = _remarks;
    map['status_gv'] = _statusGv;
    map['mpayWdrGrpCodType'] = _mpayWdrGrpCodType;
    map['oggcreateddtm'] = _oggcreateddtm;
    map['transferLog'] = _transferLog;
    map['mpayWdrGrpPayOrgMain'] = _mpayWdrGrpPayOrgMain;
    return map;
  }
}
