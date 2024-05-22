import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';

abstract class AggregasiRepository {
  Future<GetAggregationReportModel> getAggregationReport(
    int page,
    int limit,
    String keyword,
    String transDate,
  );
  Future<DefaultResponseModel<List<AggregationMinusModel>>> getAggregationMinus();
  Future<DefaultResponseModel<List<AggregationMinusDocModel>>> getAggregationMinusDoc(String doc);
}
