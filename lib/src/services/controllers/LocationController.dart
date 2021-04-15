import 'package:location/location.dart';
import 'package:softi_common/services.dart';
import 'package:softi_common/src/core/controllers/BaseController.dart';
import 'package:get/get.dart';

// enum LoadingStatus { idle, loading, error }

mixin LocationControllerMixin on IBaseController {
  ILocationService locationService = Get.find<ILocationService>();

  Rxn<LocationData?> locationData = Rxn<LocationData?>();

  void initConnectivityMonitoring() {
    locationData.bindStream(locationService.locationStream);
  }
}

class LocationController extends IBaseController with LocationControllerMixin {
  @override
  final ILocationService locationService;

  LocationController(this.locationService);
}
