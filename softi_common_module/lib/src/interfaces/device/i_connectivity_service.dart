import 'package:softi_core_module/core.dart';

enum ConnectivityType { none, wifi, mobile }

abstract class IConnectivityService extends IBaseService {
  Future<ConnectivityType> get conectivity;
  Stream<ConnectivityType> get streamConectivity;
}
