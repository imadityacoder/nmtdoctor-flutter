import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:nmt_doctor_app/api/local_data.dart'; // Ensure this contains healthPacks data

// **Standard Cart Item Model**
class HcCartItem {
  final String cardId;
  final String title;
  final String price;
  final String preprice;
  int quantity;

  HcCartItem({
    required this.cardId,
    required this.title,
    required this.price,
    required this.preprice,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'cardId': cardId,
      'title': title,
      'price': price,
      'preprice': preprice,
      'quantity': quantity,
    };
  }

  factory HcCartItem.fromMap(Map<String, dynamic> map) {
    return HcCartItem(
      cardId: map['cardId'],
      title: map['title'],
      price: map['price'],
      preprice: map['preprice'],
      quantity: map['quantity'],
    );
  }
}

// **Custom Test Package Model**
class CartItem extends HcCartItem {
  final List<String> tests;

  CartItem({
    required String cardId,
    required String title,
    required String price,
    required String preprice,
    required this.tests,
    int quantity = 1,
  }) : super(
          cardId: cardId,
          title: title,
          price: price,
          preprice: preprice,
          quantity: quantity,
        );

  @override
  Map<String, dynamic> toMap() {
    return super.toMap()..addAll({'tests': tests});
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cardId: map['cardId'],
      title: map['title'],
      price: map['price'],
      preprice: map['preprice'],
      tests: List<String>.from(map['tests']),
      quantity: map['quantity'],
    );
  }
}

class HcCartProvider extends ChangeNotifier {
  final Map<String, HcCartItem> _items = {};
  List<CartItem> _customHealthPacks = [];

  Map<String, HcCartItem> get items => _items;
  List<CartItem> get customHealthPacks => _customHealthPacks;

  double get totalPrice => _items.values.fold(
        0.0,
        (sum, item) =>
            sum + (double.tryParse(item.price) ?? 0.0) * item.quantity,
      );

  double get pretotal => _items.values.fold(
        0.0,
        (sum, item) =>
            sum + (double.tryParse(item.preprice) ?? 0.0) * item.quantity,
      );

  HcCartProvider() {
    _loadCart();
    _loadCustomHealthPacks();
  }

  void addItem(HcCartItem item) {
    if (_items.containsKey(item.cardId)) {
      _items[item.cardId]!.quantity++;
    } else {
      _items[item.cardId] = item;
    }
    _saveCart();
    notifyListeners();
  }

  void addToCartById(String cardId) {
    final itemData = healthPacks.firstWhere(
      (pack) => pack['cardId'] == cardId,
      orElse: () => {},
    );
    if (itemData.isNotEmpty) {
      final newItem = CartItem.fromMap(itemData);
      addItem(newItem);
    }
  }

  void createCustomPackage() async {
    if (_items.isEmpty) return;

    String packageId = "custom_${DateTime.now().millisecondsSinceEpoch}";
    String packageTitle = "My Package (${_items.length} Tests)";

    double totalPrice = _items.values
        .fold(0.0, (sum, item) => sum + (double.tryParse(item.price) ?? 0.0));
    double totalPrePrice = _items.values.fold(
        0.0, (sum, item) => sum + (double.tryParse(item.preprice) ?? 0.0));

    CartItem customPackage = CartItem(
      cardId: packageId,
      title: packageTitle,
      price: totalPrice.toStringAsFixed(2),
      preprice: totalPrePrice.toStringAsFixed(2),
      tests: _items.keys.toList(),
      quantity: 1,
    );

    _customHealthPacks.add(customPackage);
    await _saveCustomHealthPacks();
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    if (_items.containsKey(id)) {
      _items[id]!.quantity = quantity;
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        _items.values.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList('cart_items', cartJson);
  }

  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart_items');
    if (cartJson != null) {
      _items.clear();
      _items.addEntries(cartJson.map((item) {
        final decodedItem = jsonDecode(item);
        return MapEntry(decodedItem['cardId'], HcCartItem.fromMap(decodedItem));
      }));
    }
    notifyListeners();
  }

  Future<void> _saveCustomHealthPacks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> customPackJson =
        _customHealthPacks.map((pack) => jsonEncode(pack.toMap())).toList();
    await prefs.setStringList('custom_health_packs', customPackJson);
  }

  Future<void> _loadCustomHealthPacks() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? customPackJson = prefs.getStringList('custom_health_packs');
    if (customPackJson != null) {
      _customHealthPacks = customPackJson
          .map((pack) => CartItem.fromMap(jsonDecode(pack)))
          .toList();
    }
  }

  void removeCustomPack(String id) {
    _customHealthPacks.removeWhere((pack) => pack.cardId == id);
    notifyListeners();
  }
}
