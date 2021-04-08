import 'package:softi_common/src/core/BaseService.dart';

abstract class ILocalStore extends IBaseService {
  Future<String?> getKey(String key);
  Future<String?> getSecuredKey(String key);
  Future<void> setKey(String key, dynamic value);
  Future<void> setSecuredKey(String key, dynamic value);
}

class LocalStorageServiceExeption extends ServiceException {
  LocalStorageServiceExeption({
    required String code,
    String? message,
  }) : super(
          service: 'LocalStorage',
          code: code,
          message: message,
        );
}
