import 'package:flutter/material.dart';

class CustomColor {
  CustomColor._();

  // Helper method to detect if device/app is currently in dark mode
  static bool isDark(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  // Backgrounds & Layout
  static List<Color> bgGradientColors(BuildContext context) => isDark(context)
      ? [const Color(0xFF1F2937), const Color(0xFF111827), const Color(0xFF111827)]
      : [const Color(0xFFE8EDF8), const Color(0xFFF5EBE6), const Color(0xFFFFFFFF)];

  static const List<double> bgGradientStops = [0.0, 0.4, 0.8];

  static Color logincontainer(BuildContext context) =>
      isDark(context) ? const Color(0x33000000) : const Color(0xB3FFFFFF);

  static const Color introbg = Color(0xFF0052CC); // Constant brand color

  static Color appbar(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF3F4F6);

  static Color bg_color(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFFF3F4F6);

  // List Tile Specific Colors
  static Color tileActiveBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  static Color tileText(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  static Color tileTextPrimary(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  static Color tileTextSecondary(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF9CA3AF);

  static Color tileIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF42526E);

  static Color tileIconDefault(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF42526E);

  static Color tileSubtitle(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static Color tileIconContainer(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF4F5F7);

  static Color tileIconContainerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF4F5F7);

  static Color badgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color tileBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color badgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563);

  static Color tileBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFFD1D5DB) : const Color(0xFF4B5563);

  // Buttons, Toggles & Brand
  static const Color primarySelectedBlue = Color(0xFF0C3D91); // Constant brand color
  static const Color secondaryContainerBlue = Color(0xFFD3E2FF); // Constant brand color
  static const Color toggleBackgroundGrey = Color(0xFFE2E4E9); // Constant brand color

  static Color switchActiveTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color switchInactiveTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  static Color switchInactiveThumb(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  // Miscellaneous
  static const Color bross_scrum = Color(0xFF004D40); // Constant brand color

  static Color arrowback(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF374151);

  static Color logout_text(BuildContext context) =>
      isDark(context) ? const Color(0xFFEF4444) : const Color(0xFFDC2626);

  static final Color profileAvatarPurple = Colors.deepPurple[700]!;
  static final Color appShortcutBlue = Colors.blue[800]!;
  static const Color appShortcutOrange = Colors.deepOrange;

  // Card Backgrounds
  static Color card_bg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFFFFFFF);

  static Color dividerColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  // Text Styling
  static Color textPrimary(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937);

  static Color textMutedLabel(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  static Color smalltext(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);

  static Color actionBlueText(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF0052CC);

  // Filter Chips (Dynamic Layout Elements)
  static Color chipSelectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6).withOpacity(0.3) : const Color(0xFFD3E2FF);

  static Color chipSelectedText(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF0C3D91);

  static Color chipUnselectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF3F4F6);

  static Color chipUnselectedBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  // Day Selector Colors
  static Color daySelectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color dayUnselectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  // Component UI Mappings
  static Color dropdownBg(BuildContext context) => card_bg(context);
  static Color dropdownFloatingLabel(BuildContext context) => smalltext(context);

  static Color dropdownBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

  static Color dropdownText(BuildContext context) => textPrimary(context);
  static Color dropdownIcon(BuildContext context) => textMutedLabel(context);

  // Bottom Navigation Bar Colors
  static Color navBg(BuildContext context) => card_bg(context);

  static Color navBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE0E0E0);

  static Color navUnselectedItem(BuildContext context) =>
      isDark(context) ? Colors.grey[400]! : Colors.grey[600]!;

  static Color bottomNavSelected(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF0C3D91);

  static Color bottomNavUnselected(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  // Overlays & Overrides
  static Color overlayBarrier(BuildContext context) =>
      isDark(context) ? const Color(0x99000000) : const Color(0x66000000);

  // Form & TextField Component Colors
  static Color inputBg(BuildContext context) => card_bg(context);
  static Color inputFocusBg(BuildContext context) => card_bg(context);

  static Color inputHintDefault(BuildContext context) =>
      isDark(context) ? Colors.grey.shade500 : Colors.grey.shade400;

  static Color inputBorderDefault(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  static Color inputBorderError(BuildContext context) =>
      isDark(context) ? Colors.red.shade400 : Colors.red.shade800;

  static Color inputGlassBaseWhite(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  // Filter & Space Component Colors
  static Color filterUnselectedText(BuildContext context) =>
      isDark(context) ? Colors.grey[400]! : Colors.grey[700]!;

  static Color shortcutCardBg(BuildContext context) => card_bg(context);
  static const Color shortcutIconDefault = Colors.white;

  static Color shortcutSubtitle(BuildContext context) =>
      isDark(context) ? Colors.grey[400]! : Colors.grey[500]!;

  // Activity Feed Component Colors
  static Color feedRowBg(BuildContext context) => card_bg(context);

  static Color feedTextPrimary(BuildContext context) =>
      isDark(context) ? Colors.white54 : Colors.black87;

  static Color feedTextSecondary(BuildContext context) =>
      isDark(context) ? Colors.grey[400]! : Colors.grey[500]!;

  // Toast / SnackBar Notification Components
  static Color toast_bg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFF1F2937);

  static Color toast_text(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : Colors.white;
}