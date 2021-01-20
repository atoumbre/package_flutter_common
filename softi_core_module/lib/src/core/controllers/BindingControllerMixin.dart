import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/src/core/base_controller.dart';

mixin BindingControllerMixin on BaseController {
  // String get ressourceTag;

  Future<void> Function() binder<S, T>(
    Stream<S> rxMaster,
    Rx<T> rxData, {
    Function(S, T) handler,
    Function(S) masterHandler,
    bool Function(S) canBind,
    Stream<T> Function(S) binder,
  }) {
    StreamSubscription _sub;
    StreamSubscription _masterSub;
    var initialData = rxData();
    void _binder(S master) {
      if (canBind != null ? canBind(master) : master != null) {
        _sub = binder(master).listen((event) => handler(master, event));
      } else {
        rxData(initialData);
        _sub?.cancel();
      }

      //
      if (masterHandler != null) masterHandler(master);
    }

    // _binder(rxMaster());
    _masterSub = rxMaster.listen(_binder);

    return () async {
      await _sub?.cancel();
      await _masterSub?.cancel();
    };
  }

  Future<void> Function() binderList<S, T>(
    Stream<S> rxMaster,
    RxList<T> rxData, {
    Function(S, List<T>) handler,
    Function(S) masterHandler,
    bool Function(S) canBind,
    Stream<List<T>> Function(S) binder,
  }) {
    StreamSubscription _sub;
    StreamSubscription _masterSub;
    // var initialData = rxData();
    void _binder(S master) {
      if (canBind != null ? canBind(master) : master != null) {
        _sub = binder(master).listen((event) => handler(master, event));
      } else {
        rxData.assignAll([]);
        _sub?.cancel();
      }

      //
      if (masterHandler != null) masterHandler(master);
    }

    // _binder(rxMaster());
    _masterSub = rxMaster.listen(_binder);

    return () async {
      await _sub?.cancel();
      await _masterSub?.cancel();
    };
  }
}
