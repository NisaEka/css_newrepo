import 'dart:io';

import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/data/model/request_pickup/request_pickup_detail_model.dart';
import 'package:get/get.dart';

class RequestPickupDetailController extends BaseController {
  String awb = Get.arguments["awb"];

  bool _showLoadingIndicator = false;
  bool get showLoadingIndicator => _showLoadingIndicator;

  bool _showContent = false;
  bool get showContent => _showContent;

  bool _showEmptyContainer = false;
  bool get showEmptyContainer => _showEmptyContainer;

  bool _showErrorContainer = false;
  bool get showErrorContainer => _showErrorContainer;

  late RequestPickupDetailModel _requestPickup;
  RequestPickupDetailModel get requestPickup => _requestPickup;

  @override
  void onInit() {
    super.onInit();
    Future.wait([_getRequestPickupByAwb()]);
  }

  Future<void> _getRequestPickupByAwb() async {
    _showLoadingIndicator = true;
    update();

    requestPickupRepository.getRequestPickupByAwb(awb).then(
      (result) {
        if (result.code == HttpStatus.ok && result.payload != null) {
          _requestPickup = result.payload!;
          _showContent = true;
        } else if (result.code == HttpStatus.notFound) {
          _showEmptyContainer = true;
        }

        update();
      },
    ).onError(
      (error, stackTrace) {
        _showErrorContainer = true;
        update();
      },
    );

    _showLoadingIndicator = false;
    update();
  }
}
