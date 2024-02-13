import 'dart:io';

class SplashRepository {
  Future<bool> checkConnetion() async {
    try {
      final result = await InternetAddress.lookup("example.com");
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  Future<bool> isConnect() async {
    final isConnect = await SplashRepository().checkConnetion();
    if (isConnect) {
      return isConnect;
    } else {
      return isConnect;
    }
  }
}
