import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String price;

  CartItem({required this.title, required this.price});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = []; // Cart items list

  List<CartItem> get items => _items; // Getter for items

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners(); // Notify widgets listening to this provider
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
