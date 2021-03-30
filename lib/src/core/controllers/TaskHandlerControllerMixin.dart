import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/interfaces/i_loading_service.dart';

mixin TaskHandlerControllerMixin on LoadingStatusControllerMixin {
  ILoadingService get loadingService => Get.find<ILoadingService>();

  Future<void> controllerTaskHandler({
    @required Future<void> Function() task,
    String Function(dynamic) errorHandler,
    String loadingMessage = '',
    String idleMessage = '',
    bool showViewState = true,
    bool toggleViewState = true,
    bool rethrowError = true,
  }) async {
    var _errorHandler = errorHandler ?? (e) => 'An Error Occures';

    if (toggleViewState) toggleLoading();
    try {
      if (showViewState) await loadingService.showStatus(status: loadingMessage);

      await task();

      if (showViewState) await loadingService.showSuccess(idleMessage);
      if (toggleViewState) toggleIdle();
    } catch (e) {
      var errorMessage = _errorHandler(e);

      if (showViewState) await loadingService.showError(errorMessage);
      if (toggleViewState) toggleIdle();

      if (rethrowError) rethrow;
    } finally {}
  }
}
