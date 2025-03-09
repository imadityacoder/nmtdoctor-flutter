import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  String _location = "Fetching location...";
  String get location => _location;

  LocationProvider() {
    displayLocation();
  }

  Future<Position?> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      locationSettings: AndroidSettings(),
    );
  }

  Future<void> displayLocation() async {
    Position? position = await getLocation();
    if (position == null) {
      _location = "Location services are disabled or permission denied.";
      notifyListeners();
      return;
    }

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      _location = "${place.name}, ${place.locality} - ${place.postalCode}";
    } catch (e) {
      _location = "Failed to fetch address";
    }

    notifyListeners();
  }
}
