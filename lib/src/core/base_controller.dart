import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final busy = false.obs;
  // final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder
}
