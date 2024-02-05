import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> connectivity() async {
  final connectivityResult = await Connectivity().checkConnectivity();
  if (connectivityResult == ConnectivityResult.mobile) {
    print('I am connected to a mobile network');
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    print('I am connected to a wifi network');
    return true;
  } else if (connectivityResult == ConnectivityResult.ethernet) {
    print('I am connected to a ethernet network');
    return true;
  } else if (connectivityResult == ConnectivityResult.vpn) {
    print('I am connected to a vpn network');
    return true;
  } else if (connectivityResult == ConnectivityResult.bluetooth) {
    print('I am connected to a bluetooth');
    return true;
  } else if (connectivityResult == ConnectivityResult.other) {
    print(
        'I am connected to a network which is not in the above mentioned networks');
    return true;
  } else {
    print('I am not connected to any network');
    return false;
  }
}
