import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/account_screen_provider/settings/settings_provider/settings_provider.dart';
import '../../../../resources/color/custom_color.dart';
import '../../../../resources/tile/custom_tile.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsProvider = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Theme',
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: CustomColor.card_bg(context),
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
                Divider(height: 1, color: CustomColor.dividerColor(context)),
                ThemeTile(
                  title: 'Dark',
                  value: ThemeMode.dark,
                  currentMode: settingsProvider.themeMode,
                  onTap: () => settingsProvider.updateTheme(ThemeMode.dark),
                ),
                Divider(height: 1, color: CustomColor.dividerColor(context)),
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