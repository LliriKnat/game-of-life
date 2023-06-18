// Latitude and Longitude for app
class AppLatLong {
  final double lat;
  final double long;

  const AppLatLong({
    required this.lat,
    required this.long,
  });
}

// If can't get current location, show Vladivostok
class VladivostokLocation extends AppLatLong {
  const VladivostokLocation({
    super.lat = 43.119809, // super - calls the constructor
    super.long = 131.886924,
  });
}