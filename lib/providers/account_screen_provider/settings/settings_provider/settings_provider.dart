import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier{
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void updateTheme(ThemeMode mode){
    _themeMode = mode;
    notifyListeners();
  }
  void manageAccount(){
    debugPrint("Manage acount clicked");
  }

  Future<void> logout() async{
    debugPrint("User Logged out");
  }
}