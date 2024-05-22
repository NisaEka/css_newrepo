import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/aggregasi/aggregation_minus_detail_model.dart';
import 'package:get/get.dart';

class AggregationMinusDocController extends BaseController {

  String docArgs = Get.arguments["doc"];

  bool showLoadingIndicator = false;
  bool showProhibitedContent = false;
  bool showMainContent = false;
  bool showErrorContent = false;

  List<AggregationMinusDetailModel> aggregations = [];

}