import 'package:css_mobile/data/model/transaction/get_account_number_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_destination_model.dart';
import 'package:css_mobile/data/model/transaction/get_dropshipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_origin_model.dart';
import 'package:css_mobile/data/model/transaction/get_receiver_model.dart';
import 'package:css_mobile/data/model/transaction/get_service_model.dart';
import 'package:css_mobile/data/model/transaction/get_shipper_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_fee_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/data_service_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_fee_model.dart';

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

  Future<GetServiceModel> getService(DataServiceModel param);

  Future<GetTransactionFeeModel> getTransactionFee(DataTransactionFeeModel params);

  Future<PostTransactionModel> postTransaction(DataTransactionModel data);

  Future<GetCodFeeModel> getCODFee(String accountID);

  Future<PostTransactionModel> postDropshipper(DropshipperModel data);

  Future<PostTransactionModel> postReceiver(ReceiverModel data);
}
