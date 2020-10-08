import 'dart:async';

import 'package:location/location.dart';
import 'package:softi_core_module/softi_core_module.dart';

class LocationService extends ILocationService {
  // Location Available
  bool locationAvailable;

  // Keep track of current Location
  LocationData _currentLocation;

  // Continuously emit location updates
  Stream<LocationData> _locationStream; //= StreamController<UserLocation>.broadcast();

  Location location = Location();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        _locationStream = location.onLocationChanged.map((locationData) {
          _currentLocation = locationData;
          locationAvailable = true;
          return locationData;
        });
      } else {
        locationAvailable = false;
      }
    });
  }

  Stream<LocationData> get locationStream => _locationStream;
  LocationData get currentLocation => _currentLocation;

  @override
  Future<void> start() {
    // TODO: implement start
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  // Future<LocationData> getLocation() async {
  //   try {
  //     var userLocation = await location.getLocation();
  //     _currentLocation = UserLocation(
  //       latitude: userLocation.latitude,
  //       longitude: userLocation.longitude,
  //     );
  //   } catch (e) {
  //     print('Could not get the location: $e');
  //   }

  //   return _currentLocation;
  // }
}
