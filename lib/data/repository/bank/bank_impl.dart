import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/base_response_model.dart';
import 'package:css_mobile/data/model/query_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/bank/bank_repository.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BankImpl extends BankRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<BaseResponse<List<BankModel>>> getBanks(QueryModel param) async {
    // todo : implement get bank
    try {
      var response = await network.base.get(
        '/master/cms-bank-vas',
        queryParameters: param.toJson(),
      );
      return BaseResponse<List<BankModel>>.fromJson(
        response.data,
        (json) => json is List<dynamic>
            ? json
                .map<BankModel>(
                  (i) => BankModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    } on DioException catch (e) {
      AppLogger.e('error get bank : ${e.response?.data}');
      return BaseResponse<List<BankModel>>.fromJson(
        e.response?.data,
        (json) => json is List<dynamic>
            ? json
                .map<BankModel>(
                  (i) => BankModel.fromJson(i as Map<String, dynamic>),
                )
                .toList()
            : List.empty(),
      );
    }
  }
}
