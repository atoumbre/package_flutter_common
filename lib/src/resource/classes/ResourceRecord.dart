import 'dart:async';

import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_collection_service.dart';
import 'package:get/get.dart';

class ResourceRecord<T extends IResourceData> {
  ResourceRecord(this._collectionService, this._res);

  final Rx<T> data = Rx<T>();

  String get id => data.value?.getId();
  // Rx<T> get data => _data;

  final ICollectionService _collectionService;
  final IResource<T> _res;
  StreamSubscription<T> _sub;
  final RxInt fetchCount = 0.obs;

  void init(
    String recordId, {
    bool reactive = true,
  }) {
    _sub = _collectionService.get<T>(_res, recordId, reactive: reactive).listen((event) {
      data(event);
      fetchCount.value++;
    });
  }

  void dispos() {
    _sub.cancel();
  }

  Future<void> save() async {
    return _collectionService.save<T>(_res, data.value);
  }

  Future<void> delete() async {
    await _collectionService.delete<T>(_res, id);
  }

  Future<void> update(Map<String, dynamic> data) async {
    return _collectionService.update<T>(_res, id, data);
  }

  Future<void> exist() async {
    return _collectionService.exists<T>(_res, id);
  }

  void deserialize(Map<String, dynamic> map) {
    data(_res.deserializer(map));
  }

  T call() => data.value;
}
