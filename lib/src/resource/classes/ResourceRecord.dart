import 'dart:async';

import 'package:softi_common/src/resource/classes/resource.dart';
import 'package:softi_common/src/resource/interfaces/i_collection_service.dart';
import 'package:get/get.dart';

class ResourceDAO<T extends IResourceData> {
  ResourceDAO(this._api, this._res);

  final Rx<T> _data = Rx<T>();
  bool _reactive = false;

  String get id => _data.value?.getId();
  bool get exist => id != null;
  T get data => _data.value;
  bool get isReactive => _reactive;

  final ICollectionService _api;
  final IResource<T> _res;

  Future<T> init(
    T record, {
    bool fetch = true,
    bool reactive = true,
  }) async {
    _reactive = reactive;
    _data(record);

    if (fetch) {
      return this.fetch();
    } else {
      return Future.value(null);
    }
  }

  Future<T> fetch() {
    var _initCompleter = Completer<T>();

    _api.get<T>(_res, id, reactive: _reactive).listen((event) {
      _data(event);
      _initCompleter.complete(_data());
    });

    return _initCompleter.future;
  }

  Future<void> save() async {
    return _api.save<T>(_res, _data.value);
  }

  Future<void> delete() async {
    await _api.delete<T>(_res, id);
  }

  Future<void> update(Map<String, dynamic> data) async {
    return _api.update(_res, id, data);
  }

  void deserialize(Map<String, dynamic> data) {
    _data(_res.deserializer(data));
  }

  T call() => _data.value;
}
