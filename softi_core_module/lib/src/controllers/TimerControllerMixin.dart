import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/src/i_base_controller.dart';

mixin TimerControllerMixin on BaseController {
  Duration get interval;

  final clock = DateTime.now().obs;
  Timer _timer;

  void stop() {
    _timer.cancel();
  }

  void start() {
    _timer = Timer.periodic(interval, (timer) {
      clock(DateTime.now());
    });
  }

  @override
  void onReady() {
    start();
    super.onReady();
  }

  @override
  void onClose() {
    stop();
    super.onClose();
  }
}
