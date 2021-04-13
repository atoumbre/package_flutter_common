import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/controllers/TaskHandlerControllerMixin.dart';

abstract class IBaseController extends GetxController {}

abstract class BaseController extends IBaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {}

class BaseViewSettings {}

abstract class BaseViewController extends BaseController {
  Future<void> onViewInit() async {}

  Future<void> onViewReady() async {}

  Future<void> onViewClose() async {}

  Future<void> _onViewInit() async {
    await serviceTaskHandler(
        task: () async {
          await onViewInit();
        },
        toggleViewState: true,
        showLoading: false,
        busyMessage: 'Loading ...',
        completedMessage: 'Loding completed',
        errorMessageBuilder: (error) {
          return '';
        });
  }

  Future<void> _onViewReady() async {
    await serviceTaskHandler(
        task: () async {
          await onViewReady();
        },
        toggleViewState: true,
        showLoading: false,
        busyMessage: 'Loading ...',
        completedMessage: 'Loding completed',
        errorMessageBuilder: (error) {
          return '';
        });
  }

  @override
  void onInit() async {
    await _onViewInit();
    super.onInit();
  }

  @override
  void onReady() async {
    await _onViewReady();
    super.onReady();
  }

  @override
  void onClose() {
    onViewClose();
    super.onClose();
  }

  void navigateBack() => Get.back();
}

abstract class BaseView<T extends BaseViewController> extends StatelessWidget {
  Widget loadingBuilder(T controller) => Center(child: CircularProgressIndicator());
  Widget errorBuilder(T controller) => Center(child: Text('An Error Occurs', style: TextStyle(color: Colors.red)));
  Widget builder(T controller);
  T init();

  String? get tag => null;

  const BaseView({
    Key? key,
  }) : super(key: key);

  T get controller => Get.put<T>(init(), tag: tag);

  // @override
  // Widget build(BuildContext context) {
  //   return GetX<T>(
  //     init: init(),
  //     tag: tag,
  //     builder: (controller) {
  //       if (controller.loadingStatus() == LoadingStatus.error) {
  //         return errorBuilder(controller);
  //       }

  //       if (controller.loadingStatus() == LoadingStatus.loading) {
  //         return loadingBuilder(controller);
  //       }

  //       return builder(controller);
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingStatus() == LoadingStatus.error) {
        return errorBuilder(controller);
      }

      if (controller.loadingStatus() == LoadingStatus.loading) {
        return loadingBuilder(controller);
      }

      return builder(controller);
    });
  }
}
