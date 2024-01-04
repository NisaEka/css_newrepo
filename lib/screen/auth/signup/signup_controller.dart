import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SignUpController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final namaLengkap = TextEditingController();
  final namaBrand = TextEditingController();
  final noHp = TextEditingController();
  final email = TextEditingController();
  final kodeReferal = TextEditingController();
  final kotaPengiriman = TextEditingController();
  final agenSales = TextEditingController();

  String? version;
  bool pakaiJNE = false;

  void initData() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    initData();
  }
}