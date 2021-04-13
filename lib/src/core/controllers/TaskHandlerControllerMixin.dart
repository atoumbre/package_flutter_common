import 'package:get/get.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:softi_common/src/core/BaseService.dart';
import 'package:softi_common/src/core/controllers/LoadingStateControllerMixin.dart';
import 'package:softi_common/src/core/services/interfaces/i_loading_service.dart';

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
