import 'package:css_mobile/data/model/facility/facility_create_model.dart';
import 'package:css_mobile/data/model/master/destination_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FacilityFormInfoState {
  List<String> steps = [
    'Data Pemohon'.tr,
    'Alamat Pengembalian'.tr,
    'Data Rekening'.tr
  ];

  final formKey = GlobalKey<FormState>();
  final brand = TextEditingController();
  final idCardUrl = TextEditingController();
  final fullName = TextEditingController();
  final idCardNumber = TextEditingController();
  final fullAddress = TextEditingController();
  final phone = TextEditingController();
  final whatsAppPhone = TextEditingController();
  final email = TextEditingController();

  final requestData = FacilityCreateModel();
  FacilityCreateModel? tempData;

  String? pickedImageUrl;

  bool isLoading = false;
  bool isLoadDestination = false;

  List<Destination> destinationList = [];
  Destination? selectedDestination;
}
