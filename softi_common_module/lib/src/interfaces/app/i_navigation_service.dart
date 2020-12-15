import 'dart:async';

import 'package:flutter/material.dart';
import 'package:softi_core_module/index.dart';

abstract class INavigationService extends IBaseService {
  GlobalKey<NavigatorState> get navigationKey;

  void back<T>(T result);

  Future<T> to<T>(String routeName, {dynamic arguments, NavType type = NavType.Push});
  Future<T> toView<T>(Widget view, {dynamic arguments, NavType type = NavType.Push});

  Future<void> refresh();
}

enum NavType {
  Push,
  Replace,
  ReplaceAll,
}
