import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'location_picker_model.dart';
import 'location_picker_repository.dart';

class LocationPickerController extends ChangeNotifier {
  final repository = LocationPickerRepository();

  final MapController mapController = MapController();

  bool loading = false;

  LatLng? currentLocation;

  LatLng? selectedLocation;

  String address = "";

  Future<void> initialize() async {
    loading = true;
    notifyListeners();

    try {
      final permission = await repository.checkPermission();

      if (permission == LocationPermission.denied) {
        loading = false;
        notifyListeners();
        return;
      }

      if (permission == LocationPermission.deniedForever) {
        await Geolocator.openAppSettings();

        loading = false;
        notifyListeners();
        return;
      }

      final position = await repository.getCurrentLocation();

      currentLocation = LatLng(position.latitude, position.longitude);

      selectedLocation = currentLocation;

      address = await repository.getAddress(
        position.latitude,
        position.longitude,
      );
    } catch (e) {
      debugPrint("Location Error: $e");
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> moveToCurrentLocation() async {
    Position position = await repository.getCurrentLocation();

    currentLocation = LatLng(position.latitude, position.longitude);

    selectedLocation = currentLocation;

    mapController.move(currentLocation!, 17);

    address = await repository.getAddress(
      position.latitude,
      position.longitude,
    );

    notifyListeners();
  }

  Future<void> onCameraMoved(LatLng center) async {
    selectedLocation = center;

    address = await repository.getAddress(center.latitude, center.longitude);

    notifyListeners();
  }

  LocationPickerModel getSelectedLocation() {
    return LocationPickerModel(
      latitude: selectedLocation!.latitude,
      longitude: selectedLocation!.longitude,
      address: address,
    );
  }
}
