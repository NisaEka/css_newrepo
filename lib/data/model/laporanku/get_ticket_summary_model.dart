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
