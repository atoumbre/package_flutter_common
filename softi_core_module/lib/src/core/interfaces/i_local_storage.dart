import 'package:softi_core_module/src/core/base_service.dart';

abstract class ILocalStore extends IBaseService {
  Future<String> getKey(String key);
  Future<String> getSecuredKey(String key);
  Future<void> setKey(String key, dynamic value);
  Future<void> setSecuredKey(String key, dynamic value);
}
