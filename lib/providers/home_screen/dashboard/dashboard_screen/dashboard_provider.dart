import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';

class DashboardModel {
  final String name;
  final bool isStarred;

  const DashboardModel({required this.name, this.isStarred = false});
}

class ActivityItem {
  final String userInitials;
  final Color avatarColor;
  final String userName;
  final String action;
  final String issueKey;
  final String issueTitle;
  final IconData issueIcon;
  final Color issueIconColor;
  final Color issueIconBg;
  final String date;
  final bool isToday;
  final void Function(BuildContext context)? onTap;

  const ActivityItem({
    required this.userInitials,
    required this.avatarColor,
    required this.userName,
    required this.action,
    required this.issueKey,
    required this.issueTitle,
    required this.issueIcon,
    required this.issueIconColor,
    required this.issueIconBg,
    required this.date,
    required this.isToday,
   this.onTap,
  });
}

class DashboardsProvider extends ChangeNotifier {

  final List<DashboardModel> _dashboards = [
    const DashboardModel(name: 'Default dashboard', isStarred: true),
    const DashboardModel(name: 'My Dashboard'),
    const DashboardModel(name: 'Team Dashboard'),
  ];

  List<DashboardModel> get dashboards => _dashboards;

  List<DashboardModel> get starredDashboards =>
      _dashboards.where((d) => d.isStarred).toList();

  String _selectedDashboard = 'Default dashboard';
  String get selectedDashboard => _selectedDashboard;

  void selectDashboard(String name) {
    _selectedDashboard = name;
    notifyListeners();
  }


  final List<Map<String, dynamic>> assignedToMe = [];


  final List<ActivityItem> activityItems = [
    ActivityItem(
      userInitials: 'PJ',
      avatarColor: Color(0xFF5B21B6),
      userName: 'Priya Jha',
      action: 'created',
      issueKey: 'SCRUM-10',
      issueTitle: 'Hiiihiii',
      issueIcon: Icons.bolt,
      issueIconColor: Color(0xFFB554E0),
      issueIconBg: Color(0xFFF3E8FF),
      date: 'just now',
      isToday: true,
      onTap: (context){
        Navigator.pushNamed(context, AppRoute.scrumscreen);
      }
    ),
    ActivityItem(
      userInitials: 'PJ',
      avatarColor: Color(0xFF5B21B6),
      userName: 'Priya Jha',
      action: 'created',
      issueKey: 'SCRUM-9',
      issueTitle: 'Hhiii',
      issueIcon: Icons.bolt,
      issueIconColor: Color(0xFFB554E0),
      issueIconBg: Color(0xFFF3E8FF),
      date: 'just now',
      isToday: true,
      onTap: (context){
        Navigator.pushNamed(context, AppRoute.scrumscreen);
      }
    ),
    ActivityItem(

      userInitials: 'PJ',
      avatarColor: Color(0xFF5B21B6),
      userName: 'Priya Jha',
      action: 'created',
      issueKey: 'SCRUM-7',
      issueTitle: 'Hii',
      issueIcon: Icons.bolt,
      issueIconColor: Color(0xFFB554E0),
      issueIconBg: Color(0xFFF3E8FF),
      date: '12 Jun 2026',
      isToday: false,
      onTap: (context){
        Navigator.pushNamed(context, AppRoute.scrumscreen);
      }
    ),
  ];

  String lastRefreshed = 'just now';
}