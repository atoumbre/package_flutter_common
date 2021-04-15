import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/BaseController.dart';

mixin BindingControllerMixin on IBaseController {
  // String get ressourceTag;

  Future<void> Function() binder<S, T>(
    Stream<S> rxMaster,
    Rx<T> rxData, {
    required Stream<T> Function(S) binder,
    required Function(S, T) handler,
    Function(S)? masterHandler,
    bool Function(S)? canBind,
  }) {
    StreamSubscription? _sub;
    StreamSubscription _masterSub;

    T? initialData = rxData();
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
      await _masterSub.cancel();
    };
  }

  Future<void> Function() binderList<S, T>(
    Stream<S> rxMaster,
    RxList<T> rxData, {
    required Function(S, List<T>) handler,
    required Stream<List<T>> Function(S) binder,
    Function(S)? masterHandler,
    bool Function(S)? canBind,
  }) {
    StreamSubscription? _sub;
    StreamSubscription _masterSub;

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
      await _masterSub.cancel();
    };
  }
}
