import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../color/custom_color.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.onTap,
    required this.isTabActive,
    this.tabColor,
    this.icon,
    this.iconSize,
    this.iconColor,
    required this.text,
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
        color: isTabActive ? (tabColor ?? CustomColor.tileActiveBg(context)) : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
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
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? CustomColor.tileTextPrimary(context),
                  fontWeight: textFontWeight ?? FontWeight.w500,
                  fontSize: textSize ?? 16,
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
                    style: TextStyle(fontSize: 10, color: CustomColor.tileBadgeText(context)),
                  ),
                ),
              ]
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
          onTap: showSwitch && onSwitchChanged != null
              ? () => onSwitchChanged!(!switchValue)
              : onTap,
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
      child: const CircularProgressIndicator(),
    );
  }
}