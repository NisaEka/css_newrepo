import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/material.dart';

class CekOngkirController extends BaseController{
  final formKey = GlobalKey<FormState>();
  final kotaPengirim = TextEditingController();
  final kotaTujuan = TextEditingController();
  final beratKiriman = TextEditingController();
  final panjang = TextEditingController();
  final lebar = TextEditingController();
  final tinggi = TextEditingController();
  final estimasiHargaBarang = TextEditingController();

  bool asuransi = false;
  bool dimensi = false;


}