import 'dart:async';

abstract class IBaseService {
  // @protected
  Future<T> failureCatcher<T>(Future<T> Function() task) async {
    try {
      var result = await task();
      return result;
    } catch (e) {
      var formatedFailer = errorHandler(e);
      if (formatedFailer != null) {
        throw formatedFailer;
      } else {
        rethrow;
      }
    }
  }

  ServiceFailure? errorHandler(dynamic error) {
    return ServiceFailure(
      service: runtimeType.toString(),
      code: '_SERVICE_EXCEPTION_',
      message: 'Unhandled service exeption',
      rawError: error,
    );
  }

  Future<dynamic> init() async {}
  Future<dynamic> dispose() async {}
}

abstract class IStoppableService extends IBaseService {
  bool _serviceIsActive = false;
  bool _serviceIsEnabled = false;

  Future<dynamic> startCallback();
  Future<dynamic> stopCallback();

  bool get isActive => _serviceIsActive;
  bool get isEnabled => _serviceIsEnabled;

  Future<void> enable({bool startLate = false}) async {
    _serviceIsEnabled = true;
    if (!startLate) {
      return start();
    }
  }

  Future<void> disable() {
    _serviceIsEnabled = false;
    return stop();
  }

  Future<void> stop() async {
    if (!_serviceIsEnabled) return;
    if (!_serviceIsActive) return;

    await stopCallback();
    _serviceIsActive = false;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;
    if (_serviceIsActive) return;

    _serviceIsActive = true;
    await startCallback();
  }
}

class ServiceFailure implements Exception {
  final String service;
  final String code;
  final String? message;
  final dynamic? rawError;

  ServiceFailure({
    required this.service,
    required this.code,
    this.message,
    this.rawError,
  });
}
