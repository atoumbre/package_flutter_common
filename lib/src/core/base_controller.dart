import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/controllers/TaskHandlerControllerMixin.dart';

abstract class IBaseController extends GetxController {
  // final triggerRebuild = false.obs; // a trick to trigger rebuild without MixinBuilder
}

abstract class BaseController extends IBaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {
  // final busy = false.obs;
}

abstract class BaseViewController extends BaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {
  Future<void> loadView();
  Future<void>? disposeView() => null;

  Future<void> _loadView() async {
    await controllerTaskHandler(
        task: () async {
          await loadView();
        },
        toggleViewState: true,
        showViewState: false,
        busyMessage: 'Loading ...',
        completedMessage: 'Loding completed',
        rethrowError: true,
        errorHandler: (error) {
          return '';
        });
  }

  @override
  void onInit() async {
    await _loadView();
    super.onInit();
  }

  @override
  void onClose() {
    disposeView();
    super.onClose();
  }
}

abstract class BaseView<T extends BaseViewController> extends StatelessWidget {
  Widget loadingBuilder(T controller) => builder(controller);
  Widget errorBuilder(T controller) => builder(controller);
  Widget builder(T controller);
  T init();

  String get tag;

  const BaseView({
    Key? key,
  }) : super(key: key);

  // T get controller => Get.put<T>(init());

  @override
  Widget build(BuildContext context) {
    return GetX<T>(
      init: init(),
      tag: tag,
      builder: (controller) {
        if (controller.loadingStatus() == LoadingStatus.error) {
          return errorBuilder(controller);
        }

        if (controller.loadingStatus() == LoadingStatus.loading) {
          return loadingBuilder(controller);
        }

        return builder(controller);
      },
    );
  }
}
