import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_doc_model.dart';
import 'package:get/get.dart';

class AggregationMinusDocController extends BaseController {

  String docArgs = Get.arguments["doc"];

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<AggregationMinusDocModel> aggregations = [];

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async {
    showLoadingIndicator = true;
    update();
    try {
      await aggregation.getAggregationMinusDoc(docArgs)
        .then((response) async {
          if (response.code == 200) {
            aggregations.addAll(response.payload ?? List.empty());
            showMainContent = true;
            update();
          } else {
            showErrorContent = true;
            update();
          }
        });
    } catch (e) {
      showErrorContent = true;
      update();
    }

    showLoadingIndicator = false;
    update();
  }

}