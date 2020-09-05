import 'package:flutter/material.dart';

abstract class IThemeSelector {
  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Future<void> setThemeMode(ThemeMode themeMode);

  //  async {
  //   Get.changeThemeMode(themeMode);
  //   _themeMode = themeMode;
  //   update();
  //   await Services.store.setKey('theme', themeMode.toString().split('.')[1]);
  // }

  getThemeModeFromPreferences();

  //  async {
  //   ThemeMode themeMode;
  //   String themeText = Services.store.getKey('theme') ?? 'system';
  //   try {
  //     themeMode = ThemeMode.values.firstWhere((e) => describeEnum(e) == themeText);
  //   } catch (e) {
  //     themeMode = ThemeMode.system;
  //   }
  //   setThemeMode(themeMode);
  // }
}
