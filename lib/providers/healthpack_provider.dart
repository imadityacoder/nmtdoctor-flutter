import 'package:flutter/material.dart';

class HealthpackProvider extends ChangeNotifier {
  String? _expandedCardId;

  String? get expandedCardId => _expandedCardId;

  void toggleCard(String cardId) {
    if (_expandedCardId == cardId) {
      _expandedCardId = null; // Collapse if already expanded
    } else {
      _expandedCardId = cardId; // Expand the tapped card
    }
    notifyListeners();
  }
}
