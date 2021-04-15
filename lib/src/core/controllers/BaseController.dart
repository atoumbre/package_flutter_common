import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_common/src/core/controllers/BaseService.dart';
import 'package:softi_common/src/core/services/interfaces/i_loading_service.dart';

enum LoadingStatus { ready, loading, error }

abstract class IBaseController extends GetxController {}

mixin LoadingStatusControllerMixin on IBaseController {
  Rx<LoadingStatus> loadingStatus = LoadingStatus.loading.obs;

  void changeLoadingStatus(LoadingStatus newStatus) {
    loadingStatus(newStatus);
  }

  void toggleIdle() {
    loadingStatus(LoadingStatus.ready);
  }

  void toggleError() {
    loadingStatus(LoadingStatus.error);
  }

  void toggleLoading() {
    loadingStatus(LoadingStatus.loading);
  }

  bool get isIdle => loadingStatus() == LoadingStatus.ready;
  bool get isErrored => loadingStatus() == LoadingStatus.error;
  bool get isLoding => loadingStatus() == LoadingStatus.loading;
}

mixin TaskHandlerControllerMixin on LoadingStatusControllerMixin {
  ILoadingService get loadingService => Get.find<ILoadingService>();

  Future<Result<ServiceFailure, R>> serviceTaskHandler<R>({
    required Future<R> Function() task,
    String completedMessage = '',
    String busyMessage = '',
    String Function(ServiceFailure)? errorMessageBuilder,
    bool showLoading = true,
    bool toggleViewState = false,
  }) async {
    var _errorMessageBuilder = errorMessageBuilder ?? (e) => e.message ?? '';

    if (toggleViewState) toggleLoading();

    try {
      if (showLoading) await loadingService.showStatus(status: busyMessage);

      var result = await task();

      if (showLoading) await loadingService.showSuccess(completedMessage);
      if (toggleViewState) toggleIdle();

      //
      return Success(result);
    } on ServiceFailure catch (e) {
      var errorMessage = _errorMessageBuilder(e);
      if (showLoading) await loadingService.showError(errorMessage);
      if (toggleViewState) toggleIdle();
      return Error(e);
    } catch (e) {
      rethrow;
    } finally {}
  }
}

abstract class _IBaseLifeCycleController extends IBaseController with WidgetsBindingObserver {}

abstract class IBaseLifeCycleController extends _IBaseLifeCycleController with _FullLifeCycleMixin {}

mixin _FullLifeCycleMixin on _IBaseLifeCycleController {
  @mustCallSuper
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance!.addObserver(this);
  }

  @mustCallSuper
  @override
  void onClose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.onClose();
  }

  @mustCallSuper
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        onResumed();
        break;
      case AppLifecycleState.inactive:
        onInactive();
        break;
      case AppLifecycleState.paused:
        onPaused();
        break;
      case AppLifecycleState.detached:
        onDetached();
        break;
    }
  }

  void onResumed();
  void onPaused();
  void onInactive();
  void onDetached();
}

// abstract class BaseLifeCycleController extends IBaseLifeCycleController
//     with LoadingStatusControllerMixin, TaskHandlerControllerMixin {}

// abstract class BaseController extends IBaseController with LoadingStatusControllerMixin, TaskHandlerControllerMixin {}

abstract class BaseViewController extends IBaseController
    with LoadingStatusControllerMixin, TaskHandlerControllerMixin {
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
