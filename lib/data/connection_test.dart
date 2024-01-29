import 'dart:io';

class ConnectionTest {
  Future<bool> isOnline() async {
    bool online = false;
    try {
      final result = await InternetAddress.lookup('google.com');
      online = (result.isNotEmpty && result[0].rawAddress.isNotEmpty);
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('online');
      }
      // update();
    } on SocketException catch (_) {
      print('offline');
    }

    return online;
  }
}
