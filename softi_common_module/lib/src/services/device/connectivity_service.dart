import 'package:connectivity/connectivity.dart';
import 'package:softi_common_module/src/interfaces/device/i_connectivity_service.dart';

var _map = {
  ConnectivityResult.mobile: ConnectivityType.mobile,
  ConnectivityResult.none: ConnectivityType.none,
  ConnectivityResult.wifi: ConnectivityType.wifi,
};

class ConnectivityService extends IConnectivityService {
  @override
  Future<ConnectivityType> get conectivity {
    return Connectivity().checkConnectivity().then((result) => _map[result]);
  }

  @override
  Stream<ConnectivityType> get streamConectivity {
    return Connectivity().onConnectivityChanged.map((result) => _map[result]);
  }
}
