//checking internet connection
import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> checkConnection() async {
  bool check;
  var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      check = true;
    } else {
      check = false;
    }
  return check;
}
