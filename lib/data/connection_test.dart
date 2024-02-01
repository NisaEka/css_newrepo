import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
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
      // update();
    } on SocketException catch (_) {
      // print('phone is offline');
      online = false;
    }

    return online;
  }

  Future<void> checkConnection() async {
    // try {
      connectionStatus = await (Connectivity().checkConnectivity());
      // if (connectionStatus != ConnectivityResult.none) {
        isOnline().then((value) => online = value);
        online.printInfo(info: 'isOnline');
      // }
    // } on PlatformException catch (e) {
    //   print('Couldn\'t check connectivity status\n $e');
    //   return;
    // }

    connectionStatus.printInfo(info: 'connection status');
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    // setState(() {
    connectionStatus = result;
    // });
  }
}
