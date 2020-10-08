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

abstract class IBaseStoppableService extends IBaseService {
  Future<void> stop();
  Future<void> start();
}

// abstract class IBaseDisposableService extends IBaseService {}
