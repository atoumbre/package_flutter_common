import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/resource/interfaces/i_resource.dart';
import 'package:softi_common/src/resource/interfaces/i_resource_adapter.dart';

class ResourceRecord<T extends IResourceData> {
  final IResourceAdapter<T> adapter;
  ResourceRecord(this.adapter); // : data = adapter.resource.deserializer({}).obs;

  final Rx<T?> data = Rx<T?>(null);
  final RxInt fetchCount = 0.obs;
  late StreamSubscription<T> _sub;

  // String get data => data?.value?.getId();
  String? get id => data.value?.getId();

  void init(
    String? recordId, {
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

  T? call() => data.value;
}
