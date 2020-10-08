import 'dart:async';

import 'package:softi_core_module/softi_core_module.dart';

class DefaultAlertService extends IAlertService {
  Function(AlertRequest, Completer) _showDialogListener;
  Function(AlertRequest, Completer) _showToastListener;

  /// Registers a callback function. Typically to show the dialog
  void registerDialogListener(Function(AlertRequest, Completer) showDialogListener) {
    _showDialogListener = showDialogListener;
  }

  void registerToastListener(void Function(AlertRequest, Completer) showToastListener) {
    _showToastListener = showToastListener;
  }

  /// DIALOGS
  ///
  /// Calls the dialog listener and returns a Future that will wait for dialogComplete.
  Future<AlertResponse> showDialog(
    String title,
    String message, {
    DialogStatus status = DialogStatus.info,
    bool needConfirmation = false,
  }) {
    Completer<AlertResponse> _dialogCompleter = Completer<AlertResponse>();
    _showDialogListener(
      AlertRequest(
        title: title,
        message: message,
        status: status,
        type: needConfirmation ? DialogType.confirmation : DialogType.alert,
      ),
      _dialogCompleter,
    );
    return _dialogCompleter.future;
  }

  Future<AlertResponse> showSuccessDialog(
    String title,
    String message, {
    bool needConfirmation = false,
  }) {
    return showDialog(
      title,
      message,
      status: DialogStatus.success,
      needConfirmation: needConfirmation,
    );
  }

  Future<AlertResponse> showInfoDialog(
    String title,
    String message, {
    bool needConfirmation = false,
  }) {
    return showDialog(
      title,
      message,
      status: DialogStatus.info,
      needConfirmation: needConfirmation,
    );
  }

  Future<AlertResponse> showErrorDialog(
    String title,
    String message, {
    bool needConfirmation = false,
  }) {
    return showDialog(
      title,
      message,
      status: DialogStatus.error,
      needConfirmation: needConfirmation,
    );
  }

  /// TOASTS
  Future<AlertResponse> showToast({
    String title,
    String message,
    DialogStatus status,
  }) {
    Completer<AlertResponse> _toastCompleter;
    _toastCompleter = Completer<AlertResponse>();
    _showToastListener(
        AlertRequest(
          title: title,
          message: message,
          status: status,
          type: null,
        ),
        _toastCompleter);
    return _toastCompleter.future;
  }

  Future<AlertResponse> showSuccessToast(String title, String message) {
    return showToast(title: title, message: message, status: DialogStatus.success);
  }

  Future<AlertResponse> showInfoToast(String title, String message) {
    return showToast(title: title, message: message, status: DialogStatus.info);
  }

  Future<AlertResponse> showErrorToast(String title, String message) {
    return showToast(title: title, message: message, status: DialogStatus.error);
  }

  @override
  void dispose() {}

  @override
  Stream get errorStream => throw UnimplementedError();
}
