import 'package:flutter/material.dart';

import '../../../resources/color/custom_color.dart';

class SpaceModel {
  final String name;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  bool isStarred;

  SpaceModel({
    required this.name,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    this.isStarred = false,
  });
}

class SpacesProvider extends ChangeNotifier {
  final List<SpaceModel> _spaces = [
    SpaceModel(
      name: 'App 2',
      subtitle: 'A2',
      icon: Icons.dashboard_outlined,
      iconColor: Colors.amber.shade900,
      isStarred: true,
    ),
    SpaceModel(
      name: 'app1',
      subtitle: 'SCRUM',
      icon: Icons.album_outlined,
      iconColor:Colors.purple.shade600 ,
      isStarred: false,
    ),
  ];

  String _searchQuery = '';

  List<SpaceModel> get allSpaces => _spaces;

  List<SpaceModel> get starredSpaces =>
      _spaces.where((s) => s.isStarred).toList();

  List<SpaceModel> get recentlyViewed => _spaces.take(2).toList();

  List<SpaceModel> get filteredSpaces {
    if (_searchQuery.isEmpty) return _spaces;
    return _spaces
        .where((s) =>
    s.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        s.subtitle.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void toggleStar(SpaceModel space) {
    space.isStarred = !space.isStarred;
    notifyListeners();
  }
}