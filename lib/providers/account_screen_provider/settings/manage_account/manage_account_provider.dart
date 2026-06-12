import 'package:flutter/material.dart';

class ManageAccountProvider  with ChangeNotifier{

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<bool> performGoToBrowser() async {
    _setLoading(true);

    await Future.delayed(const Duration(seconds: 2));
    _setLoading(false);
    return true;

  }

  void _setLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
}