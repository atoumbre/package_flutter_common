import 'package:get/get.dart';
import 'package:softi_common/src/core/base_controller.dart';
import 'package:softi_common/src/core/interfaces/i_loading_service.dart';

mixin TaskHandlerMixin on IBaseController {
  ILoadingService get loadingService => Get.find<ILoadingService>();

  Future<void> controllerTaskHandler({
    Future<String> Function() task,
    String Function(dynamic) errorHandler,
    int messageType = 0,
    String loadingMessage = '',
    bool showStatus = true,
    bool toggleBusyState = true,
    bool rethrowError = true,
  }) async {
    if (toggleBusyState) busy(true);

    try {
      if (showStatus) await loadingService.showStatus(status: loadingMessage);
      var message = await task();
      if (messageType == 0) {
        if (showStatus) await loadingService.showSuccess(message);
      } else {
        if (showStatus) await loadingService.showInfo(message);
      }
    } catch (e) {
      var message = errorHandler(e);
      if (showStatus) await loadingService.showError(message);
      if (rethrowError) rethrow;
    } finally {
      if (toggleBusyState) busy(false);
    }
  }
}
