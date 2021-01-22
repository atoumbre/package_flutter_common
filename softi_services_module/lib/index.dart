import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:softi_services_module/index.dart';
import 'package:softi_services_module/src/interfaces/device/i_location_service.dart';
import 'package:softi_services_module/src/services/device/location_service.dart';
import 'package:softi_core_module/core.dart';
import 'package:stacked_services/stacked_services.dart' show DialogService, SnackbarService;

export 'package:softi_services_module/dep.dart';
export 'package:softi_services_module/src/class/i_media_asset.dart';
export 'package:softi_services_module/src/components/BackgroundServiceManager.dart';
export 'package:softi_services_module/src/components/HideKeyboardManager.dart';
export 'package:softi_services_module/src/components/ListItemCreationAware.dart';
export 'package:softi_services_module/src/components/StateFullWrapper.dart';
export 'package:softi_services_module/src/interfaces/app/i_alert_service.dart';
export 'package:softi_services_module/src/interfaces/app/i_loading_service.dart';
export 'package:softi_services_module/src/interfaces/device/i_connectivity_service.dart';
export 'package:softi_services_module/src/interfaces/device/i_location_service.dart';
export 'package:softi_services_module/src/interfaces/device/i_media_picker.dart';
export 'package:softi_services_module/src/interfaces/external/i_dynamiclink_service.dart';
export 'package:softi_services_module/src/interfaces/external/i_remote_config.dart';
export 'package:softi_services_module/src/interfaces/external/i_remote_storage.dart';
export 'package:softi_services_module/src/services/app/alert_service.dart';
export 'package:softi_services_module/src/services/app/loading_service.dart';
export 'package:softi_services_module/src/services/device/location_service.dart';
export 'package:softi_services_module/src/services/device/media_picker.dart';

Future<void> commonSetup() async {
  ///
  await GetStorage.init();

  /// Device services
  Get.put<ILocationService>(LocationService());
  Get.put<ILocalStore>(LocalStore());

  /// App services
  // Get.put<INavigationService>(NavigationService());
  Get.put<DialogService>(DialogService());
  Get.put<SnackbarService>(SnackbarService());
}

class CommonServices {
  /// Device Service
  static ILocalStore get store => Get.find();
  static ILocationService get location => Get.find();
  // static IMediaPicker get mediaPicker => Get.find();

  /// App services
  // static INavigationService get nav => Get.find();
  static DialogService get dialog => Get.find();
  static SnackbarService get snack => Get.find();
  // static IAlertService get alert => Get.find();

}
