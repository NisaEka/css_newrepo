import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:css_mobile/data/connection_test.dart';
import 'package:css_mobile/data/repository/auth/auth_repository.dart';
import 'package:css_mobile/data/repository/cek_ongkir/cek_ongkir_repository.dart';
import 'package:css_mobile/data/repository/lacak_kiriman/lacak_kiriman_repository.dart';
import 'package:css_mobile/data/repository/profil/profil_repository.dart';
import 'package:css_mobile/data/repository/transaction/transaction_repository.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final auth = Get.find<AuthRepository>();
  final transaction = Get.find<TransactionRepository>();
  final storage = Get.find<StorageCore>();
  final connection = Get.find<ConnectionTest>();
  final profil = Get.find<ProfilRepository>();
  final ongkir = Get.find<CekOngkirRepository>();
  final trace = Get.find<LacakKirimanRepository>();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;
}
