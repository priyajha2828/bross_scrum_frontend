import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/account_screen_provider/settings/settings_provider/settings_provider.dart';
import '../../../../resources/tile/custom_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: CustomColor.arrowback(context),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: CustomColor.textPrimary(context), // Dynamic color adaptation
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        children: [
          // Theme Block
          Card(
            color: CustomColor.card_bg(context),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                icon: Icons.palette_outlined,
                text: 'Theme',
                textSize: 16,
                textColor: CustomColor.tileTextPrimary(context),
                isTabActive: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.theme);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Manage Account Block
          Card(
            color: CustomColor.card_bg(context), // Replaced hardcoded white
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                icon: Icons.manage_accounts,
                text: 'Manage account',
                textSize: 16,
                textColor: CustomColor.tileTextPrimary(context),
                isTabActive: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.manageaccount);
                },
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Log Out Block
          Card(
            color: CustomColor.card_bg(context), // Replaced hardcoded white
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                icon: Icons.logout_outlined,
                text: 'Log out',
                textSize: 16,
                textColor: CustomColor.logout_text(context),
                isTabActive: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.intro);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}