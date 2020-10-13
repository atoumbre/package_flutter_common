import 'dart:async';

import 'package:location/location.dart';
import 'package:softi_core_module/softi_core_module.dart';

class LocationService extends ILocationService {
  StreamSubscription<LocationData> _streamSubscription;

  // Location Available
  bool locationAvailable;

  // Keep track of current Location
  LocationData _currentLocation;

  // Continuously emit location updates
  Stream<LocationData> _locationStream; //= StreamController<UserLocation>.broadcast();

  Location location = Location();

  LocationService() {
    location.requestPermission().then((granted) {
      _locationStream = location.onLocationChanged;
      if (granted == PermissionStatus.granted) {
        locationAvailable = true;
      } else {
        locationAvailable = false;
      }
    });
  }

  Stream<LocationData> get locationStream => _locationStream;
  LocationData get currentLocation => _currentLocation;

  @override
  VoidAsyncCallback get startCallback => () async {
        _streamSubscription = _locationStream.listen((locationData) {
          _currentLocation = locationData;
          locationAvailable = true;
          print(_currentLocation.toString());
          return locationData;
        });
      };

  @override
  VoidAsyncCallback get stopCallback => () async {
        _streamSubscription?.cancel();
      };
}