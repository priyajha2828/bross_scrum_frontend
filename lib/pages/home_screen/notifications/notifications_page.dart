import 'package:BrossScrum/resources/filter_chip/notification_filter_chip.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/home_screen/notifications/notification_provider.dart';
import '../../../resources/color/custom_color.dart';
import '../../../resources/dialogue/snooze_dialogue.dart';
import '../../../resources/painter/custom_painter.dart';
import '../../../routes/app_route.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationsProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.bg_color(context),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan[700],
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoute.accountscreen);
              },
              child: const Text(
                'PJ',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: CustomColor.textPrimary(context)),
            onPressed: () => SnoozeDialog.show(context, provider),
          ),
          IconButton(
            icon: Icon(Icons.settings_outlined, color: CustomColor.textPrimary(context)),
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.notificationsetting);
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
            child: Text(
              'Notifications',
              style: TextStyle(
                color: CustomColor.textPrimary(context),
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                NotificationFilterChip(
                  label: 'Direct',
                  filter: NotificationFilter.direct,
                  provider: provider,
                ),
                const SizedBox(width: 12),
                NotificationFilterChip(
                  label: 'Unread',
                  filter: NotificationFilter.unread,
                  provider: provider,
                ),
                const Spacer(),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: CustomColor.textMutedLabel(context)),
                  onSelected: (value) {
                    if (value == "mark_all_read") {
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem<String>(
                      value: "mark_all_read",
                      child: Text("mark all as read"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: CustomPaint(
                        painter: EmptyStateIslandPainter(isDark: CustomColor.isDark(context)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      provider.selectedFilter == NotificationFilter.direct
                          ? 'No direct notifications'
                          : 'No unread notifications',
                      style: TextStyle(
                        color: CustomColor.textPrimary(context),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      provider.selectedFilter == NotificationFilter.direct
                          ? 'To see all notifications, clear the Direct notification filter.'
                          : 'To see both read and unread notifications, clear the Unread notification filter.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: CustomColor.textMutedLabel(context),
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextButton(
                      onPressed: provider.clearFilters,
                      child: Text(
                        'Clear notification filters',
                        style: TextStyle(
                          color: CustomColor.actionBlueText(context),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}