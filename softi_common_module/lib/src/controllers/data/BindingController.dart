import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common_module/index.dart';
import 'package:softi_core_module/softi_core_module.dart';

class BindingController extends BaseController {
  static BindingController get find => Get.find<BindingController>();

  final DatabaseController _db;

  BindingController(DatabaseController db) : _db = db ?? Get.find();

  final Map<dynamic, StreamSubscription> _bindRecordSubscriptions = {};
  final Map<dynamic, StreamSubscription> _bindUserRecordSubscriptions = {};

  void bindUserRecord<T extends IResourceData>(
    Rx<AuthUser> authUserRX,
    Rx<T> dataRX, {
    T initialData,
    bool reactive,
    Future Function(AuthUser) creationCallback,
    Future Function(AuthUser) updateCallback,
    Future Function() unauthedCallback,
  }) async {
    Future<void> _bindUserRecord(authUser) async {
      if (_bindUserRecordSubscriptions[T] != null) {
        await _bindUserRecordSubscriptions[T].cancel();
        _bindUserRecordSubscriptions[T] = null;
      }

      if (authUser?.uid != null) {
        _bindUserRecordSubscriptions[T] = _db //
            .get<T>(authUser.uid, reactive: reactive) //
            .listen((dataEvent) async {
          if (dataEvent == null) {
            if (creationCallback != null) await creationCallback(authUser);
            dataRX(initialData);
          } else {
            if (updateCallback != null) await updateCallback(authUser);
            dataRX(dataEvent);
          }
        });
      } else {
        if (unauthedCallback != null) await unauthedCallback();
        dataRX(initialData);
      }
    }

    /// Listen to provided reactive user and bind user records
    await _bindUserRecord(authUserRX());
    authUserRX.listen(_bindUserRecord);
  }

  void bindRecord<S extends IResourceData, T extends IResourceData>(
    Rx<S> masterDataRX,
    Rx<T> dataRX, {
    T initialData,
    bool reactive = false,
    Future Function() creationCallback,
    Future Function(T data) updateCallback,
    Future Function() unauthedCallback,
    String Function(S) filter,
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
            if (creationCallback != null) await creationCallback();
            dataRX(initialData);
          } else {
            if (updateCallback != null) await updateCallback(dataEvent);
            dataRX(dataEvent);
          }
        });
      } else {
        if (unauthedCallback != null) await unauthedCallback();
        dataRX(initialData);
      }
    }

    var _filter = filter ?? (data) => data?.getId();
    await _bindRecord(_filter(masterDataRX()));
    masterDataRX.map(_filter).listen(_bindRecord);
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
