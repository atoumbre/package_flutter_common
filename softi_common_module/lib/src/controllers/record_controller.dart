import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/softi_core_module.dart';

class Record<T extends IResourceData> {
  Record(this._api, this._res);

  Rx<T> _data;
  RxBool _exist;

  final ICollectionService _api;
  final IResource<T> _res;

  void fetch(String id, {bool reactive = true}) {
    Stream<T> _result = _api.get<T>(_res, id);
    _data.bindStream(reactive ? _result : Stream.fromFuture(_result.first));
    _exist.bindStream(_data.map((data) => data != null));
  }

  Future<T> save(T newData, {bool refresh = true}) async {
    return _api.save<T>(_res, newData, refresh: refresh);
  }

  Future<void> delete(String id) async {
    await _api.delete<T>(_res, id);
  }

  Future<void> update(String id, Map<String, dynamic> data) async {
    return _api.update(_res, id, data);
  }

  Future<bool> exist(id) async {
    return _api.exists(_res, id);
  }
}
