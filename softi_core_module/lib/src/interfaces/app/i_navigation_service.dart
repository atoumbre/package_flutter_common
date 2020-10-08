import 'package:flutter/material.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> get navigationKey;

  back<T>(T result);

  Future<T> to<T>(String routeName, {dynamic arguments, NavType type: NavType.Push});
  Future<T> toView<T>(Widget view, {dynamic arguments, NavType type: NavType.Push});

  refresh();
}

enum NavType {
  Push,
  Replace,
  ReplaceAll,
}
