import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';

abstract class BankRepository {
  Future<DefaultResponseModel<List<BankModel>>> getBanks();
}