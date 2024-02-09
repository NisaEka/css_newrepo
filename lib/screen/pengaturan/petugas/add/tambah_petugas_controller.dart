import 'dart:core';
import 'package:css_mobile/base/base_controller.dart';
import 'package:flutter/cupertino.dart';

class TambahPetugasController extends BaseController {
  final formKey = GlobalKey<FormState>();
  final namaPetugas = TextEditingController();
  final alamatEmail = TextEditingController();
  final nomorTelepon = TextEditingController();
  final kataSandi = TextEditingController();
  final kataSandiConfirm = TextEditingController();

  bool profilku = false;
  bool fasilitas = false;
  bool ubahPassword = false;
  bool beranda = false;


}
