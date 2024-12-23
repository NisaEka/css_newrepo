import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/query_model.dart';

abstract class BankRepository {
  Future<BaseResponse<List<BankModel>>> getBanks(QueryModel param);
}
