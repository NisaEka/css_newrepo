import 'package:css_mobile/data/model/aggregasi/get_aggregation_report_model.dart';
import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';

abstract class AggregasiRepository {
  Future<GetAggregationReportModel> getAggregationReport(
    int page,
    int limit,
    String keyword,
    String aggDate,
    List<Account> accounts,
  );
}
