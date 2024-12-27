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

  double totalCalculate() {
    double total = _items.fold(0.0, (sum, item) => sum + int.parse(item.price));
    notifyListeners();
    return total; // Assuming you have a `_total` variable to store the total.
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
