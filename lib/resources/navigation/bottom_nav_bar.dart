import 'package:flutter/material.dart';
import '../../providers/home_screen/home_screen_provider.dart';
import '../color/custom_color.dart';

class CustomBottomNavBar extends StatelessWidget {
  final HomeScreenProvider provider;

  const CustomBottomNavBar({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.navBg(context),
        border: Border(
          top: BorderSide(
            color: CustomColor.navBorder(context),
            width: 1,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: provider.currentTab,
        onTap: provider.changeTab,
        type: BottomNavigationBarType.fixed,
        backgroundColor: CustomColor.navBg(context),
        selectedItemColor: CustomColor.primarySelectedBlue,
        unselectedItemColor: CustomColor.navUnselectedItem(context),
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: provider.currentTab == 0
                      ? CustomColor.secondaryContainerBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.home_outlined),
              ),
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.language), label: 'Spaces'),
          const BottomNavigationBarItem(icon: Icon(Icons.assignment_turned_in_outlined), label: 'All work'),
          const BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Dashboards'),
          const BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Notifications'),
        ],
      ),
    );
  }
}