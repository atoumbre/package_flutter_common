import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'package:softi_common_module/softi_common_module.dart';
import 'package:softi_core_module/softi_core_module.dart';
import 'package:stacked_services/stacked_services.dart' show DialogService, SnackbarService;

Future<void> commonDependenciesSetup() async {
  Get.put<Logger>(Logger(printer: PrettyPrinter()));
  Get.put<Logger>(Logger(printer: PrettyPrinter()), tag: 'NoStack');

  /// Third party lib initialization
  await Future.wait([
    GetStorage.init(),
  ]);

  /// Device services
  Get.put<ILocationService>(LocationService());
  Get.put<ILocalStore>(DefaultLocalStore());
  // Get.put<IMediaPicker>(MediaPicker());

  /// App services
  Get.put<INavigationService>(NavigationService());
  Get.put<DialogService>(DialogService());
  Get.put<SnackbarService>(SnackbarService());
  // Get.put<IAlertService>(DefaultAlertService());
}

class CommonServices {
  /// Device Service
  static ILocalStore get store => Get.find();
  static ILocationService get location => Get.find();
  // static IMediaPicker get mediaPicker => Get.find();

  /// App services
  static INavigationService get nav => Get.find();
  static DialogService get dialog => Get.find();
  static SnackbarService get snack => Get.find();
  // static IAlertService get alert => Get.find();

}

Future<void> commonStartupLogic() async {}
