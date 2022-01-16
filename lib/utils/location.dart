import 'package:geolocator/geolocator.dart';

class Location {
  late double lat;
  late double lon;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.low)
          .timeout(Duration(seconds: 3));
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      throw 'Something geolocation wrong: $e';
    }
  }
}
