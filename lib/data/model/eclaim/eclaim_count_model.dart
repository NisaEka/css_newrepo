class EclaimCountModel {
  EclaimCountModel({
    num? totalCount,
    num? totalAmount,
    num? acceptedCount,
    num? acceptedAmount,
    num? rejectedCount,
    num? rejectedAmount,
  }) {
    _totalCount = totalCount;
    _totalAmount = totalAmount;
    _acceptedCount = acceptedCount;
    _acceptedAmount = acceptedAmount;
    _rejectedCount = rejectedCount;
    _rejectedAmount = rejectedAmount;
  }

  EclaimCountModel.fromJson(dynamic json) {
    _totalCount = json['totalCount'];
    _totalAmount = json['totalAmount'];
    _acceptedCount = json['acceptedCount'];
    _acceptedAmount = json['acceptedAmount'];
    _rejectedCount = json['rejectedCount'];
    _rejectedAmount = json['rejectedAmount'];
  }

  num? _totalCount;
  num? _totalAmount;
  num? _acceptedCount;
  num? _acceptedAmount;
  num? _rejectedCount;
  num? _rejectedAmount;

  EclaimCountModel copyWith({
    num? totalCount,
    num? totalAmount,
    num? acceptedCount,
    num? acceptedAmount,
    num? rejectedCount,
    num? rejectedAmount,
  }) =>
      EclaimCountModel(
        totalCount: totalCount ?? _totalCount,
        totalAmount: totalAmount ?? _totalAmount,
        acceptedCount: acceptedCount ?? _acceptedCount,
        acceptedAmount: acceptedAmount ?? _acceptedAmount,
        rejectedCount: rejectedCount ?? _rejectedCount,
        rejectedAmount: rejectedAmount ?? _rejectedAmount,
      );

  num? get totalCount => _totalCount;

  num? get totalAmount => _totalAmount;

  num? get acceptedCount => _acceptedCount;

  num? get acceptedAmount => _acceptedAmount;

  num? get rejectedCount => _rejectedCount;

  num? get rejectedAmount => _rejectedAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = _totalCount;
    map['totalAmount'] = _totalAmount;
    map['acceptedCount'] = _acceptedCount;
    map['acceptedAmount'] = _acceptedAmount;
    map['rejectedCount'] = _rejectedCount;
    map['rejectedAmount'] = _rejectedAmount;
    return map;
  }
}
