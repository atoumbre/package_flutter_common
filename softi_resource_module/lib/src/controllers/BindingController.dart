import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_resource_module/src/classes/Database.dart';
import 'package:softi_resource_module/src/classes/resource.dart';

class BindingController extends BaseController {
  static BindingController get find => Get.find<BindingController>();

  final DatabaseController _db;

  BindingController(DatabaseController db) : _db = db ?? Get.find();

  final Map<dynamic, StreamSubscription> _bindRecordSubscriptions = {};

  void bindRecord<S, T extends IResourceData>(
    Rx<S> masterRX,
    Rx<T> dataRX,
    String Function(S) filter, {
    T initialData,
    bool reactive = false,
    Future Function(S) creationCallback,
    Future Function(S, T) updateCallback,
    Future Function() nullMasterCallback,
  }) async {
    if (_bindRecordSubscriptions[T] != null) {
      await _bindRecordSubscriptions[T].cancel();
      _bindRecordSubscriptions[T] = null;
    }

    Future<void> _bindRecord(String id) async {
      if ((id ?? '') != '') {
        _bindRecordSubscriptions[T] = _db //
            .get<T>(id, reactive: reactive) //
            .listen((dataEvent) async {
          if (dataEvent == null) {
            if (creationCallback != null) await creationCallback(masterRX());
            dataRX(initialData);
          } else {
            if (updateCallback != null) await updateCallback(masterRX(), dataEvent);
            dataRX(dataEvent);
          }
        });
      } else {
        if (nullMasterCallback != null) await nullMasterCallback();
        dataRX(initialData);
      }
    }

    await _bindRecord(filter(masterRX()));
    masterRX.map(filter).listen(_bindRecord);
  }

  // void bindCollection<T extends IResourceData>(AuthUser authUser, RxList<T> dataList, Filter fliter) async {
  //   if (_subscription[T] != null) {
  //     await _subscription[T].cancel();
  //     _subscription[T] = null;
  //   }

  //   if ((authUser?.uid ?? '') != '') {
  //     final _filter = fliter.build();
  //     final _recordStream = db
  //         .find<T>(_filter) //
  //         .map<List<T>>((event) => event.data);

  //     _subscription[T] = _recordStream.listen((dataListEvent) async {
  //       if (dataListEvent == null) {
  //         dataList.assignAll([]);
  //       } else {
  //         dataList.assignAll(dataListEvent);
  //       }
  //     });
  //   } else {
  //     dataList.assignAll([]);
  //   }
  // }

}
