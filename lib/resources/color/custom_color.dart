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

  static const Color introbg = Color(0xFF0052CC);

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
  static const Color primarySelectedBlue = Color(0xFF0C3D91);
  static const Color secondaryContainerBlue = Color(0xFFD3E2FF);
  static const Color toggleBackgroundGrey = Color(0xFFE2E4E9);

  static Color switchActiveTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color switchInactiveTrack(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFE5E7EB);

  static Color switchInactiveThumb(BuildContext context) =>
      isDark(context) ? const Color(0xFF9CA3AF) : const Color(0xFF4B5563);

  // Miscellaneous
  static Color bross_scrum(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFF004D40);

  static Color arrowback(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF374151);

  static Color logout_text(BuildContext context) =>
      isDark(context) ? const Color(0xFFEF4444) : const Color(0xFFDC2626);

  static Color box_decoration(BuildContext context) =>
      isDark(context) ? const Color(0xFF3D2A50) : const Color(0xFFF3E8FF);

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

  // Filter Chips
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

  static Color board(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFE8EAED);

  // ────────────────────────────────────────────────────────────────
  // Organizations Screen Colors
  // (merged in from organization_colors.dart — only new names that
  // didn't already exist above; shared concepts like titles/subtitles/
  // card backgrounds reuse the members already defined higher up)
  // ────────────────────────────────────────────────────────────────

  // "Active" status badge
  static Color activeBadgeBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFDCE7FF);

  static Color activeBadgeText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF1D4ED8);

  // Organization card frame
  static Color orgCardBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF2D3748) : const Color(0xFFEDEFF2);

  static Color orgCardShadow(BuildContext context) =>
      isDark(context) ? const Color(0x00000000) : const Color(0x14000000);

  // Avatar stack ("+21")
  static Color avatarStackBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : Colors.white;

  static Color avatarExtraBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : const Color(0xFF1F2937);

  static Color avatarExtraText(BuildContext context) => Colors.white;

  // Invite Others card (dashed border)
  static Color inviteCardBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFCBD5E1);

  static Color inviteIconBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFDCE7FF);

  static Color inviteIconColor(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);

  static Color inviteLinkBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E2A3A) : const Color(0xFFEFF4FF);

  static Color inviteLinkText(BuildContext context) =>
      isDark(context) ? const Color(0xFF93C5FD) : const Color(0xFF2563EB);

  static Color copyButtonBg(BuildContext context) =>
      isDark(context) ? const Color(0xFFF9FAFB) : const Color(0xFF111827);

  static Color copyButtonText(BuildContext context) =>
      isDark(context) ? const Color(0xFF111827) : Colors.white;

  // Floating action button
  static Color fabBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color fabIcon(BuildContext context) => Colors.white;

  // Secondary "add organization" ghost button
  static Color addOrgGhostBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1F2937) : const Color(0xFFF3F4F6);

  static Color addOrgGhostIcon(BuildContext context) => textMutedLabel(context);

   //Logo picker
  static Color logoPickerBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFF4F5F7);

  static Color logoPickerBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF4B5563) : const Color(0xFFD1D5DB);

  static Color logoPickerIcon(BuildContext context) => textMutedLabel(context);

  // Slug availability feedback
  static Color slugAvailableText(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF15803D);

  static Color slugTakenText(BuildContext context) =>
      isDark(context) ? const Color(0xFFF87171) : const Color(0xFFDC2626);

  static Color slugCheckingText(BuildContext context) => smalltext(context);

  static Color slugPrefixText(BuildContext context) => textMutedLabel(context);

  // Plan tier selector cards
  static Color planCardSelectedBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF1E3A5F) : const Color(0xFFEFF4FF);

  static Color planCardSelectedBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color planCardUnselectedBg(BuildContext context) => card_bg(context);

  static Color planCardUnselectedBorder(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color planCardTitle(BuildContext context) => textPrimary(context);

  static Color planCardTagline(BuildContext context) => smalltext(context);

  static Color planCardPrice(BuildContext context) =>
      isDark(context) ? const Color(0xFF60A5FA) : const Color(0xFF2563EB);

  static Color planCardFeatureText(BuildContext context) =>
      textMutedLabel(context);

  static Color planCardCheckIcon(BuildContext context) =>
      isDark(context) ? const Color(0xFF4ADE80) : const Color(0xFF16A34A);

  static Color planBadgePopularBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);

  static Color planBadgePopularText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCD34D) : const Color(0xFFB45309);

  // Form-level error banner
  static Color formErrorBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3F1D1D) : const Color(0xFFFEE2E2);

  static Color formErrorText(BuildContext context) =>
      isDark(context) ? const Color(0xFFFCA5A5) : const Color(0xFFB91C1C);

  // Primary CTA button
  static Color primaryButtonBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF3B82F6) : const Color(0xFF2563EB);

  static Color primaryButtonDisabledBg(BuildContext context) =>
      isDark(context) ? const Color(0xFF374151) : const Color(0xFFE5E7EB);

  static Color primaryButtonText(BuildContext context) => Colors.white;

  static Color primaryButtonDisabledText(BuildContext context) =>
      textMutedLabel(context);
}