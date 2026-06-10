import 'package:BrossScrum/providers/account_screen_provider/account_screen_provider.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../resources/tile/custom_tile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountScreenProvider = Provider.of<AccountScreenProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F5F7),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.homescreen);
          },
          icon: Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: Text(
          "Account",
          style: TextStyle(
            color: CustomColor.bross_scrum,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: Colors.grey[300],
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          accountScreenProvider.userName,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          accountScreenProvider.userEmail,
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColor.bross_scrum,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              accountScreenProvider.siteName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[900],
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                "Add sites",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF0052CC),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.notifications_none_outlined,
                    text: " Notification Settings",
                    isTabActive: false,
                    enableIconContainer: true,

                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.notificationsetting);
                    },
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: Color(0xFFEEEEEE),
                  ),
                  CustomListTile(
                    icon: Icons.settings_outlined,
                    text: "Settings",
                    isTabActive: false,
                    enableIconContainer: true,
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.person_add_alt,
                    text: "Invite people to this site",
                    isTabActive: false,
                    enableIconContainer: true,
                    onTap: () {},
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: Color(0xFFEEEEEE),
                  ),
                  CustomListTile(
                    onTap: () {},
                    icon: Icons.mail_outlined,
                    isTabActive: false,
                    text: "Give Feedack",
                    enableIconContainer: true,
                  ),
                  const Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: Color(0xFFEEEEEE),
                  ),
                  CustomListTile(
                    onTap: () {},
                    icon: Icons.star_border,
                    isTabActive: false,
                    text: "Rate Us",
                    enableIconContainer: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
