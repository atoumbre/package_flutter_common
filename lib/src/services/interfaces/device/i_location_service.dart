import 'package:location/location.dart';
import 'package:softi_common/src/core/base_service.dart';

abstract class ILocationService extends IStoppableService {
  Stream<LocationData> get locationStream;
  LocationData get currentLocation;
}
