import 'package:css_mobile/data/model/aggregasi/aggregation_chart_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_total_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';

import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';

abstract class AggregasiRepository {
  Future<BaseResponse<List<AggregationModel>>> getAggregationReport(
      QueryModel param);

  Future<GetAggregationTotalModel> getAggregationTotal(QueryModel param);

  Future<BaseResponse<List<AggregationDetailModel>>> getAggregationByDoc(
      String aggregationID, QueryModel param);

  Future<BaseResponse<List<AggregationMinusModel>>> getAggregationMinus(
      QueryModel param);

  Future<BaseResponse<List<AggregationMinusDocModel>>> getAggregationMinusDoc(
      String doc, QueryModel param);

  Future<ResponseModel<TransactionSummaryModel>> getAggSummary();

  Future<ResponseModel<List<AggregationChartModel>>> getAggChart();
}
