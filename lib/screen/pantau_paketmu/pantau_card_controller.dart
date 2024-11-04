import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/query_param_model.dart';
import 'package:css_mobile/data/model/response_model.dart';
import 'package:css_mobile/screen/pantau_paketmu/pantau_pakemu_state.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:get/get.dart';

class PantauCardController extends BaseController {
  final state = PantauPaketmuState();

  @override
  void onInit() {
    super.onInit();
    Future.wait([loadPantauCountList()]);
  }

  Future<void> loadPantauCountList() async {
    state.pantauCountList.clear();
    state.isLoading = true;
    update();
    AppLogger.i('pantau screen');
    try {
      // ResponseModel result = await pantau.getPantauCountStatus('1717174800000 - 1719766800000', '');
      ResponseModel result =
          await transaction.postTransactionDashboard(QueryParamModel());
      state.pantauCountList.addAll(result.data);
      AppLogger.d('pantau screen : ${result.statusCode}');
    } catch (e, i) {
      e.printError();
      i.printError();
    }
    state.isLoading = false;
    update();
  }
}
