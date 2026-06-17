import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import '../../../../resources/card/custom_card.dart';
import '../../../../resources/tile/custom_tile.dart';

class DoNotDisturbPage extends StatelessWidget {
  const DoNotDisturbPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dndProvider = Provider.of<DndProvider>(context);
    final bool isDark = CustomColor.isDark(context);

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
          'Do not disturb',
          style: TextStyle(
            color: CustomColor.textPrimary(context),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Card(
            color: CustomColor.card_bg(context),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                icon: Icons.snooze_outlined,
                text: 'Snooze notifications',
                subtitle: dndProvider.isSnoozed
                    ? 'Snoozed until ${dndProvider.snoozeUntil!.hour.toString().padLeft(2, '0')}:${dndProvider.snoozeUntil!.minute.toString().padLeft(2, '0')}'
                    : 'Pause push notifications for a set time',
                textColor: dndProvider.isSnoozed
                    ? (isDark ? const Color(0xFF3B82F6) : const Color(0xFF2563EB))
                    : CustomColor.textPrimary(context),
                isTabActive: false,
                onTap: () => _showSnoozeBottomSheet(context, dndProvider),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DndScheduleCard(dndProvider: dndProvider),
        ],
      ),
    );
  }

  void _showSnoozeBottomSheet(BuildContext context, DndProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: CustomColor.card_bg(context),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: CustomColor.inputBorderDefault(context),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Snooze Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.textPrimary(context),
                  ),
                ),
                const SizedBox(height: 12),
                _buildSnoozeOption(
                  context,
                  '30 minutes',
                  const Duration(minutes: 30),
                  provider,
                ),
                _buildSnoozeOption(
                  context,
                  '1 hour',
                  const Duration(hours: 1),
                  provider,
                ),
                _buildSnoozeOption(
                  context,
                  '2 hours',
                  const Duration(hours: 2),
                  provider,
                ),
                _buildSnoozeOption(
                  context,
                  'Until tomorrow',
                  const Duration(hours: 24),
                  provider,
                ),
                if (provider.isSnoozed) ...[
                  Divider(color: CustomColor.dividerColor(context)),
                  ListTile(
                    title: Center(
                      child: Text(
                        'Turn Off Snooze',
                        style: TextStyle(
                          color: CustomColor.logout_text(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    onTap: () {
                      provider.turnOffSnooze();
                      Navigator.pop(context);
                    },
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSnoozeOption(
      BuildContext context,
      String title,
      Duration duration,
      DndProvider provider,
      ) {
    return ListTile(
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: CustomColor.textMutedLabel(context),
        ),
      ),
      onTap: () {
        provider.snoozeNotifications(duration);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.toast_bg(context),
            content: Text(
              'Notifications paused for $title',
              style: TextStyle(color: CustomColor.toast_text(context)),
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}