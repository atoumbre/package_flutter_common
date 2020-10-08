import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:softi_core_module/softi_core_module.dart';

class DefaultLocalStore extends ILocalStore {
  GetStorage _storage;
  FlutterSecureStorage _secureStorage;

  init() async {
    GetStorage.init();
    _storage = GetStorage();
    _secureStorage = new FlutterSecureStorage();
  }

  @override
  Future<String> getKey(String key) async {
    return _storage.read(key);
  }

  @override
  Future<String> getSecuredKey(String key) async {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> setKey(String key, value) async {
    return _storage.write(key, value);
  }

  @override
  Future<void> setSecuredKey(String key, value) async {
    return _secureStorage.write(key: key, value: value);
  }
}
