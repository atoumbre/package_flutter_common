import 'package:softi_common/src/core/BaseService.dart';

enum ConnectivityType { none, wifi, mobile }

abstract class IConnectivityService extends IBaseService {
  Future<ConnectivityType> get conectivity;
  Stream<ConnectivityType> get streamConectivity;
}
