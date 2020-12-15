import 'package:softi_core_module/index.dart';

abstract class ILoadingService extends IBaseService {
  Future<void> dismiss();

  Future<void> showStatus({String status, bool dismissOnTap});

  Future<void> showInfo(String status, {Duration duration, bool dismissOnTap});

  Future<void> showError(String status, {Duration duration, bool dismissOnTap});

  Future<void> showSuccess(String status, {Duration duration, bool dismissOnTap});
}

class LoadingServiceExeption extends IBaseServiceException {
  LoadingServiceExeption({
    String service,
    String code,
    String message,
  }) : super(
          code: code,
          // message: message,
          service: service,
        );
}
