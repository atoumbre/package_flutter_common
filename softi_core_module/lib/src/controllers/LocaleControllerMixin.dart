import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_core_module/src/interfaces/i_local_storage.dart';

mixin LocaleControllerMixin on BaseController {
  ILocalStore get _store => Get.find();

  final _locale = Locale('en').obs;

  Locale get locale => _locale.value;

  Future<void> _setLanguage(Locale language) async {
    Get.updateLocale(language);
    _locale(language);
  }

  Future<void> setLanguage(Locale language, {save = true}) async {
    Get.updateLocale(language);
    await _store.setKey('language', language.toString());
  }

  Future<Locale> getLanguage() async {
    var languageText = await _store.getKey('language');
    var lang = languageText.toString().split('_')[0];
    var country = languageText.toString().split('_')[1];
    await _setLanguage(Locale(lang, country));
    return Locale(lang, country);
  }
}
