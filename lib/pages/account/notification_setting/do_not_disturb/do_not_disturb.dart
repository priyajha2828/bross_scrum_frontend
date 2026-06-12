import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/notification_settings_provider/donotdisturb_provider/donotdisturb_provider.dart';
import '../../../../resources/card/dnd_card.dart';
import '../../../../resources/tile/custom_tile.dart';

class DoNotDisturbPage extends StatelessWidget {
  const DoNotDisturbPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dndProvider = Provider.of<DndProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon:  Icon(Icons.arrow_back,
              color:CustomColor.arrowback(context)
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Do not disturb',
          style: TextStyle(
            color: Color(0xFF1F2937),
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: [
          Card(
            color: Colors.white,
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
                    ? const Color(0xFF2563EB)
                    : const Color(0xFF1F2937),
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
      backgroundColor: Colors.white,
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
                    color: const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Snooze Notifications',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937),
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
                  const Divider(color: Color(0xFFF3F4F6)),
                  ListTile(
                    title: const Center(
                      child: Text(
                        'Turn Off Snooze',
                        style: TextStyle(
                          color: Colors.red,
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
        style: const TextStyle(fontSize: 16, color: Color(0xFF4B5563)),
      ),
      onTap: () {
        provider.snoozeNotifications(duration);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Notifications paused for $title'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }
}
