import 'package:css_mobile/data/model/bank/bank_model.dart';
import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/network_core.dart';
import 'package:css_mobile/data/repository/bank/bank_repository.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class BankImpl extends BankRepository {
  final network = Get.find<NetworkCore>();

  @override
  Future<DefaultResponseModel<List<BankModel>>> getBanks() async {
    try {
      var response = await network.dio.get('/bank');
      List<BankModel> banks = [];
      response.data['payload'].forEach((bank) {
        banks.add(BankModel.fromJson(bank));
      });
      return DefaultResponseModel.fromJson(response.data, banks);
    } on DioException catch (e) {
      return DefaultResponseModel.fromJson(e.response?.data, List.empty());
    }
  }
}
