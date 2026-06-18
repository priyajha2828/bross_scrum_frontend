import 'package:BrossScrum/pages/home_screen/all_work/all_work_screen/all_work_screen.dart';
import 'package:BrossScrum/pages/home_screen/home_screen/homeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/home_screen/dashboard/dashboard.dart';
import '../../pages/home_screen/notifications/notifications_page.dart';
import '../../pages/home_screen/spaces/spaces_screen/spaces_screen.dart';
import '../color/custom_color.dart';

class BottomNaviBarPage extends StatefulWidget {
  const BottomNaviBarPage({super.key});

  @override
  State<BottomNaviBarPage> createState() => _BottomNaviBarPageState();
}

class _BottomNaviBarPageState extends State<BottomNaviBarPage> {

  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    SpacesScreen(),
    AllWorkScreen(),
    DashboardsScreen(),
    NotificationsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: CustomColor.navBg(context),
          selectedItemColor: CustomColor.isDark(context)
              ? CustomColor.chipSelectedText(context)
              : CustomColor.primarySelectedBlue,
          unselectedItemColor: CustomColor.navUnselectedItem(context),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          onTap: (index){
            setState(() {
              selectedIndex=index;
            });
          },
          currentIndex: selectedIndex,
          type: BottomNavigationBarType.fixed,

          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: 'Spaces',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in_outlined),
              label: 'All Work',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none),
              label: 'Notifications',
            ),
          ]) ,


    );
  }
}