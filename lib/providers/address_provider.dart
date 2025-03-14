import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

// address_model.dart
class Address {
  String id;
  String title;
  String street;
  String city;
  String state;
  String pincode;
  double latitude;
  double longitude;

  Address({
    required this.id,
    required this.title,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
    this.latitude = 0.0, // Will be auto-updated
    this.longitude = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  static Address fromMap(String id, Map<String, dynamic> map) {
    return Address(
      id: id,
      title: map['title'],
      street: map['street'],
      city: map['city'],
      state: map['state'],
      pincode: map['pincode'],
      latitude: map['latitude'] ?? 0.0,
      longitude: map['longitude'] ?? 0.0,
    );
  }
}

class AddressProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  // Get current location
  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
          "Location permissions are permanently denied. Enable them in settings.");
    }

    return await Geolocator.getCurrentPosition();
  }

  // Add a new address (Auto-fetch location)
  Future<void> addAddress(Address address) async {
    if (_uid.isEmpty) return;

    try {
      Position position = await _getCurrentLocation();
      Address newAddress = Address(
        id: address.id,
        title: address.title,
        street: address.street,
        city: address.city,
        state: address.state,
        pincode: address.pincode,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      await _firestore.collection('addresses').doc(_uid).set(
        {newAddress.id: newAddress.toMap()},
        SetOptions(merge: true),
      );

      notifyListeners();
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  
  Stream<List<Address>> getAddresses() {
    if (_uid.isEmpty) return const Stream.empty();

    return _firestore.collection('addresses').doc(_uid).snapshots().map((doc) {
      if (!doc.exists || doc.data() == null) return [];

      return doc
          .data()!
          .entries
          .map((entry) => Address.fromMap(entry.key, entry.value))
          .toList();
    });
  }

  Future<void> deleteAddress(String addressId) async {
    if (_uid.isEmpty) return;

    await _firestore.collection('addresses').doc(_uid).update({
      addressId: FieldValue.delete(),
    });

    notifyListeners();
  }
}