import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nested/nested.dart';
import 'package:softi_common_module/src/interfaces/app/i_loading_service.dart';

class LoadingService extends ILoadingService {
  @override
  Future<void> showStatus({String status, EasyLoadingMaskType maskType, bool dismissOnTap = false}) {
    return catchError<void>(() async {
      return EasyLoading.show(status: status, maskType: maskType, dismissOnTap: dismissOnTap);
    });
  }

  @override
  Future<void> showSuccess(String status, {Duration duration, EasyLoadingMaskType maskType, bool dismissOnTap}) {
    return catchError<void>(() async {
      return EasyLoading.showSuccess(status, duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
    });
  }

  @override
  Future<void> showError(String status, {Duration duration, EasyLoadingMaskType maskType, bool dismissOnTap}) {
    return catchError<void>(() async {
      return EasyLoading.showError(status, duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
    });
  }

  @override
  Future<void> showInfo(String status, {Duration duration, EasyLoadingMaskType maskType, bool dismissOnTap}) {
    return catchError<void>(() async {
      return EasyLoading.showInfo(status, duration: duration, maskType: maskType, dismissOnTap: dismissOnTap);
    });
  }

  @override
  Future<void> dismiss() => catchError<void>(EasyLoading.dismiss);

  @override
  Future<void> init() async {
    EasyLoading.instance
          // ..displayDuration = const Duration(milliseconds: 2000)
          // ..indicatorType = EasyLoadingIndicatorType.fadingCircle
          // ..loadingStyle = EasyLoadingStyle.dark
          // ..indicatorSize = 45.0
          // ..radius = 10.0
          // ..progressColor = Colors.yellow
          // ..backgroundColor = Colors.green
          // ..indicatorColor = Colors.yellow
          // ..textColor = Colors.yellow
          // ..maskColor = Colors.blue.withOpacity(0.5)
          // ..userInteractions = false
          ..dismissOnTap = true
        // ..customAnimation = CustomAnimation();
        ;
  }
}

class LoadingManager extends SingleChildStatelessWidget {
  @override
  Widget buildWithChild(BuildContext context, Widget child) {
    return EasyLoading.init()(context, child);
  }
}
