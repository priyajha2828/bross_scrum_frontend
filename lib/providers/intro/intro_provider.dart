import 'package:flutter/material.dart';

class IntroProvider  extends ChangeNotifier{
  final PageController _pageController = PageController();

  int _currentPage = 0;

  PageController get pageController => _pageController;
  int get currentPage => _currentPage;

  final List<Map<String, String>> _introData = [

    {
      "image":"assets/images/intro/page3.png",
      "text": "Track tasks, project status, and time spent on work.",
    },

    {
      "image":"assets/images/intro/page7.png",
      "text": "Swipe and drag to track, prioritize, and filter on the go.",
    },

    {
      "image":"assets/images/intro/page5.png",
      "text": "Get real-time notifications about activity across all your sites.",
    },

    {
      "image":"assets/images/intro/page6.png",
      "text" : "Track team goals (SLAs)."
    },


  ];

  List<Map<String,String>> get introData => _introData;

  void updatePage(int page){
    _currentPage = page;
    notifyListeners();
  }

  void handleLoginCLick(){
    debugPrint("Log in clicked");
  }

  void dispose(){
    _pageController.dispose();
    super.dispose();
  }
}