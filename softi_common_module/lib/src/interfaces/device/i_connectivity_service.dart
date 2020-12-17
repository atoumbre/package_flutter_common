import 'package:softi_core_module/index.dart';

enum ConnectivityType { none, wifi, mobile }

abstract class IConnectivityService extends IBaseService {
  Future<ConnectivityType> getConectivity();
  Stream<ConnectivityType> streamConectivity();
}
