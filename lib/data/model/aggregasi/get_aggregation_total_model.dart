class AggTotal {
  AggTotal({
    num? total,
  }) {
    _total = total;
  }

  AggTotal.fromJson(dynamic json) {
    _total = json['total'] ?? 0;
  }

  num? _total;

  AggTotal copyWith({
    num? total,
  }) =>
      AggTotal(
        total: total ?? _total,
      );

  num? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total'] = _total ?? 0;
    return map;
  }
}
