import 'dart:async';

import 'package:get/get.dart';
import 'package:softi_core_module/src/i_base_controller.dart';

class TimerController extends BaseController {
  static TimerController get find => Get.find();

  final Duration _interval;

  TimerController(Duration interval) : _interval = interval ?? 1.minutes;

  final clock = DateTime.now().obs;
  Timer _timer;

  void stop() {
    _timer.cancel();
  }

  void start() {
    _timer = Timer.periodic(_interval, (timer) {
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
