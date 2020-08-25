import 'package:flutter/material.dart';

abstract class INavigationService {
  GlobalKey<NavigatorState> get navigationKey;

  back(dynamic result);

  Future<dynamic> to(String routeName, {dynamic arguments, NavType type: NavType.Push});
  Future<dynamic> toView(Widget view, {dynamic arguments, NavType type: NavType.Push});

  refresh();
}

enum NavType {
  Push,
  Replace,
  ReplaceAll,
}
