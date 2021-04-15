import 'package:softi_common/src/core/controllers/BaseService.dart';

abstract class IRemoteConfigService extends IBaseService {
  // Map<String, dynamic> get getConfig;
  Future initialise([Map<String, dynamic>? defaultConfig]);
}
