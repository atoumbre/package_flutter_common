abstract class IBaseService {
  Stream<dynamic> get errorStream;
}

abstract class IBaseStopableService extends IBaseService {
  Future<void> stop();
  Future<void> start();
}

abstract class IBaseDisposableService extends IBaseService {
  void init();
  void dispose();
}
