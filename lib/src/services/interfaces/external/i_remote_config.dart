import 'package:softi_common/src/core/base_service.dart';

abstract class IRemoteConfigService extends IBaseService {
  // Map<String, dynamic> get getConfig;
  Future initialise([Map<String, dynamic> defaultConfig]);
}
