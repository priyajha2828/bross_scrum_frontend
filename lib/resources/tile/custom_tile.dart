import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/home_screen/create(+)/create_screen_provider.dart';
import '../color/custom_color.dart';
import '../../providers/home_screen/spaces/space_provider.dart';
import '../model/work_type_model.dart';

// =========================================================================
// १. SpaceListTile विजेट
// =========================================================================
class SpaceListTile extends StatelessWidget {
  final SpaceModel space;
  final VoidCallback? onStarTap;
  final VoidCallback? onTap;

  const SpaceListTile({
    super.key,
    required this.space,
    this.onStarTap,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: space.iconColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                space.icon,
                color: CustomColor.shortcutIconDefault,
                size: 22,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    space.name,
                    style: TextStyle(
                      color: CustomColor.tileTextPrimary(context),
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    space.subtitle,
                    style: TextStyle(
                      color: CustomColor.tileTextSecondary(context),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                space.isStarred ? Icons.star : Icons.star_border,
                color: space.isStarred
                    ? Colors.amber
                    : CustomColor.tileIconDefault(context),
              ),
              onPressed: onStarTap,
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// २. CustomListTile विजेट
// =========================================================================
class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.onTap,
    required this.isTabActive,
    required this.text,
    this.tabColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    this.textSize,
    this.textColor,
    this.textFontWeight,
    this.isIcon = true,
    this.imgName,
    this.networkImageUrl,
    this.imgWidth,
    this.imgHeigt,
    this.imgBoxFit,
    this.imgColor,
    this.tileHeight,
    this.tileWidth,
    this.enableIconContainer = false,
    this.subtitle,
    this.showSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.showBadge = false,
    super.key,
  });

  final Function() onTap;
  final bool isTabActive;
  final Color? tabColor;
  final IconData? icon;
  final double? iconSize;
  final Color? iconColor;
  final String text;
  final double? textSize;
  final Color? textColor;
  final FontWeight? textFontWeight;
  final bool isIcon;
  final String? imgName;
  final String? networkImageUrl;
  final double? imgWidth;
  final double? imgHeigt;
  final BoxFit? imgBoxFit;
  final Color? imgColor;
  final double? tileHeight;
  final double? tileWidth;
  final bool enableIconContainer;
  final String? subtitle;
  final bool showSwitch;
  final bool switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final bool showBadge;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: tileHeight,
      width: tileWidth,
      decoration: BoxDecoration(
        color: isTabActive
            ? (tabColor ?? CustomColor.tileActiveBg(context))
            : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          onTap: showSwitch && onSwitchChanged != null
              ? () => onSwitchChanged!(!switchValue)
              : onTap,
          leading: enableIconContainer
              ? Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: CustomColor.tileIconContainerBg(context),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildLeadingWidget(context),
          )
              : _buildLeadingWidget(context),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor ?? CustomColor.tileTextPrimary(context),
                    fontWeight: textFontWeight ?? FontWeight.w500,
                    fontSize: textSize ?? 16,
                  ),
                ),
              ),
              if (showBadge) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: CustomColor.tileBadgeBg(context),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Recommended',
                    style: TextStyle(
                      fontSize: 10,
                      color: CustomColor.tileBadgeText(context),
                    ),
                  ),
                ),
              ],
            ],
          ),
          subtitle: subtitle != null
              ? Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              subtitle!,
              style: TextStyle(
                fontSize: 13,
                color: CustomColor.tileTextSecondary(context),
              ),
            ),
          )
              : null,
          trailing: showSwitch
              ? Switch(
            value: switchValue,
            onChanged: onSwitchChanged,
            activeColor: Colors.white,
            activeTrackColor: CustomColor.switchActiveTrack(context),
            inactiveThumbColor: CustomColor.switchInactiveThumb(context),
            inactiveTrackColor: CustomColor.switchInactiveTrack(context),
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildLeadingWidget(BuildContext context) {
    if (!isIcon) {
      if (networkImageUrl != null) {
        return _buildNetworkImage();
      } else if (imgName != null) {
        return _buildAssetImage();
      }
    }
    return _buildIcon(context);
  }

  Widget _buildNetworkImage() {
    return Image.network(
      networkImageUrl!,
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      fit: imgBoxFit ?? BoxFit.cover,
      color: imgColor,
      errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoadingWidget();
      },
    );
  }

  Widget _buildAssetImage() {
    return Image.asset(
      imgName!,
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      fit: imgBoxFit ?? BoxFit.none,
      color: imgColor,
    );
  }

  Widget _buildIcon(BuildContext context) {
    if (icon is FaIconData) {
      return FaIcon(
        icon as FaIconData?,
        size: iconSize ?? 22,
        color: iconColor ?? CustomColor.tileIconDefault(context),
      );
    }
    return Icon(
      icon,
      size: iconSize ?? 22,
      color: iconColor ?? CustomColor.tileIconDefault(context),
    );
  }

  Widget _buildErrorWidget() {
    return Icon(
      Icons.error_outline,
      size: iconSize ?? 18,
      color: Colors.red,
    );
  }

  Widget _buildLoadingWidget() {
    return SizedBox(
      width: imgWidth ?? 40,
      height: imgHeigt ?? 40,
      child: const Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}

// =========================================================================
// ३. ThemeTile विजेट
// =========================================================================
class ThemeTile extends StatelessWidget {
  final String title;
  final ThemeMode value;
  final ThemeMode currentMode;
  final VoidCallback onTap;

  const ThemeTile({
    required this.title,
    required this.value,
    required this.currentMode,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentMode == value;
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                color: theme.textTheme.bodyLarge?.color,
                fontWeight: FontWeight.w400,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check,
                color: theme.colorScheme.primary,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }
}


class WorkTypeTile extends StatelessWidget {
  final WorkTypeOption option;
  final bool isSelected;
  final VoidCallback onTap;

  const WorkTypeTile({
    super.key,
    required this.option,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected
            ? CustomColor.chipSelectedBg(context)
            : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: option.iconBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(option.icon, color: option.iconColor, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.textPrimary(context),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.description,
                    style: TextStyle(
                      fontSize: 13,
                      color: CustomColor.textMutedLabel(context),
                    ),
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