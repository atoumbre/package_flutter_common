import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common_module/softi_common_module.dart';
import 'package:softi_core_module/softi_core_module.dart';

class BaseDataController extends BaseController {
  static BaseDataController get find => Get.find<BaseDataController>();

  final DatabaseController _db;

  BaseDataController(DatabaseController db) : _db = db ?? Get.find();

  final Map<dynamic, StreamSubscription> _bindRecordSubscriptions = {};
  final Map<dynamic, StreamSubscription> _bindUserRecordSubscriptions = {};

  void bindUserRecord<T extends IResourceData>(
    Rx<AuthUser> authUserRX, {
    Rx<T> rxData,
    T initialData,
    reactive = false,
    Future Function(AuthUser) creationCallback,
    Future Function(AuthUser) updateCallback,
    Future Function() unauthenticatedCallback,
  }) async {
    /// Listen to provided reactive user and bind user records
    ///
    authUserRX.listen((authUser) async {
      if (_bindUserRecordSubscriptions[T] != null) {
        await _bindUserRecordSubscriptions[T].cancel();
        _bindUserRecordSubscriptions[T] = null;
      }

      if (authUser?.uid != null) {
        _bindUserRecordSubscriptions[T] = _db //
            .get<T>(authUser.uid) //
            .listen((dataEvent) async {
          if (dataEvent == null) {
            if (creationCallback != null) await creationCallback(authUser);
          } else {
            if (updateCallback != null) await updateCallback(authUser);
            rxData(dataEvent);
          }
        });
      } else {
        if (unauthenticatedCallback != null) await unauthenticatedCallback();
        await AuthController.find.api.signInAnonymously();
      }
    });
  }

  void bindRecord<T extends IResourceData>(
    String id, {
    Rx<T> rxData,
    T initialData,
    reactive = false,
    Future Function() creationCallback,
    Future Function(T data) updateCallback,
    Future Function() unauthenticatedCallback,
  }) async {
    if (_bindRecordSubscriptions[T] != null) {
      await _bindRecordSubscriptions[T].cancel();
      _bindRecordSubscriptions[T] = null;
    }

    if ((id ?? '') != '') {
      _bindRecordSubscriptions[T] = _db //
          .get<T>(id, reactive: reactive) //
          .listen((dataEvent) async {
        if (dataEvent == null) {
          if (creationCallback != null) await creationCallback();
          rxData(initialData);
        } else {
          if (updateCallback != null) await updateCallback(dataEvent);
          rxData(dataEvent);
        }
      });
    } else {
      if (unauthenticatedCallback != null) await unauthenticatedCallback();
      rxData(initialData);
    }
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
