import 'package:location/location.dart';
import 'package:softi_core_module/core.dart';

abstract class ILocationService extends IStoppableService {
  Stream<LocationData> get locationStream;
  LocationData get currentLocation;
}
