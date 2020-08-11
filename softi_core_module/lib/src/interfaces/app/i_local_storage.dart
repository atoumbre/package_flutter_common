abstract class ILocalStore {
  init();
  Future<String> getKey(String key);
  Future<String> getSecuredKey(String key);
  Future<bool> setKey(String key, dynamic value);
  Future<bool> setSecuredKey(String key, dynamic value);
}
