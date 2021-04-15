import 'package:softi_common/src/core/controllers/BaseService.dart';

abstract class ILoadingService extends IBaseService {
  Future<void> dismiss();

  Future<void> showStatus({String? status, bool? dismissOnTap});

  Future<void> showInfo(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showError(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showSuccess(String status, {Duration? duration, bool? dismissOnTap});

  Future<void> showToast(String status, {Duration? duration, bool? dismissOnTap});
}

// class LoadingServiceExeption extends ServiceException {
//   LoadingServiceExeption({
//     required String code,
//     String? message,
//   }) : super(
//           service: 'Loading',
//           code: code,
//           message: message,
//         );
// }
