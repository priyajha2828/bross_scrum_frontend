import 'package:flutter/material.dart';
import '../../../providers/home_screen/notifications/notification_provider.dart';
import '../../../resources/color/custom_color.dart';

class SnoozeDialog extends StatelessWidget {
  final NotificationsProvider provider;

  const SnoozeDialog({super.key, required this.provider});

  static Future<void> show(BuildContext context, NotificationsProvider provider) {
    return showDialog(
      context: context,
      barrierColor: CustomColor.overlayBarrier(context),
      builder: (BuildContext context) {
        return SnoozeDialog(provider: provider);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColor.card_bg(context),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Snooze push notifications',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                  color: CustomColor.textPrimary(context),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildSnoozeTile(context, '20 mins', const Duration(minutes: 20)),
            _buildSnoozeTile(context, '1 hr', const Duration(hours: 1)),
            _buildSnoozeTile(context, '4 hrs', const Duration(hours: 4)),
            _buildSnoozeTile(context, '24 hrs', const Duration(hours: 24)),
            _buildSnoozeTile(context, '2 days', const Duration(days: 2)),
            _buildSnoozeTile(context, '1 week', const Duration(days: 7)),
          ],
        ),
      ),
    );
  }

  Widget _buildSnoozeTile(BuildContext context, String label, Duration duration) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: CustomColor.textPrimary(context),
        ),
      ),
      onTap: () {
        provider.snoozeNotifications(duration);
        Navigator.pop(context);
      },
    );
  }
}