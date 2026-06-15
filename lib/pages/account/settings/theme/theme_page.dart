import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/settings/settings_provider/settings_provider.dart';
import '../../../../resources/tile/custom_tile.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.iconTheme.color,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Theme',
          style: TextStyle(
            color: theme.textTheme.titleLarge?.color,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Card(
          color: theme.cardColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ThemeTile(
                  title: 'Light',
                  value: ThemeMode.light,
                  currentMode: settingsProvider.themeMode,
                  onTap: () => settingsProvider.updateTheme(ThemeMode.light),
                ),
                Divider(color: theme.dividerColor, height: 1, thickness: 1),
                ThemeTile(
                  title: 'Dark',
                  value: ThemeMode.dark,
                  currentMode: settingsProvider.themeMode,
                  onTap: () => settingsProvider.updateTheme(ThemeMode.dark),
                ),
                Divider(color: theme.dividerColor, height: 1, thickness: 1),
                ThemeTile(
                  title: 'System default',
                  value: ThemeMode.system,
                  currentMode: settingsProvider.themeMode,
                  onTap: () => settingsProvider.updateTheme(ThemeMode.system),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}