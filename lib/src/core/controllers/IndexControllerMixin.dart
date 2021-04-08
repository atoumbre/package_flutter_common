import 'package:get/get.dart';
import 'package:softi_common/src/core/BaseController.dart';

mixin IndexControllerMixin on IBaseController {
  final index = 0.obs;
  final maxIndex = 1000.obs;
  final minIndex = 0.obs;

  void setValue(int newIndex) {
    index(newIndex);
  }

  void setBounds({int min = 0, int max = 1000}) {
    minIndex(min);
    maxIndex(max);
  }
}
