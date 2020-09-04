abstract class ILocalStore {
  Future<void> init();
  Future<String> getKey(String key);
  Future<String> getSecuredKey(String key);
  Future<void> setKey(String key, dynamic value);
  Future<void> setSecuredKey(String key, dynamic value);
}
