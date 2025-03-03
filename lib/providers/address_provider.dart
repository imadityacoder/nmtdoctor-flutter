import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as models;
import 'package:nmt_doctor_app/main.dart';

// Address Model
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
    this.latitude = 0.0,
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

// Address Provider using Appwrite & Provider
class AddressProvider extends ChangeNotifier {
  final Databases _database;
  final Account _account;

  // Initialize database and collection IDs locally
  static const String _databaseId = "67bd478e001b531435c6";
  static const String _collectionId = "67beb27600202e9b9d4d";

  AddressProvider()
      : _database = Databases(client),
        _account = Account(client);

  Future<String?> _getUserId() async {
    try {
      models.User user = await _account.get();
      return user.$id;
    } catch (e) {
      print("Error fetching user: $e");
      return null;
    }
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permissions are denied.");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permissions are permanently denied.");
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> addAddress(Address address) async {
    String? userId = await _getUserId();
    if (userId == null) return;

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

      await _database.createDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: newAddress.id,
        data: newAddress.toMap(),
        permissions: [
          Permission.read(Role.user(userId)),
          Permission.write(Role.user(userId)),
        ],
      );

      notifyListeners();
    } catch (e) {
      print("Error adding address: $e");
    }
  }

  Future<List<Address>> getAddresses() async {
    String? userId = await _getUserId();
    if (userId == null) return [];

    try {
      models.DocumentList result = await _database.listDocuments(
        databaseId: _databaseId,
        collectionId: _collectionId,
      );

      return result.documents
          .map((doc) => Address.fromMap(doc.$id, doc.data))
          .toList();
    } catch (e) {
      print("Error fetching addresses: $e");
      return [];
    }
  }

  Future<void> deleteAddress(String addressId) async {
    try {
      await _database.deleteDocument(
        databaseId: _databaseId,
        collectionId: _collectionId,
        documentId: addressId,
      );
      notifyListeners();
    } catch (e) {
      print("Error deleting address: $e");
    }
  }
}
