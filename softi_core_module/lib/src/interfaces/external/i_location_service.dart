import 'package:location/location.dart';

abstract class ILocationService {
  Stream<LocationData> get locationStream;
  LocationData get currentLocation;
}

// class UserLocation {
//   final double latitude;
//   final double longitude;
//   final double accuracy;

//   UserLocation({this.accuracy, this.latitude, this.longitude});
// }
