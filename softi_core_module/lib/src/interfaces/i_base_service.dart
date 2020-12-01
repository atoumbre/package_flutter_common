import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class IBaseService {
  // final StreamController _errorStreamController = StreamController();

  @protected
  Future<T> catchError<T>(
    Future<T> Function() task,
  ) {
    try {
      return task();
    } catch (e) {
      if (!errorHandler(e)) rethrow;
    } finally {
      return null;
    }
  }

  bool errorHandler(error) {
    print(error.toString());
    return false;
  }

  Future<dynamic> init() async {}
  Future<dynamic> dispose() async {}
}

typedef VoidAsyncCallback = Future<void> Function();

abstract class IStoppableService extends IBaseService {
  bool _serviceIsActive = false;
  bool _serviceIsEnabled = false;

  Future<dynamic> startCallback();
  Future<dynamic> stopCallback();

  bool get isOn => _serviceIsActive;
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

    await stopCallback();
    _serviceIsActive = false;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;

    await startCallback();
    _serviceIsActive = true;
  }
}

abstract class IBaseServiceException implements Exception {
  final String service;
  final String code;
  final String message;

  IBaseServiceException({@required this.service, @required this.code, this.message});
}
