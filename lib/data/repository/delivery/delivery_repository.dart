import 'package:css_mobile/data/model/delivery/get_account_number_model.dart';
import 'package:css_mobile/data/model/delivery/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/delivery/get_origin_model.dart';
import 'package:css_mobile/data/model/delivery/get_sender_model.dart';

abstract class DeliveryRepository {
  Future<GetAccountNumberModel> getAccountNumber();

  Future<GetDropshipperModel> getDropshipper();

  Future<GetSenderModel> getSender();

  Future<GetOriginModel> getOrigin(String? keyword, String accountID);

  
}
