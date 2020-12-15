import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:softi_core_module/index.dart';

Future<void> commonSetup() async {
  /// Third party packages initialization
  await GetStorage.init();

  /// Dependencies ingection
  Get.put<ILocalStore>(LocalStore());
}

// class CommonServices {
//   /// Device Service
//   static ILocalStore get store => Get.find();
//   static ILocationService get location => Get.find();
//   // static IMediaPicker get mediaPicker => Get.find();

//   /// App services
//   static INavigationService get nav => Get.find();
//   static DialogService get dialog => Get.find();
//   static SnackbarService get snack => Get.find();
//   // static IAlertService get alert => Get.find();

// }

Future<void> commonInit() async {}
