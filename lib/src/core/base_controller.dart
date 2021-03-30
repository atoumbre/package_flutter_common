import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/controllers/TaskHandlerControllerMixin.dart';

abstract class IBaseController extends GetxController {
  // final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder
}

class BaseController extends IBaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {
  final busy = false.obs;
}

class BaseViewController extends BaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {}

abstract class BaseView<T extends BaseViewController> extends StatelessWidget {
  Widget loadingBuilder(T controller) => builder(controller);
  Widget errorBuilder(T controller) => builder(controller);
  Widget builder(T controller);
  T init();

  final bool reactive;

  const BaseView(
    this.reactive, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<T>(
      init: init(),
      builder: (controller) {
        if (controller.loadingStatus() == LoadingStatus.error && errorBuilder != null) {
          return errorBuilder(controller);
        }

        if (controller.loadingStatus() == LoadingStatus.loading && loadingBuilder != null) {
          return loadingBuilder(controller);
        }

        return builder(controller);
      },
    );
  }
}

class TestView extends BaseView<BaseViewController> {
  TestView(
    bool reactive,
    Key key,
  ) : super(reactive, key: key);

  @override
  BaseViewController init() => BaseViewController();

  @override
  Widget builder(BaseViewController controller) => Container();
}
