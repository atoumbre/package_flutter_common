import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_common_module/src/interfaces/app/i_navigation_service.dart';

class NavigationService extends INavigationService {
  @override
  GlobalKey<NavigatorState> get navigationKey => Get.key;

  @override
  void back<T>(T result) {
    return Get.back(result: result);
  }

  @override
  Future<void> refresh() async {
    await Get.offAndToNamed(Get.currentRoute, arguments: Get.arguments);
  }

  @override
  Future<T> to<T>(String routeName, {dynamic arguments, type = NavType.Push}) {
    if (type == NavType.Replace) return Get.offNamed(routeName, arguments: arguments);
    if (type == NavType.ReplaceAll) return Get.offAllNamed(routeName, arguments: arguments);
    return Get.toNamed(routeName, arguments: arguments);
  }

  @override
  Future<T> toView<T>(Widget view, {dynamic arguments, type = NavType.Push}) {
    if (type == NavType.Replace) return Get.off(view, arguments: arguments);
    if (type == NavType.ReplaceAll) return Get.offAll(view, arguments: arguments);
    return Get.to(view, arguments: arguments);
  }
}
