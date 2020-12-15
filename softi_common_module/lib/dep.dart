import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:softi_common_module/index.dart';
import 'package:softi_common_module/src/interfaces/device/i_location_service.dart';
import 'package:softi_common_module/src/services/base/location_service.dart';
import 'package:softi_common_module/src/services/base/navigation_service.dart';
import 'package:softi_core_module/index.dart';
import 'package:stacked_services/stacked_services.dart' show DialogService, SnackbarService;

Future<void> commonSetup() async {
  ///
  await GetStorage.init();

  /// Device services
  Get.put<ILocationService>(LocationService());
  Get.put<ILocalStore>(LocalStore());

  /// App services
  Get.put<INavigationService>(NavigationService());
  Get.put<DialogService>(DialogService());
  Get.put<SnackbarService>(SnackbarService());
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

// Future<void> commonDependenciesInit() async {}
