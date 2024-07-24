import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';

class InputLaporankuController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final noResi = TextEditingController();
  final category = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();
  final image = TextEditingController();

  bool priority = false;
}