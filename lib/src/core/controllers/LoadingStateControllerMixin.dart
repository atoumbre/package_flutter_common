import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';

enum LoadingStatus { idle, loading, error }

mixin LoadingStatusControllerMixin on IBaseController {
  Rx<LoadingStatus> loadingStatus = LoadingStatus.loading.obs;

  void changeLoadingStatus(LoadingStatus newStatus) {
    loadingStatus(newStatus);
  }

  void toggleError() {
    loadingStatus(LoadingStatus.error);
  }

  void toggleLoading() {
    loadingStatus(LoadingStatus.loading);
  }

  void toggleIdle() {
    loadingStatus(LoadingStatus.idle);
  }
}

class LoadingStatusWidget extends StatelessWidget {
  final LoadingStatusControllerMixin controller;
  final Widget Function() loadingWidget, errorWidget, builder;

  const LoadingStatusWidget({
    Key key,
    this.controller,
    this.builder,
    this.errorWidget,
    this.loadingWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Obx(() {
        switch (controller.loadingStatus()) {
          case LoadingStatus.error:
            return errorWidget();
            break;

          case LoadingStatus.loading:
            return loadingWidget();
            break;

          default:
            return builder();
        }
      });
}
