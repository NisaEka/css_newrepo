class AggregationChartModel {
  String? date;
  int? total;

  AggregationChartModel({this.date, this.total});

  AggregationChartModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['total'] = total;
    return data;
  }
}
