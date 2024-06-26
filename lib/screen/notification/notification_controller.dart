import 'package:css_mobile/base/base_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class NotificationController extends BaseController{
  // final message = Get.arguments['message'] as RemoteMessage;
  bool isLoading = false;

  @override
  void onInit() {
    super.onInit();
    Future.wait([initData()]);
  }

  Future<void> initData() async{
    isLoading = true;
    update();
    try{

    }catch(e){
      e.printError();
    }

    isLoading = false;
    update();

  }

}