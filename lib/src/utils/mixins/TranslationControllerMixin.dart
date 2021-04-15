import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/BaseController.dart';

mixin TranslationControllerMixin on IBaseController {
  Map<String, Map<String, String>> translations();

  void loadTranslations() {
    var _translations = translations();
    Get.appendTranslations(_translations);
  }
}
