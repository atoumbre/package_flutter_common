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
    bool Function(S) canBind,
    // Callbacks
    // Future Function(S, T) eventCallback,
    Future Function() masterNullEventCallback,
    String tag = 'default',
  }) async {
    var _initialData = dataRX();

    var _subs = _TAG<S, T>(tag);

    Future<void> _binder(master) async {
      // Cancel current slase subscribtion
      await _subs.slaveSub?.cancel();

      if (canBind == null ? master != null : canBind(master)) {
        // Listen to slave stream
        _subs.slaveSub = binder(master).listen((dataEvent) async {
          dataRX(dataEvent);
        });
      } else {
        if (masterNullEventCallback != null) {
          await masterNullEventCallback();
        } else {
          dataRX(_initialData);
        }
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

  Future<Function> binder2<S, T>(
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

    Future<void> _binder(master) async {
      // Cancel current slase subscribtion
      await _subs.slaveSub?.cancel();

      if (masterIsNull == null ? master != null : !masterIsNull(master)) {
        // Listen to slave stream
        _subs.slaveSub = binder(master).listen((dataEvent) async {
          if (dataEvent == null) {
            if (nullEventCallback != null) {
              await nullEventCallback(master);
            } else {
              dataRX(_initialData);
            }
          } else {
            if (eventCallback != null) {
              await eventCallback(master, dataEvent);
            } else {
              dataRX(dataEvent);
            }
          }
        });
      } else {
        if (masterNullEventCallback != null) {
          await masterNullEventCallback();
        } else {
          dataRX(_initialData);
        }
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
