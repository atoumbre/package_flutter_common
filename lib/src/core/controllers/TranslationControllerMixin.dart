import 'package:get/get.dart';
import 'package:softi_common/src/core/BaseController.dart';

mixin TranslationControllerMixin on IBaseController {
  Map<String, Map<String, String>> translations();

  void loadTranslations() {
    Get.appendTranslations(translations());
  }

  // @override
  // void onInit() {

  //   super.onInit();
  // }
  //  => {
  //     'en': english(),
  //     'fr': french(),
  //   };

  // ILocalStore get _store => Get.find();

  // final _locale = Locale('fr').obs;

  // Locale get locale => _locale.value;

  // Future<void> _setLanguage(Locale language) async {
  //   Get.updateLocale(language);

  //   _locale(language);
  // }

  // Future<void> setLanguage(Locale language, {save = true}) async {
  //   Get.updateLocale(language);
  //   await _store.setKey('language', language.toString());
  // }

  // Future<Locale> getLanguage() async {
  //   var languageText = await _store.getKey('language');
  //   var _split = languageText.toString().split('_');
  //   var lang = _split.isNotEmpty ? _split[0] : '';
  //   var country = _split.length > 1 ? _split[1] : '';
  //   await _setLanguage(Locale(lang, country));
  //   return Locale(lang, country);
  // }
  //
  //

}
