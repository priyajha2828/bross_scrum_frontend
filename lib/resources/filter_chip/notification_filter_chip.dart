import 'package:flutter/material.dart';
import '../../../providers/home_screen/notifications/notification_provider.dart';
import '../../../resources/color/custom_color.dart';

class NotificationFilterChip extends StatelessWidget {
  final String label;
  final NotificationFilter filter;
  final NotificationsProvider provider;

  const NotificationFilterChip({
    required this.label,
    required this.filter,
    required this.provider,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = provider.selectedFilter == filter;

    return GestureDetector(
      onTap: () => provider.setFilter(filter),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? CustomColor.chipSelectedBg(context)
              : CustomColor.chipUnselectedBg(context),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : CustomColor.chipUnselectedBorder(context),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? CustomColor.chipSelectedText(context)
                : CustomColor.textMutedLabel(context),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}