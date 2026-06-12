import 'package:BrossScrum/resources/color/custom_color.dart';
import 'package:BrossScrum/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/account_screen_provider/notification_settings_provider/notification_setting/notification_settings_provider.dart';
import '../../../../resources/tile/custom_tile.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NotificationProvider>(context);

    return Scaffold(
      backgroundColor: CustomColor.bg_color(context),
      appBar: AppBar(
        backgroundColor: CustomColor.appbar(context),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: CustomColor.arrowback(context)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notifications',
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
          Text(
            'General',
            style: TextStyle(
              color: CustomColor.smalltext(context),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: CustomColor.card_bg(context),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                text: 'Notification categories',
                textSize: 16,
                textColor: CustomColor.textPrimary(context),
                icon: Icons.tune_outlined,
                enableIconContainer: true,
                isTabActive: false,
                onTap: () {},
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Work item notification',
            style: TextStyle(
              color: CustomColor.smalltext(context),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            color: CustomColor.card_bg(context),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  CustomListTile(
                    text: 'Mentions',
                    subtitle: 'When someone @mentions you',
                    icon: Icons.alternate_email,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.mentions,
                    onSwitchChanged: provider.toggleMentions,
                    showBadge: true,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'Watching',
                    subtitle: "Updates on work items you're watching",
                    icon: Icons.visibility_outlined,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.watching,
                    onSwitchChanged: provider.toggleWatching,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'Assigned',
                    subtitle: 'Updates on work items assigned to you',
                    icon: Icons.person_outline,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.assigned,
                    onSwitchChanged: provider.toggleAssigned,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'Reported',
                    subtitle: 'Updates on work items you created',
                    icon: Icons.person_add_alt,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.reported,
                    onSwitchChanged: provider.toggleReported,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'New work',
                    subtitle: 'New work items created in select projects',
                    icon: Icons.assignment_turned_in_outlined,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.newWork,
                    onSwitchChanged: provider.toggleNewWork,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'Approval requests',
                    subtitle: 'When someone adds you as an approver',
                    icon: Icons.check_circle_outline,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.approvalRequests,
                    onSwitchChanged: provider.toggleApprovalRequests,
                    isTabActive: false,
                    onTap: () {},
                  ),
                  _buildDivider(context),
                  CustomListTile(
                    text: 'Due or Overdue',
                    subtitle: 'Work items due today or in the last 7 days',
                    icon: Icons.calendar_today_outlined,
                    enableIconContainer: true,
                    showSwitch: true,
                    switchValue: provider.dueOrOverdue,
                    onSwitchChanged: provider.toggleDueOrOverdue,
                    isTabActive: false,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            color: CustomColor.card_bg(context),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: CustomListTile(
                text: 'Do not disturb',
                textSize: 16,
                textColor: CustomColor.textPrimary(context),
                icon: Icons.do_not_disturb_on_outlined,
                enableIconContainer: true,
                isTabActive: false,
                onTap: () {
                  Navigator.pushNamed(context, AppRoute.donotdisturb);
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      color: CustomColor.dividerColor(context),
      indent: 68,
    );
  }
}