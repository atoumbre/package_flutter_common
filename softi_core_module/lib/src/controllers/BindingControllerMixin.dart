import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';

mixin BindingControllerMixin on BaseController {
  // String get ressourceTag;

  Future<void> Function() binder<S, T>(
    Stream<S> rxMaster,
    Stream<T> rxData, {
    Function(S, T) handler,
    Function(S) masterHandler,
    Stream<T> Function(S) binder,
    bool Function(S) canBind,
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

    _binder(rxMaster());
    _masterSub = rxMaster.stream.listen(_binder);

    return () async {
      await _sub?.cancel();
      await _masterSub?.cancel();
    };
  }
}
