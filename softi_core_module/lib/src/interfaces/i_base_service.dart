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

typedef VoidAsyncCallback = Future<void> Function();

abstract class IStoppableService extends IBaseService {
  bool _serviceIsActive = false;
  bool _serviceIsEnabled = false;

  VoidAsyncCallback get startCallback;
  VoidAsyncCallback get stopCallback;

  bool get isOn => _serviceIsActive;
  bool get isEnabled => _serviceIsEnabled;

  Future<void> enable({bool statLate = false}) {
    if (statLate) {
      _serviceIsEnabled = true;
      return Future.value(true);
    } else {
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
    _serviceIsActive = true;
  }

  Future<void> start() async {
    if (!_serviceIsEnabled) return;

    await startCallback();
    _serviceIsActive = false;
  }
}
