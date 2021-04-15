import 'package:location/location.dart';
import 'package:softi_common/src/core/controllers/BaseService.dart';

abstract class ILocationService extends IStoppableService {
  Stream<LocationData?> get locationStream;
  LocationData? get currentLocation;
}
