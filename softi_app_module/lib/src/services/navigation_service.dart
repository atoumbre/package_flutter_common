import 'package:flutter/widgets.dart';
import 'package:softi_core_module/softi_core_module.dart';

class NavigationService extends INavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  pop(dynamic result) {
    final _navigator = _navigationKey.currentState;
    return _navigator.pop(result);
  }

  navigateTo(String routeName, {dynamic arguments, replace: NavType.Push}) {
    final _navigator = _navigationKey.currentState;
    if (replace == NavType.Replace) return _navigator.pushReplacementNamed(routeName, arguments: arguments);
    if (replace == NavType.ReplaceAll) return _navigator.pushReplacementNamed(routeName, arguments: arguments);
    if (replace == NavType.PopAndReplace) return _navigator.popAndPushNamed(routeName, arguments: arguments);
    return _navigator.pushNamed(routeName, arguments: arguments);
  }

  refresh() {
    // TODO: implement refresh
    throw UnimplementedError();
  }
}
