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
    Rx<S> masterRX,
    Rx<T> dataRX, {
    Stream<T> Function(Rx<S>) binder,
    Future Function(S) nullEventCallback,
    Future Function(S, T) eventCallback,
    Future Function() masterNullEventCallback,
    String tag = 'default',
  }) async {
    var _initialData = dataRX();

    var _subs = _TAG<S, T>(tag);

    await _subs.slaveSub?.cancel();

    Future<void> _binder(S master) async {
      if (masterRX != null) {
        _subs.slaveSub = binder(masterRX).listen((dataEvent) async {
          if (dataEvent == null) {
            if (nullEventCallback != null) await nullEventCallback(masterRX());
            dataRX(_initialData);
          } else {
            if (eventCallback != null) await eventCallback(masterRX(), dataEvent);
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
