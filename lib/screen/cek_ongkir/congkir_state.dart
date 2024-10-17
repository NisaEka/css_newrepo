import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_city_model.dart';
import 'package:css_mobile/data/model/cek_ongkir/post_cekongkir_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:flutter/material.dart';

class CekOngkirState {
  final formKey = GlobalKey<FormState>();
  final searchCity = TextEditingController();
  final kotaPengirim = TextEditingController();
  final kotaTujuan = TextEditingController();
  final beratKiriman = TextEditingController();
  final panjang = TextEditingController();
  final lebar = TextEditingController();
  final tinggi = TextEditingController();
  final estimasiHargaBarang = TextEditingController();

  bool asuransi = false;
  bool dimensi = false;
  bool isCalculate = false;
  double berat = 0;
  double isr = 0;
  bool isLoading = false;

  List<City> cityList = [];
  List<Origin> originList = [];
  List<Origin> destinationList = [];
  List<Ongkir> ongkirList = [];

  GetOriginModel? cityModel;
  Origin? selectedDestination;
  Origin? selectedOrigin;
}
