import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/pengaturan/get_petugas_byid_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/data/model/transaction/data_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/get_cod_fee_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_count_model.dart';
import 'package:css_mobile/data/model/transaction/get_transaction_model.dart';
import 'package:css_mobile/data/model/transaction/pantau_count_model.dart';
import 'package:css_mobile/data/model/transaction/post_transaction_ongkir_model.dart';
import 'package:css_mobile/data/model/transaction/transaction_summary_model.dart';

abstract class TransactionRepository {
  Future<BaseResponse<TransactionModel>> postTransaction(TransactionModel data);

  Future<BaseResponse<CODFeeModel>> getCODFee(String accountID);

  Future<BaseResponse<List<TransactionModel>>> getAllTransaction(
    int page,
    int limit,
    String transType,
    List<Map<String, dynamic>> transDate,
    String transStatus,
    String keyword,
    String officer,
  );

  Future<BaseResponse<TransactionModel>> getTransactionByAWB(String awb);

  Future<BaseResponse<TransactionCount>> getTransactionCount(
    String transType,
    List<Map<String, dynamic>> transDate,
    String transStatus,
    String keyword,
    String officer,
  );

  Future<BaseResponse<TransactionModel>> deleteTransaction(String awb);

  Future<BaseResponse<List<String>>> getTransactionStatus();

  Future<BaseResponse<TransactionModel>> putTransaction(
      TransactionModel data, String awb);

  Future<BaseResponse<List<PetugasModel>>> getTransOfficer(QueryModel param);

  Future<BaseResponse<PostTransactionOngkirModel>> postCalcOngkir(
      DataTransactionOngkirModel data);

  Future<ResponseModel<TransactionSummaryModel>> postTransactionDashboard(
      QueryModel param);

  Future<BaseResponse<List<PantauCountModel>>> getPantauCount(QueryModel param);
}
