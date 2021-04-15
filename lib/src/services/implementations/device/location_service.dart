import 'dart:async';

import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:softi_common/src/services/interfaces/device/i_location_service.dart';

class LocationService extends ILocationService {
  // Location Available
  bool? locationAvailable;
  late Rxn<LocationData> _locationStream; //= StreamController<UserLocation>.broadcast();

  Location location = Location();

  @override
  Stream<LocationData?> get locationStream => _locationStream.stream;

  @override
  LocationData? get currentLocation => _locationStream();

  @override
  Future<void> startCallback() async {
    _locationStream = Rxn<LocationData>();

    var granted = await location.requestPermission();

    _locationStream
      ..bindStream(location.onLocationChanged)
      ..listen((data) => print('New location ${data.toString()}'));

    if (granted == PermissionStatus.granted) {
      locationAvailable = true;
    } else {
      locationAvailable = false;
    }
  }

  @override
  Future<void> stopCallback() async {
    _locationStream.close();
  }
}
