import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomListTile extends StatelessWidget {
  CustomListTile({
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
        color: isTabActive ? (tabColor ?? Colors.white) : Colors.transparent,
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: enableIconContainer
              ? Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F5F7),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _buildLeadingWidget(),
          )
              : _buildLeadingWidget(),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor ?? const Color(0xFF1F2937),
                  fontWeight: textFontWeight ?? FontWeight.w500,
                  fontSize: textSize ?? 16,
                ),
              ),
              if (showBadge) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Recommended',
                    style: TextStyle(fontSize: 10, color: Color(0xFF4B5563)),
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
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF9CA3AF),
              ),
            ),
          )
              : null,
          trailing: showSwitch
              ? Switch(
            value: switchValue,
            onChanged: onSwitchChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF2563EB),
            inactiveThumbColor: const Color(0xFF4B5563),
            inactiveTrackColor: const Color(0xFFE5E7EB),
          )
              : null,
          onTap: showSwitch && onSwitchChanged != null
              ? () => onSwitchChanged!(!switchValue)
              : onTap,
        ),
      ),
    );
  }

  Widget _buildLeadingWidget() {
    if (!isIcon) {
      if (networkImageUrl != null) {
        return _buildNetworkImage();
      } else if (imgName != null) {
        return _buildAssetImage();
      }
    }
    return _buildIcon();
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

  Widget _buildIcon() {
    if (icon is FaIconData) {
      return FaIcon(
        icon as FaIconData?,
        size: iconSize ?? 22,
        color: iconColor ?? const Color(0xFF42526E),
      );
    }
    return Icon(
      icon,
      size: iconSize ?? 22,
      color: iconColor ?? const Color(0xFF42526E),
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