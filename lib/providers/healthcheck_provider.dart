import 'package:flutter/material.dart';

class SearchProvider extends ChangeNotifier {
  String _query = ''; // Ensure a default value to avoid null errors

  String get query => _query;

  void updateQuery(String newQuery) {
    _query = newQuery;
    notifyListeners();
  }

  void clearQuery() {
    _query = '';
    notifyListeners();
  }
}
