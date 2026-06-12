import 'package:flutter/material.dart';

class AccountScreenProvider  with ChangeNotifier{

  String _userName = "Priya Jha";
  String _userEmail = "priyajhaguriya@gmail.com";
  String _siteName = 'priyajhaa';
  List<String> _sites = [];

  String get userName => _userName;
  String get userEmail => _userEmail;
  String get siteName => _siteName;
  List<String> get sites => _sites;

  void updateProfile({required String name , required String email}){
    _userEmail = email;
    _userName = name;
    notifyListeners();
  }

  void addSites (String newSite){
    _sites.add(newSite);
    notifyListeners();
  }
}