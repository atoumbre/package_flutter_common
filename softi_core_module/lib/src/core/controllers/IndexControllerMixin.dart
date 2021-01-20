import 'package:get/get.dart';
import 'package:softi_core_module/src/core/base_controller.dart';

mixin IndexControllerMixin on BaseController {
  int get maxIndex;

  final index = 0.obs;

  set setValue(int newIndex) {
    index(newIndex);
  }
}
