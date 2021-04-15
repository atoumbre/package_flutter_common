import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_common/core.dart';
import 'package:softi_common/src/core/controllers/BaseController.dart';
import 'package:softi_common/src/core/services/interfaces/i_local_storage.dart';

mixin LocaleControllerMixin on IBaseController {
  ILocalStore get _store => Get.find();

  final _locale = Locale('fr').obs;

  Locale get locale => _locale.value;

  Future<void> _setLanguage(Locale language) async {
    Get.updateLocale(language);

    _locale(language);
  }

  Future<void> setLanguage(Locale language, {save = true}) async {
    Get.updateLocale(language);
    if (save) await _store.setKey('language', language.toString());
  }

  Future<void> getLanguage() async {
    var languageText = await _store.getKey('language');
    if (languageText == null) return;

    var _split = languageText.toString().split('_');
    var lang = _split.isNotEmpty ? _split[0] : '';
    var country = _split.length > 1 ? _split[1] : '';

    await _setLanguage(Locale(lang, country));
  }
}

class LocaleController extends IBaseController with LocaleControllerMixin {
  static LocaleController get find => Get.find<LocaleController>();

  @override
  void onInit() {
    super.onInit();
    getLanguage();
  }
}
