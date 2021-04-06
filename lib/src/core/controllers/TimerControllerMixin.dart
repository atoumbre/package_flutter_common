import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';

mixin TimerControllerMixin on IBaseController {
  Duration get interval;

  final clock = DateTime.now().obs;
  late Timer _timer;

  void stopTimer() {
    _timer.cancel();
  }

  void startTimer() {
    _timer = Timer.periodic(interval, (timer) {
      clock(DateTime.now());
    });
  }
}
