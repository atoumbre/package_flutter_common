import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_common_module/src/controllers/base/BaseController.dart';
import 'package:softi_core_module/softi_core_module.dart';

class AppController extends BaseController {
  static AppController get find => Get.find();

  final ILocalStore _store;

  AppController([ILocalStore store]) : _store = store ?? Get.find();

  /// Theme management

  final _themeMode = ThemeMode.system.obs;

  ThemeData get theme => Get.theme;
  ThemeMode get themeMode => _themeMode.value;

  void _setThemeMode(ThemeMode themeMode) {
    Get.changeThemeMode(themeMode);
    _themeMode(themeMode);
  }

  Future<void> setThemeMode(ThemeMode newthemeMode, {save = true}) async {
    _setThemeMode(newthemeMode);
    if (save) await _store.setKey('theme', newthemeMode.toString().split('.')[1]);
  }

  Future<void> getThemeMode() async {
    ThemeMode themeMode;
    var themeText = await _store.getKey('theme');
    try {
      themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
    } catch (e) {
      themeMode = ThemeMode.system;
    }
    _setThemeMode(themeMode);
  }

  /// Locale

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

  Future<Locale> getLanguageFromPreferences() async {
    var languageText = await _store.getKey('language');
    var lang = languageText.toString().split('_')[0];
    var country = languageText.toString().split('_')[1];
    await _setLanguage(Locale(lang, country));
    return Locale(lang, country);
  }

  @override
  void onInit() {
    super.onInit();
    getThemeMode();
  }
}
