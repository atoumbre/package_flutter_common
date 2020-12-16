import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:softi_core_module/index.dart';
import 'package:softi_core_module/src/interfaces/i_local_storage.dart';

mixin ThemeControllerMixin on BaseController {
  ILocalStore get _store => Get.find();

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
}
