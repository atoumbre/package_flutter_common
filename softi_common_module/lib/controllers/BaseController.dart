import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final busy = false.obs;
  final lastError = Error().obs;
  final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder
}
