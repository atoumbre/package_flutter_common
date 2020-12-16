import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_core_module/src/base_controller.dart';

class TimerController extends BaseController with TimerControllerMixin {
  static TimerController get find => Get.find();

  final Duration _interval;
  TimerController(Duration interval) : _interval = interval ?? 1.minutes;

  @override
  Duration get interval => _interval;

  @override
  void onReady() {
    startTimer();
    super.onReady();
  }

  @override
  void onClose() {
    startTimer();
    super.onClose();
  }
}
