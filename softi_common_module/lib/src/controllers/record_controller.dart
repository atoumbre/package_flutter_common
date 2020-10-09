import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';

class Record<T extends IResourceData> {
  Record(this._api, this._res);

  Rx<T> _data;
  // bool _initialized = false;

  get exist => _data().getId() != null;
  get id => _data().getId();

  final ICollectionService _api;
  final IResource<T> _res;

  Future<bool> fetch(String id, {bool reactive = true}) {
    Completer<bool> _initCompleter = Completer<bool>();

    Stream<T> _result = _api.get<T>(_res, id);
    _result = reactive ? _result : Stream.fromFuture(_result.first);

    _result.listen((event) {
      _data(event);
      // _initialized = true;
      if (!_initCompleter.isCompleted) _initCompleter.complete(true);
    });

    return _initCompleter.future;
  }

  Future<T> save([T data, bool refresh = true]) async {
    return _api.save<T>(_res, _data.value, refresh: refresh);
  }

  Future<void> delete() async {
    await _api.delete<T>(_res, id);
  }

  Future<void> update(Map<String, dynamic> data) async {
    return _api.update(_res, id, data);
  }
}
