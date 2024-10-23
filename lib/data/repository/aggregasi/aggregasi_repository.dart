import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_detail_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/aggregasi/get_aggregation_total_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';

import 'package:css_mobile/data/model/master/get_accounts_model.dart';

abstract class AggregasiRepository {
  Future<GetAggregationReportModel> getAggregationReport(
    int page,
    int limit,
    String keyword,
    String aggDate,
    List<Account> accounts,
  );

  Future<GetAggregationTotalModel> getAggregationTotal();

  Future<GetAggregationDetailModel> getAggregationByDoc(
    int page,
    int limit,
    String aggregationID,
  );

  Future<DefaultResponseModel<List<AggregationMinusModel>>> getAggregationMinus(
    int page,
    int limit,
    String? keyword,
  );

  Future<DefaultResponseModel<List<AggregationMinusDocModel>>> getAggregationMinusDoc(
    String doc,
    int page,
    int limit,
    String? keyword,
  );
}
