import 'package:css_mobile/data/model/delivery/get_account_number_model.dart';

abstract class DeliveryRepository {
  Future<GetAccountNumberModel> getAccountNumber();
}
