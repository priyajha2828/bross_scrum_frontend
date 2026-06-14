import 'package:flutter/material.dart';

class HomeScreenProvider with ChangeNotifier{
  int _currentTab = 0;
  int _selectedFilterIndex = 0;

  int get currentTab => _currentTab;
  int get selectedFilterIndex => _selectedFilterIndex;

  void changeTab(int index){
    _currentTab = index;
    notifyListeners();
  }
  void changeFilter(int index){
    _selectedFilterIndex = index;
    notifyListeners();
  }
}