import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class ConnectionTest {
  static ConnectivityResult connectionStatus = ConnectivityResult.none;
  static bool online = false;
  final Connectivity connectivity = Connectivity();
  static late StreamSubscription<ConnectivityResult> connectivitySubscription;

  Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      online = (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        online = true;
      }
    } on SocketException catch (_) {
      online = false;
    }

    return online;
  }

  Future<void> checkConnection() async {
    connectionStatus = await (Connectivity().checkConnectivity());
    isOnline().then((value) => online = value);
    online.printInfo(info: 'isOnline');

    connectionStatus.printInfo(info: 'connection status');
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    // setState(() {
    connectionStatus = result;
    // });
  }
}
