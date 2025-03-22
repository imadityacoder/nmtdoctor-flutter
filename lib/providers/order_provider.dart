import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nmt_doctor_app/providers/address_provider.dart';
import 'package:nmt_doctor_app/providers/family_provider.dart';

class OrderItem {
  final String orderId;
  final String title;
  final String totalPrice;
  final List<Map<String, dynamic>> items;
  final Map<String, dynamic> user;
  final Address address;
  final FamilyMember member;
  final DateTime collectionDateTime;
  final DateTime orderDate;
  final String userId;
  final String paymentType;

  OrderItem({
    required this.orderId,
    required this.title,
    required this.totalPrice,
    required this.items,
    required this.user,
    required this.address,
    required this.member,
    required this.collectionDateTime,
    required this.orderDate,
    required this.userId,
    required this.paymentType,
  });

  // Convert to Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      "orderId": orderId,
      "title": title,
      "totalPrice": totalPrice,
      "items": items,
      'user': user,
      "address": address,
      "member": member,
      "collectionDateTime": collectionDateTime.toIso8601String(), // User input
      "orderDate": orderDate.toIso8601String(), // Auto-generated
      "userId": userId,
      'paymentType': paymentType, // Used to filter orders by user
    };
  }
}

class OrderProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _title;
  String? _totalPrice;
  List<Map<String, dynamic>> _items = [];
  Map<String, dynamic>? _user;
  Address? _address;
  FamilyMember? _member;
  DateTime? _collectionDateTime;
  String? _paymentType;

  // Getters
  String? get title => _title;
  String? get totalPrice => _totalPrice;
  List<Map<String, dynamic>> get items => _items;
  Map<String, dynamic>? get user => _user;
  Address? get address => _address;
  FamilyMember? get member => _member;
  DateTime? get collectionDateTime => _collectionDateTime;
  String? get paymentType => _paymentType;

  // Setters
  void setTestPackage({
    required String title,
    required String totalPrice,
    required List<Map<String, dynamic>> items,
  }) {
    _title = title;
    _totalPrice = totalPrice;
    _items = List.from(items);
    debugPrint("$title $totalPrice $items");
    notifyListeners();
  }

  void setUserDetails({
    required Map<String, dynamic> user,
  }) {
    _user = user;
    debugPrint("$user");
    notifyListeners();
  }

  void setAddress(Address address) {
    _address = address;
    debugPrint("${address.toMap()}");
    notifyListeners();
  }

  void setMember(FamilyMember member) {
    _member = member;
    debugPrint("${member.toMap()}");
    notifyListeners();
  }

  void setPaymentType(String paymentType) {
    _paymentType = paymentType;
    debugPrint(paymentType);
    notifyListeners();
  }

  void setCollectionDateTime(DateTime dateTime) {
    _collectionDateTime = dateTime;
    debugPrint("$dateTime"); // User-selected date
    notifyListeners();
  }

  final List<OrderItem> _orders = [];
  List<OrderItem> get orders => _orders;

  Future<void> confirmOrder(String userId) async {
    if (_title == null ||
        _totalPrice == null ||
        _items.isEmpty ||
        _user == null ||
        _address == null ||
        _member == null ||
        _collectionDateTime == null ||
        paymentType == null) {
      debugPrint("❌ Error: Cannot confirm order. Some fields are missing.");
      return;
    }

    final newOrder = OrderItem(
      orderId: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _title!,
      totalPrice: _totalPrice!,
      items: List.from(_items),
      user: _user!,
      address: _address!,
      member: _member!,
      collectionDateTime: _collectionDateTime!, // User-selected datetime
      orderDate: DateTime.now(), // Auto-generated
      userId: userId,
      paymentType: paymentType!, // Store user ID with the order
    );

    _orders.insert(0, newOrder);
    debugPrint("✅ Order Confirmed: $newOrder");

    // 🔥 Save to Firebase in "orders" collection (No subcollection)
    try {
      await _firestore
          .collection("orders")
          .doc(newOrder.orderId)
          .set(newOrder.toMap());
      debugPrint("✅ Order saved to Firebase!");
      // Reset stored data after confirming order
      _title = null;
      _totalPrice = null;
      _items.clear();
      _address = null;
      _member = null;
      _collectionDateTime = null;
      _paymentType = null;

      notifyListeners();
    } catch (e) {
      debugPrint("❌ Error saving order to Firebase: $e");
    }
  }

  /// Returns the selected package details as a Map
  Map<String, dynamic>? getPackageDetails() {
    if (_title == null || _totalPrice == null || _items.isEmpty) {
      debugPrint("⚠️ No package details available!");
      return null;
    }

    return {
      "title": _title!,
      "totalPrice": _totalPrice!,
      "items": List.from(_items),
    };
  }
}
