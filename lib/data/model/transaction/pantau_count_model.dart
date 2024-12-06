class PantauCountModel {
  final String status;
  final int totalCod;
  final num codAmount;
  final num ongkirCodAmount;
  final int totalCodOngkir;
  final num codOngkirAmount;
  final int totalNonCod;
  final num ongkirNonCodAmount;
  final List<ChartData> chart;
  final num totalCodPercentage;
  final num codAmountPercentage;
  final num ongkirCodAmountPercentage;
  final num totalCodOngkirPercentage;
  final num codOngkirAmountPercentage;
  final num totalNonCodPercentage;
  final num ongkirNonCodAmountPercentage;

  PantauCountModel({
    required this.status,
    required this.totalCod,
    required this.codAmount,
    required this.ongkirCodAmount,
    required this.totalCodOngkir,
    required this.codOngkirAmount,
    required this.totalNonCod,
    required this.ongkirNonCodAmount,
    required this.chart,
    required this.totalCodPercentage,
    required this.codAmountPercentage,
    required this.ongkirCodAmountPercentage,
    required this.totalCodOngkirPercentage,
    required this.codOngkirAmountPercentage,
    required this.totalNonCodPercentage,
    required this.ongkirNonCodAmountPercentage,
  });

  factory PantauCountModel.fromJson(Map<String, dynamic> json) {
    return PantauCountModel(
      status: json['status'],
      totalCod: json['totalCod'],
      codAmount: json['codAmount'],
      ongkirCodAmount: json['ongkirCodAmount'],
      totalCodOngkir: json['totalCodOngkir'],
      codOngkirAmount: json['codOngkirAmount'],
      totalNonCod: json['totalNonCod'],
      ongkirNonCodAmount: json['ongkirNonCodAmount'],
      chart: (json['chart'] as List<dynamic>)
          .map((e) => ChartData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCodPercentage: json['totalCodPercentage'],
      codAmountPercentage: json['codAmountPercentage'],
      ongkirCodAmountPercentage: json['ongkirCodAmountPercentage'],
      totalCodOngkirPercentage: json['totalCodOngkirPercentage'],
      codOngkirAmountPercentage: json['codOngkirAmountPercentage'],
      totalNonCodPercentage: json['totalNonCodPercentage'],
      ongkirNonCodAmountPercentage: json['ongkirNonCodAmountPercentage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'totalCod': totalCod,
      'codAmount': codAmount,
      'ongkirCodAmount': ongkirCodAmount,
      'totalCodOngkir': totalCodOngkir,
      'codOngkirAmount': codOngkirAmount,
      'totalNonCod': totalNonCod,
      'ongkirNonCodAmount': ongkirNonCodAmount,
      'chart': chart.map((e) => e.toJson()).toList(),
      'totalCodPercentage': totalCodPercentage,
      'codAmountPercentage': codAmountPercentage,
      'ongkirCodAmountPercentage': ongkirCodAmountPercentage,
      'totalCodOngkirPercentage': totalCodOngkirPercentage,
      'codOngkirAmountPercentage': codOngkirAmountPercentage,
      'totalNonCodPercentage': totalNonCodPercentage,
      'ongkirNonCodAmountPercentage': ongkirNonCodAmountPercentage,
    };
  }
}

class ChartData {
  final String x;
  final num y;

  ChartData({
    required this.x,
    required this.y,
  });

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      x: json['x'],
      y: json['y'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'x': x,
      'y': y,
    };
  }
}
