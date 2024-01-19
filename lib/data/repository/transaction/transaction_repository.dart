import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/service_data_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_fee_data_model.dart';

abstract class TransactionRepository {
  Future<GetAccountNumberModel> getAccountNumber();

  Future<GetDropshipperModel> getDropshipper();

  Future<GetShipperModel> getSender();

  Future<GetOriginModel> getOrigin(
    String? keyword,
    String accountID,
  );

  Future<GetDestinationModel> getDestination(String? keyword);

  Future<GetReceiverModel> getReceiver();

  Future<GetServiceModel> getService(ServiceDataModel param);

  Future<GetTransactionFeeModel> getTransactionFee(TransactionFeeDataModel params);
}
