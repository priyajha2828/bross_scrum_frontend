import 'package:BrossScrum/providers/account_screen_provider/account_screen/account_screen_provider.dart';
import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../resources/tile/custom_tile.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountScreenProvider = Provider.of<AccountScreenProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoute.homescreen);
          },
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
        ),
        title: Text(
          "Account",
          style: TextStyle(
            color: CustomColor.textPrimary(context),
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
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: CustomColor.tileIconContainerBg(context),
                    child: Icon(
                      Icons.person,
                      size: 30,
                      color: CustomColor.tileIconDefault(context),
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
                            color: CustomColor.tileTextPrimary(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          accountScreenProvider.userEmail,
                          style: TextStyle(
                            fontSize: 12,
                            color: CustomColor.textMutedLabel(context),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              accountScreenProvider.siteName,
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColor.textPrimary(context),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Add sites",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CustomColor.isDark(context)
                                      ? const Color(0xFF3B82F6)
                                      : CustomColor.introbg,
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
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.notifications_none_outlined,
                    text: "Notification Settings",
                    isTabActive: false,
                    enableIconContainer: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.notificationsetting);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: CustomColor.dividerColor(context),
                  ),
                  CustomListTile(
                    icon: Icons.settings_outlined,
                    text: "Settings",
                    isTabActive: false,
                    enableIconContainer: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.setting);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                color: CustomColor.card_bg(context),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CustomListTile(
                    icon: Icons.person_add_alt,
                    text: "Invite people to this site",
                    isTabActive: false,
                    enableIconContainer: true,
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.invitepeople);
                    },
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: CustomColor.dividerColor(context),
                  ),
                  CustomListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoute.feedback);
                    },
                    icon: Icons.mail_outlined,
                    isTabActive: false,
                    text: "Give Feedback",
                    enableIconContainer: true,
                  ),
                  Divider(
                    height: 1,
                    thickness: 0.5,
                    indent: 56,
                    color: CustomColor.dividerColor(context),
                  ),
                  CustomListTile(
                    onTap: () {
                      context.read<AccountScreenProvider>().redirectToPlayStore();
                    },
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