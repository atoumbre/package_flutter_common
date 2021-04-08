import 'dart:async';

import 'package:flutter/foundation.dart';

typedef VoidAsyncCallback = Future<void> Function();

abstract class IBaseService {
  @protected
  Future<T>? catchError<T>(
    Future<T> Function() task,
  ) {
    try {
      return task();
    } catch (e) {
      throw errorHandler(e);
    }
  }

  ServiceException errorHandler(dynamic error) {
    return ServiceException(
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

    await stopCallback();
    _serviceIsActive = false;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;

    await startCallback();
    _serviceIsActive = true;
  }
}

class ServiceException implements Exception {
  final String service;
  final String code;
  final String? message;
  final dynamic? rawError;

  ServiceException({
    required this.service,
    required this.code,
    this.message,
    this.rawError,
  });
}
