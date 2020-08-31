import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/src/interfaces/db/i_collection_service.dart';
import 'package:softi_core_module/src/models/base_model.dart';

class Record<T extends IBaseModel> {
  final ICollectionService _api; // = Get.find<ICollectionService>();

  bool _exist;
  T _data;

  final String id;

  /// Constructors
  Record(this.id, this._api);
  // Record.fromData(T data) : id = data.getId();

  /// Methods
  Future<T> fetch() async {
    _data = await _api.get<T>(id);
    _exist = _data != null;
    return _data;
  }

  Future<T> save() async {
    return _api.update<T>(_data);
  }

  Future<void> delete() async {
    await _api.delete<T>(id);
    _exist = false;
  }

  /// Getters
  Future<bool> get exist async {
    if (_exist == null) _exist = await _api.exists<T>(id);
    return Future.value(_exist);
  }

  T get data => _data;
}
