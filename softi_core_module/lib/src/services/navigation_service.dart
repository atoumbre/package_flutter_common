import 'package:flutter/widgets.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:get/get.dart';

class NavigationService extends INavigationService {
  GlobalKey<NavigatorState> get navigationKey => Get.key;

  back(dynamic result) {
    Get.back(result: result);
  }

  refresh() {
    Get.offAndToNamed(Get.currentRoute, arguments: Get.arguments);
  }

  Future<dynamic> to(String routeName, {dynamic arguments, type: NavType.Push}) {
    if (type == NavType.Replace) return Get.offNamed(routeName, arguments: arguments);
    if (type == NavType.ReplaceAll) return Get.offAllNamed(routeName, arguments: arguments);
    return Get.toNamed(routeName, arguments: arguments);
  }

  Future<dynamic> toView(Widget view, {dynamic arguments, type: NavType.Push}) {
    if (type == NavType.Replace) return Get.off(view, arguments: arguments);
    if (type == NavType.ReplaceAll) return Get.offAll(view, arguments: arguments);
    return Get.to(view, arguments: arguments);
  }
}
