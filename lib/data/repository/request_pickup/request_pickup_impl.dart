import 'package:css_mobile/data/model/default_response_model.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_model.dart';
import 'package:css_mobile/data/repository/request_pickup/request_pickup_repository.dart';

class RequestPickupImpl extends RequestPickupRepository {
  
  @override
  Future<DefaultResponseModel<List<RequestPickupModel>>> getRequestPickups() async {
    List<RequestPickupModel> pickupModels = RequestPickupModel().getExamples();

    return DefaultResponseModel(
      code: 200,
      message: "OK",
      payload: pickupModels
    );
  }

}