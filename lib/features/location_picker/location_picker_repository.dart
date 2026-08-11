import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationPickerRepository {
  Future<LocationPermission> checkPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw Exception("Location services are disabled");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  Future<Position> getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }

  Future<String> getAddress(double latitude, double longitude) async {
    final places = await placemarkFromCoordinates(latitude, longitude);

    if (places.isEmpty) return "";

    final place = places.first;

    return [
      place.name,
      place.street,
      place.subLocality,
      place.locality,
      place.postalCode,
    ].where((e) => e != null && e.isNotEmpty).join(", ");
  }
}
