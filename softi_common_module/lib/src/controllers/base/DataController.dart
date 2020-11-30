import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common_module/softi_common_module.dart';
import 'package:softi_core_module/softi_core_module.dart';

class DataController extends BaseController {
  static DataController get find => Get.find<DataController>();

  final DatabaseController _db;

  DataController(DatabaseController db) : _db = db ?? Get.find();

  final Map<dynamic, StreamSubscription> _bindRecordSubscriptions = {};
  final Map<dynamic, StreamSubscription> _bindUserRecordSubscriptions = {};

  void bindUserRecord<T extends IResourceData>(
    AuthUser authUser, {
    Rx<T> rxData,
    T initialData,
    reactive = false,
    Future Function(AuthUser) creationCallback,
    Future Function(AuthUser) updateCallback,
    Future Function() unauthenticatedCallback,
  }) async {
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
}
