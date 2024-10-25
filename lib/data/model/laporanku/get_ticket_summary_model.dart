class GetTicketSummaryModel {
  GetTicketSummaryModel({
    num? code,
    String? message,
    TicketSummary? payload,
  }) {
    _code = code;
    _message = message;
    _payload = payload;
  }

  GetTicketSummaryModel.fromJson(dynamic json) {
    _code = json['code'];
    _message = json['message'];
    _payload = json['payload'] != null
        ? TicketSummary.fromJson(json['payload'])
        : null;
  }

  num? _code;
  String? _message;
  TicketSummary? _payload;

  GetTicketSummaryModel copyWith({
    num? code,
    String? message,
    TicketSummary? payload,
  }) =>
      GetTicketSummaryModel(
        code: code ?? _code,
        message: message ?? _message,
        payload: payload ?? _payload,
      );

  num? get code => _code;

  String? get message => _message;

  TicketSummary? get payload => _payload;

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
    _onProcess = json['on_process'];
    _finished = json['finished'];
    _waiting = json['waiting'];
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
    map['on_process'] = _onProcess;
    map['finished'] = _finished;
    map['waiting'] = _waiting;
    return map;
  }
}
