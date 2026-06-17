import 'package:flutter/material.dart';

class MyOpenIssueProvider with ChangeNotifier {
  bool _isStarred = false;

  bool get isStarred => _isStarred;

  void toggleStarFilter() {
    _isStarred = !_isStarred;
    notifyListeners();
  }
}