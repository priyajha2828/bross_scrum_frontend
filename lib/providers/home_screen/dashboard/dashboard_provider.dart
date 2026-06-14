import 'package:flutter/material.dart';

enum ActivityIconType { sprint, bolt }

class ActivityItem {
  final String name;
  final String action;
  final String target;
  final String ticket;
  final String date;
  final ActivityIconType iconType;
  final bool bold;

  ActivityItem({
    required this.name,
    required this.action,
    required this.target,
    required this.ticket,
    required this.date,
    required this.iconType,
    required this.bold,
  });
}

class DashboardsProvider extends ChangeNotifier {
  bool isRefreshing = false;
  String lastUpdated = 'just now';
  String selectedDashboard = 'Default dashboard';

  final List<String> assignedToMeItems = [];

  List<ActivityItem> activities = [
    ActivityItem(
      name: 'Priya Jha',
      action: 'updated the Sprint of',
      target: 'SCRUM-8 - Helooo',
      ticket: 'SCRUM-8',
      date: '12 Jun 2026',
      iconType: ActivityIconType.sprint,
      bold: false,
    ),
    ActivityItem(
      name: 'Priya Jha',
      action: 'created',
      target: 'SCRUM-8 - Helooo',
      ticket: 'SCRUM-8',
      date: '12 Jun 2026',
      iconType: ActivityIconType.sprint,
      bold: true,
    ),
    ActivityItem(
      name: 'Priya Jha',
      action: 'created',
      target: 'SCRUM-7 - Hii',
      ticket: 'SCRUM-7',
      date: '12 Jun 2026',
      iconType: ActivityIconType.bolt,
      bold: true,
    ),
  ];

  Future<void> refreshAssignedToMe() async {
    isRefreshing = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    isRefreshing = false;
    notifyListeners();
  }

  Future<void> refreshActivityStream() async {
    isRefreshing = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 800));

    lastUpdated = 'just now';
    isRefreshing = false;
    notifyListeners();
  }

  void changeDashboard(String dashboardName) {
    selectedDashboard = dashboardName;
    notifyListeners();
  }
}