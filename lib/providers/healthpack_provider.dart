import 'package:flutter/material.dart';

class HealthpackProvider extends ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggleExpand() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
