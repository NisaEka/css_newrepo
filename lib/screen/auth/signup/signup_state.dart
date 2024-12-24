import 'package:css_mobile/data/model/master/get_agent_model.dart';
import 'package:css_mobile/data/model/master/get_origin_model.dart';
import 'package:css_mobile/data/model/master/group_owner_model.dart';
import 'package:flutter/material.dart';

class SignupState {
  final formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final brandName = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final referralCode = TextEditingController();
  final origin = TextEditingController();
  final salesAgent = TextEditingController();

  List<AgentModel> agentList = [];

  String? version;
  String? branchCode;
  bool useJNE = false;
  bool isLoadOrigin = false;
  bool isLoadReferral = false;
  bool isLoadAgent = false;
  bool isLoading = false;
  bool isDefaultOrigin = false;
  bool isSelectCounter = true;
  OriginModel? selectedOrigin;
  AgentModel? selectedAgent;
  GroupOwnerModel? selectedReferral;
  String? locale;
}
