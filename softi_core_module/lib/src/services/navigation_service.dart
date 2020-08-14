import 'package:flutter/widgets.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:get/get.dart';

class NavigationService extends INavigationService {
  GlobalKey<NavigatorState> get navigationKey => Get.key;

  pop(dynamic result) {
    Get.back(result: result);
  }

  refresh() {
    Get.offAndToNamed(Get.currentRoute, arguments: Get.arguments);
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments, replace: NavType.Push}) {
    if (replace == NavType.Replace) return Get.offNamed(routeName, arguments: arguments);
    if (replace == NavType.ReplaceAll) return Get.offAllNamed(routeName, arguments: arguments);
    if (replace == NavType.PopAndReplace) return Get.offAndToNamed(routeName, arguments: arguments);
    return Get.toNamed(routeName, arguments: arguments);
  }
}

// class DefaultNavigationService extends INavigationService {
//   GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

//   GlobalKey<NavigatorState> get navigationKey => _navigationKey;

//   pop(dynamic result) {
//     final _navigator = _navigationKey.currentState;
//     return _navigator.pop(result);
//   }

//   Future<dynamic> navigateTo(String routeName, {dynamic arguments, replace: NavType.Push}) {
//     final _navigator = _navigationKey.currentState;
//     if (replace == NavType.Replace) return _navigator.pushReplacementNamed(routeName, arguments: arguments);
//     if (replace == NavType.ReplaceAll) return _navigator.pushReplacementNamed(routeName, arguments: arguments);
//     if (replace == NavType.PopAndPush) return _navigator.popAndPushNamed(routeName, arguments: arguments);
//     return _navigator.pushNamed(routeName, arguments: arguments);
//   }
// }
