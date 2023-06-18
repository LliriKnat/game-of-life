import 'package:game_of_life/screen/map/app_lat_long.dart';
import 'app_location.dart';

class LocationService implements AppLocation {
  final defLocation = const VladivostokLocation();

  @override
  Future<bool> checkPermission() {
    // TODO: implement checkPermission
    throw UnimplementedError();
  }

  @override
  Future<AppLatLong> getCurrentLocation() {
    // TODO: implement getCurrentLocation
    throw UnimplementedError();
  }

  @override
  Future<bool> requestPermission() {
    // TODO: implement requestPermission
    throw UnimplementedError();
  }
}