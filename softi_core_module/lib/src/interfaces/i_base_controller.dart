import 'dart:async';

import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final busy = false.obs;
  final lastError = Error().obs;
  final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder

  final clock = DateTime.now().obs;

  Timer _timer;

  @override
  void onInit() {
    _timer = Timer.periodic(1.minutes, (timer) {
      clock(DateTime.now());
    });
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }
}
