import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationProvider with ChangeNotifier {
  String _location = "Fetching location...";
  String get location => _location;

  LocationProvider() {
    fetchLocation();
  }

  /// **Function to request location permissions & enable services**
  Future<void> requestLocation(BuildContext context) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _location = "Location permission denied.";
        notifyListeners();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Location Permission Required"),
          content: const Text(
              "Location access is permanently denied. Enable it from settings."),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await Geolocator.openAppSettings();
              },
              child: const Text("Open Settings"),
            ),
          ],
        ),
      );
      return;
    }

    fetchLocation(); // Fetch location after getting permission
  }

  /// **Function to fetch current location & get address**
  Future<void> fetchLocation() async {
    _location = "Fetching location...";
    notifyListeners();

    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        _location =
            "${place.subLocality}, ${place.locality} - ${place.postalCode}";
      } else {
        _location = "Unable to retrieve address.";
      }
    } catch (e) {
      _location = "Error: ${e.toString()}";
    }

    notifyListeners();
  }
}
