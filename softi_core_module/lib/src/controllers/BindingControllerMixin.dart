import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';

class _TAG<S, T> {
  String tag;
  StreamSubscription<S> masterSub;
  StreamSubscription<T> slaveSub;
  _TAG(this.tag);
}

mixin BindingControllerMixin on BaseController {
  String get ressourceTag;

  Future<Function> binder<S, T>(
    //
    Rx<S> masterRX,
    Rx<T> dataRX, {
    Stream<T> Function(S) binder,
    //
    bool Function(S) masterIsNull,
    // Callbacks
    Future Function(S) nullEventCallback,
    Future Function(S, T) eventCallback,
    Future Function() masterNullEventCallback,
    String tag = 'default',
  }) async {
    var _initialData = dataRX();

    var _subs = _TAG<S, T>(tag);

    await _subs.slaveSub?.cancel();

    Future<void> _binder(master) async {
      if (masterIsNull == null ? master != null : !masterIsNull(master)) {
        _subs.slaveSub = binder(master).listen((dataEvent) async {
          if (dataEvent == null) {
            if (nullEventCallback != null) await nullEventCallback(master);
            dataRX(_initialData);
          } else {
            if (eventCallback != null) await eventCallback(master, dataEvent);
            dataRX(dataEvent);
          }
        });
      } else {
        if (masterNullEventCallback != null) await masterNullEventCallback();
        dataRX(_initialData);
      }
    }

    await _subs.masterSub?.cancel();
    await _binder(masterRX());
    _subs.masterSub = masterRX.stream.listen(_binder);

    return () async {
      await Future.wait([
        _subs.masterSub?.cancel(),
        _subs.slaveSub?.cancel(),
      ]);
    };
  }
}
