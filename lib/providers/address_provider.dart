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

  Address({
    required this.id,
    required this.title,
    required this.street,
    required this.city,
    required this.state,
    required this.pincode,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'street': street,
      'city': city,
      'state': state,
      'pincode': pincode,
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
      Address newAddress = Address(
        id: address.id,
        title: address.title,
        street: address.street,
        city: address.city,
        state: address.state,
        pincode: address.pincode,
      );

      await _firestore.collection('addresses').doc(_uid).set(
        {newAddress.id: newAddress.toMap()},
        SetOptions(merge: true),
      );

      notifyListeners();
    } catch (e) {
      Exception(e);
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

  Future<void> updateAddress(String addressId, Address updatedAddress) async {
    if (_uid.isEmpty) return;

    try {
      await _firestore.collection('addresses').doc(_uid).update({
        addressId: updatedAddress.toMap(),
      });

      notifyListeners();
    } catch (e) {
      print("Error updating address: $e");
    }
  }

  // Delete: Remove an address
  Future<void> deleteAddress(String addressId) async {
    if (_uid.isEmpty) return;

    try {
      await _firestore.collection('addresses').doc(_uid).update({
        addressId: FieldValue.delete(),
      });

      notifyListeners();
    } catch (e) {
      print("Error deleting address: $e");
    }
  }
}
