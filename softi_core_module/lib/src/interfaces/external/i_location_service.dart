import 'package:location/location.dart';
import 'package:softi_core_module/src/interfaces/i_base_service.dart';

abstract class ILocationService extends IBaseStoppableService {
  Stream<LocationData> get locationStream;
  LocationData get currentLocation;
}
