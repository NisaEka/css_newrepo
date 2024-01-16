import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';

class InformasiPenerimaController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final namaPenerima = TextEditingController();
  final nomorTelpon = TextEditingController();
  final kotaTujuan = TextEditingController();
  final alamatLengkap = TextEditingController();

  List<String> steps = ['Data Pengirim', 'Data Penerima', 'Data Kiriman'];

}