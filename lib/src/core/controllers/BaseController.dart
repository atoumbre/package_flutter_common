import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_common/src/core/controllers/BaseService.dart';
import 'package:softi_common/src/core/services/interfaces/i_loading_service.dart';

enum ControllerStatus { ready, busy, error }

abstract class IBaseController extends GetxController {}

abstract class IBaseBusyController extends IBaseController with TaskManagerControllerMixin {}

mixin TaskManagerControllerMixin on IBaseController {
  ILoadingService get loadingService => Get.find<ILoadingService>();

  final loadingStatus = ControllerStatus.ready.obs;
  final lastResult = Rx<Result<ServiceFailure, dynamic>>(Success(null));

  Future<Result<ServiceFailure, R>> serviceTaskHandler<R>({
    required Future<R> Function() task,
    Future<void> Function(R)? onSuccess,
    Future<void> Function(ServiceFailure)? onFailure,
    bool toggleViewState = false,
    bool showLoading = true,
    String busyMessage = '',
  }) async {
    // Protect
    if (loadingStatus() == ControllerStatus.busy) {
      return Error(ServiceFailure(
        code: 'BUSY_CONTROLLER',
        service: '_INTERNAL_',
      ));
    }

    if (toggleViewState) toggleLoading();
    if (showLoading) await loadingService.showStatus(status: busyMessage);

    try {
      var result = await task();

      if (toggleViewState) toggleIdle();
      if (showLoading) await loadingService.dismiss();
      if (onSuccess != null) await onSuccess(result);

      lastResult(Success(result));
      return Success(result);
      //
    } on ServiceFailure catch (e) {
      if (toggleViewState) toggleIdle();
      if (showLoading) await loadingService.dismiss();
      if (onFailure != null) await onFailure(e);

      lastResult(Error(e));
      return Error(e);
    } catch (e) {
      rethrow;
    } finally {
      if (showLoading) await loadingService.dismiss();
    }
  }

  void changeLoadingStatus(ControllerStatus newStatus) {
    loadingStatus(newStatus);
  }

  void toggleIdle() {
    loadingStatus(ControllerStatus.ready);
  }

  void toggleError() {
    loadingStatus(ControllerStatus.error);
  }

  void toggleLoading() {
    loadingStatus(ControllerStatus.busy);
  }

  bool get isIdle => loadingStatus() == ControllerStatus.ready;
  bool get isErrored => loadingStatus() == ControllerStatus.error;
  bool get isLoding => loadingStatus() == ControllerStatus.busy;
}

abstract class _IBaseLifeCycleController extends IBaseBusyController with WidgetsBindingObserver {}

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

abstract class BaseViewController extends IBaseBusyController {
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
    );
  }

  Future<void> _onViewReady() async {
    await serviceTaskHandler(
      task: () async {
        await onViewReady();
      },
      toggleViewState: true,
      showLoading: false,
      busyMessage: 'Loading ...',
    );
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

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.loadingStatus() == ControllerStatus.error) {
        return errorBuilder(controller);
      }

      if (controller.loadingStatus() == ControllerStatus.busy) {
        return loadingBuilder(controller);
      }

      return builder(controller);
    });
  }
}

extension BaseViewControllerExt on BaseViewController {
  Widget obx<T extends BaseViewController>(
    Widget Function(T) builder, {
    Widget Function(T)? busyBuilder,
    Widget Function(T)? errorBuilder,
  }) {
    return Obx(() {
      if (loadingStatus() == ControllerStatus.error && errorBuilder != null) {
        return errorBuilder(this as T);
      }

      if (loadingStatus() == ControllerStatus.busy && busyBuilder != null) {
        return busyBuilder(this as T);
      }

      return builder(this as T);
    });
  }
}
