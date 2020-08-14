abstract class ILocalStore {
  init();
  Future<String> getKey(String key);
  Future<String> getSecuredKey(String key);
  Future<void> setKey(String key, dynamic value);
  Future<void> setSecuredKey(String key, dynamic value);
}
