import 'package:flutter/material.dart';

class CartItem {
  final String title;
  final String price;
  final String preprice;

  CartItem({required this.title, required this.price, required this.preprice});
}

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = []; // Cart items list

  List<CartItem> get items => _items; // Getter for items

  double get total =>
      _items.fold(0.0, (sum, item) => sum + double.parse(item.price));
  double get pretotal =>
      _items.fold(0.0, (sum, item) => sum + double.parse(item.preprice));

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners(); // Notify widgets listening to this provider
  }

  void removeItemByTitle(String title) {
    _items.removeWhere((item) => item.title == title);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
