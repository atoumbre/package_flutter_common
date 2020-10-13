import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class IBaseService {
  final StreamController _errorStreamController = StreamController();

  @protected
  Future<T> catchError<T>(Future<T> Function() task) {
    return task().catchError((onError) => _errorStreamController.sink.add(onError));
  }

  Stream<dynamic> get errorStream => _errorStreamController.stream;

  Future<dynamic> init() async {}

  void dispose() => _errorStreamController.close();
}

// abstract class IStoppableService extends IBaseService {
//   bool serviceStopped = true;

//   Future<void> stop() async {
//     serviceStopped = true;
//   }

//   Future<void> start() async {
//     serviceStopped = false;
//   }
// }

typedef VoidAsyncCallback = Future<void> Function();

abstract class IStoppableService extends IBaseService {
  bool _serviceIsActive = false;
  bool _serviceIsEnabled = true;

  VoidAsyncCallback get startCallback;
  VoidAsyncCallback get stopCallback;

  get isOn => _serviceIsActive;
  get isEnabled => _serviceIsEnabled;

  @protected
  enable() => _serviceIsEnabled = true;

  disable() => _serviceIsEnabled = false;

  Future<void> stop() async {
    if (!_serviceIsEnabled) return;

    await stopCallback();
    _serviceIsActive = true;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;

    await start();
    _serviceIsActive = false;
  }
}
