import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/controllers/TaskControllerMixin.dart';

abstract class IBaseController extends GetxController {
  final busy = false.obs;
  // final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder
}

class BaseController extends IBaseController with TaskHandlerMixin, LoadingStatusControllerMixin {}
