import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';

abstract class AggregasiRepository {
  Future<GetAggregationReportModel> getAggregationReport(
    int page,
    int limit,
    String keyword,
    String transDate,
  );
}
