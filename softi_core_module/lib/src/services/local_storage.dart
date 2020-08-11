import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:softi_core_module/softi_core_module.dart';

class DefaultLocalStore extends ILocalStore {
  // SharedPreferences _instance;
  GetStorage _storage;
  FlutterSecureStorage _secureStorage;

  init() async {
    GetStorage.init();
    _storage = GetStorage();
    _secureStorage = new FlutterSecureStorage();
  }

  // Future<String> getUserEmail() {
  //   return _storage.read('UserEmail');
  // }

  // Future<bool> setUserEmail(email) {
  //   return _storage.write('UserEmail', email);
  // }

  @override
  Future<String> getKey(String key) {
    return _storage.read(key);
  }

  @override
  Future<String> getSecuredKey(String key) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<bool> setKey(String key, value) {
    return _storage.write(key, value);
  }

  @override
  Future<bool> setSecuredKey(String key, value) {
    return _secureStorage.write(key: key, value: value);
  }
}
