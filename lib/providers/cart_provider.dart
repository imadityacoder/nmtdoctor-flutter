import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartItem {
  final String cardId;
  final String title;
  final String price;
  final String preprice;
  int quantity;

  CartItem({
    required this.cardId,
    required this.title,
    required this.price,
    required this.preprice,
    this.quantity = 1,
  });

  // Convert CartItem to Map (for saving)
  Map<String, dynamic> toMap() {
    return {
      'cardId': cardId,
      'title': title,
      'price': price,
      'preprice': preprice,
      'quantity': quantity,
    };
  }

  // Create CartItem from Map (for loading)
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      cardId: map['cardId'],
      title: map['title'],
      price: map['price'],
      preprice: map['preprice'],
      quantity: map['quantity'],
    );
  }
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get total => _items.fold(
      0.0,
      (sum, item) =>
          sum + (double.tryParse(item.price) ?? 0.0) * (item.quantity));

  double get pretotal => _items.fold(
      0.0,
      (sum, item) =>
          sum + (double.tryParse(item.preprice) ?? 0.0) * (item.quantity));

  double getProgressiveTotal(int index) {
    double runningTotal = 0.0;
    for (int i = 0; i <= index; i++) {
      runningTotal +=
          (double.tryParse(_items[i].price) ?? 0.0) * (_items[i].quantity);
    }
    return runningTotal;
  }

  CartProvider() {
    _loadCart();
  }

  void addItem(CartItem item) {
    final existingItemIndex = _items.indexWhere((e) => e.title == item.title);

    if (existingItemIndex != -1) {
      _items[existingItemIndex].quantity++;
    } else {
      _items.add(item);
    }

    _saveCart(); // Save to SharedPreferences
    notifyListeners();
  }

  void removeItemByTitle(String title) {
    final existingItemIndex = _items.indexWhere((item) => item.title == title);

    if (existingItemIndex != -1) {
      if (_items[existingItemIndex].quantity > 1) {
        _items[existingItemIndex].quantity--;
      } else {
        _items.removeAt(existingItemIndex);
      }
    }

    _saveCart(); // Save to SharedPreferences
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    _saveCart(); // Save to SharedPreferences
    notifyListeners();
  }

  // Save cart data to SharedPreferences
  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> cartJson =
        _items.map((item) => jsonEncode(item.toMap())).toList();
    await prefs.setStringList('cart_items', cartJson);
  }

  // Load cart data from SharedPreferences
  Future<void> _loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? cartJson = prefs.getStringList('cart_items');

    if (cartJson != null) {
      _items.clear();
      _items.addAll(cartJson.map((item) => CartItem.fromMap(jsonDecode(item))));
      notifyListeners();
    }
  }
}
