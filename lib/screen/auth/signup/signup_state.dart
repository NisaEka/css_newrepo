import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:flutter/material.dart';

class SignupState {
  final formKey = GlobalKey<FormState>();
  final namaLengkap = TextEditingController();
  final namaBrand = TextEditingController();
  final noHp = TextEditingController();
  final email = TextEditingController();
  final kodeReferal = TextEditingController();
  final kotaPengirim = TextEditingController();
  final agenSales = TextEditingController();

  List<AgentModel> agenList = [];

  String? version;
  String? branchCode;
  bool pakaiJNE = false;
  bool isLoadOrigin = false;
  bool isLoadReferal = false;
  bool isLoadAgent = false;
  bool isLoading = false;
  bool isDefaultOrigin = false;
  bool isSelectCounter = true;
  Origin? selectedOrigin;
  AgentModel? selectedAgent;
  GroupOwnerModel? selectedReferal;
  String? locale;
}