import 'package:get_storage/get_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:softi_core_module/softi_core_module.dart';

class DefaultLocalStore extends ILocalStore {
  final GetStorage _storage;
  final FlutterSecureStorage _secureStorage;

  DefaultLocalStore()
      : _storage = GetStorage(),
        _secureStorage = FlutterSecureStorage();

  Future<ILocalStore> init([String container = 'GetStorage']) async {
    await GetStorage.init(container);
    // return GetStorage();
    return this;
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
