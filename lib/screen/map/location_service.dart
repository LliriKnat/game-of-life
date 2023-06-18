import 'package:game_of_life/screen/map/app_lat_long.dart';
import 'package:geolocator/geolocator.dart';
import 'app_location.dart';

class LocationService implements AppLocation {
  final defLocation = const VladivostokLocation();

  @override
  Future<bool> checkPermission() {
    return Geolocator.checkPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }

  @override
  Future<AppLatLong> getCurrentLocation() async {
    return Geolocator.getCurrentPosition().then((value) {
      return AppLatLong(lat: value.latitude, long: value.longitude);
    }).catchError(
          (_) => defLocation, // if error we show Vdk coordinates
    );
  }

  @override
  Future<bool> requestPermission() { // if user allowed access to geopos return true, else false
    return Geolocator.requestPermission()
        .then((value) =>
    value == LocationPermission.always ||
        value == LocationPermission.whileInUse)
        .catchError((_) => false);
  }
}