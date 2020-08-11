abstract class ILocalStore {
  init();
  Future<String> getUserEmail();
  Future<bool> setUserEmail(email);
}
