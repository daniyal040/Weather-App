import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      // Ensure location services are enabled
      if (!await Geolocator.isLocationServiceEnabled()) {
        throw Exception('Location services are disabled.');
      }

      // Request permissions if needed
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied.');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low, // battery friendly
      );

      latitude = position.latitude;
      longitude = position.longitude;
      print('📍 Current Location: $latitude, $longitude');
    } catch (e) {
      print('⚠ Error getting location: $e');

      // Fallback coordinates (Karachi)
      latitude = 24.8607;
      longitude = 67.0011;
    }
  }
}
