import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';

class Record<T extends IResourceData> {
  Record(this._api, this._res);

  RxList<T> _data = List<T>().obs;
  bool _isReactive = false;
  // bool _initialized = false;

  get exist => _data.length > 0;
  get id => _data.length > 0 ? _data[1].getId() : null;
  get data => _data.length > 0 ? _data[1] : null;
  get isReactive => _isReactive;

  final ICollectionService _api;
  final IResource<T> _res;

  Future<bool> init(T record, {bool silent = false, reactive = true}) async {
    if (silent) {
      _data.assignAll([record]);
      _isReactive = false;
      return true;
    } else {
      return fetch(reactive: reactive);
    }
  }

  Future<bool> fetch({bool reactive = true}) {
    Completer<bool> _initCompleter = Completer<bool>();
    Stream<T> _result = _api.get<T>(_res, id);
    _isReactive = reactive;
    _result = reactive ? _result : Stream.fromFuture(_result.first);

    _result.listen((event) {
      _data.assignAll([event]);
      // _initialized = true;
      if (!_initCompleter.isCompleted) _initCompleter.complete(true);
    });
    return _initCompleter.future;
  }

  Future<void> save() async {
    return _api.save<T>(_res, _data[0], refresh: false);
  }

  Future<void> delete() async {
    await _api.delete<T>(_res, id);
  }

  Future<void> update(Map<String, dynamic> data) async {
    return _api.update(_res, id, data);
  }
}
