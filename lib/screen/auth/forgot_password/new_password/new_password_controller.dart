import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';

class NewPasswordController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final newPW = TextEditingController();
  final confirmPW = TextEditingController();

}