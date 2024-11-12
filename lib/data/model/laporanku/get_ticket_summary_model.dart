class GetTicketSummaryModel {
  GetTicketSummaryModel({
    num? statusCode,
    String? message,
    TicketSummary? data,
  }) {
    _statusCode = statusCode;
    _message = message;
    _data = data;
  }

  GetTicketSummaryModel.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _message = json['message'];
    _data = json['data'] != null ? TicketSummary.fromJson(json['data']) : null;
  }

  num? _statusCode;
  String? _message;
  TicketSummary? _data;

  GetTicketSummaryModel copyWith({
    num? statusCode,
    String? message,
    TicketSummary? data,
  }) =>
      GetTicketSummaryModel(
        statusCode: statusCode ?? _statusCode,
        message: message ?? _message,
        data: data ?? _data,
      );

  num? get statusCode => _statusCode;

  String? get message => _message;

  TicketSummary? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

class TicketSummary {
  TicketSummary({
    num? all,
    num? onProcess,
    num? finished,
    num? waiting,
  }) {
    _all = all;
    _onProcess = onProcess;
    _finished = finished;
    _waiting = waiting;
  }

  TicketSummary.fromJson(dynamic json) {
    _all = json['all'];
    _onProcess = json['replyMiles'];
    _finished = json['closed'];
    _waiting = json['onProcess'];
  }

  num? _all;
  num? _onProcess;
  num? _finished;
  num? _waiting;

  TicketSummary copyWith({
    num? all,
    num? onProcess,
    num? finished,
    num? waiting,
  }) =>
      TicketSummary(
        all: all ?? _all,
        onProcess: onProcess ?? _onProcess,
        finished: finished ?? _finished,
        waiting: waiting ?? _waiting,
      );

  num? get all => _all;

  num? get onProcess => _onProcess;

  num? get finished => _finished;

  num? get waiting => _waiting;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['all'] = _all;
    map['replyMiles'] = _onProcess;
    map['closed'] = _finished;
    map['onProcess'] = _waiting;
    return map;
  }
}
