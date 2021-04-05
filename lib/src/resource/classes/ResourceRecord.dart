import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_resource_adapter.dart';

class ResourceRecord<T extends IResourceData> {
  final IResourceAdapter<T> adapter;
  ResourceRecord(this.adapter);

  final Rx<T> data = Rx<T>();
  final RxInt fetchCount = 0.obs;
  StreamSubscription<T> _sub;

  String get id => data.value?.getId();

  void init(
    String recordId, {
    bool reactive = true,
  }) {
    _sub = adapter.get(recordId, reactive: reactive).listen((event) {
      data(event);
      fetchCount.value++;
    });
  }

  void dispos() {
    _sub.cancel();
  }

  // Future<void> save() async {
  //   return _res.adapteur.save(data.value);
  // }

  // Future<void> delete() async {
  //   await _res.adapteur.delete(id);
  // }

  // Future<void> update(Map<String, dynamic> data) async {
  //   return _res.adapteur.update(id, data);
  // }

  // Future<void> exist() async {
  //   return _res.adapteur.exists(id);
  // }

  // void deserialize(Map<String, dynamic> map) {
  //   data(_res.deserializer(map));
  // }

  T call() => data.value;
}
