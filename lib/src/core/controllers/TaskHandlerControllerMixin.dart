import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/interfaces/i_loading_service.dart';

mixin TaskHandlerControllerMixin on LoadingStatusControllerMixin {
  ILoadingService get loadingService => Get.find<ILoadingService>();

  Future<void> controllerTaskHandler({
    @required Future<String> Function() task,
    @required String Function(dynamic) errorHandler,
    int messageType = 1,
    bool showStatus = true,
    String loadingMessage = '',
    bool toggleBusyState = true,
    bool rethrowError = true,
  }) async {
    if (toggleBusyState) toggleLoading();
    try {
      if (showStatus) await loadingService.showStatus(status: loadingMessage);
      var message = await task();
      if (messageType == 0) {
        if (showStatus) await loadingService.showSuccess(message);
      } else {
        if (showStatus) await loadingService.showInfo(message);
      }
      if (toggleBusyState) toggleIdle();
    } catch (e) {
      var message = errorHandler(e);
      if (toggleBusyState) toggleIdle();
      if (showStatus) await loadingService.showError(message);
      if (rethrowError) rethrow;
    } finally {
      // if (toggleBusyState) busy(false);
    }
  }
}
